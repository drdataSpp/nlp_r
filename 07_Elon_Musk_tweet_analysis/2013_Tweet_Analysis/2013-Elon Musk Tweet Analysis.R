################################################################################
## R - NLP & Text Mining Project 3

## Analysis of 2013 time frame Elon Musk's Tweets.

################################################################################


################################################################################
## IMPORTING THE REQUIRED LIBRARIES 
################################################################################

library(tm)
library(twitteR)
library(ggplot2)
library(syuzhet)
library(tidytext)
library(wordcloud)

## TASK 1 - IMPORTING THE TWEETS

year3.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2013.csv")
head(year3.tweets.df$tweet)
year3.tweets.df2 <- year3.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year3.tweets.df2 <- gsub('http\\S+\\s*', '', year3.tweets.df2) ## Remove URLs
year3.tweets.df2 <- gsub('[^\x01-\x7F]', '', year3.tweets.df2) ## Removing Unwanted Chars
year3.tweets.df2 <- gsub('https:\\S+\\s*', '', year3.tweets.df2) ## Remove URLs
year3.tweets.df2 <- gsub('https\\S+\\s*', '', year3.tweets.df2) ## Remove URLs
year3.tweets.df2 <- gsub('\\b+RT', '', year3.tweets.df2) ## Remove RT
year3.tweets.df2 <- gsub('#\\S+', '', year3.tweets.df2) ## Remove Hashtags
year3.tweets.df2 <- gsub('@\\S+', '', year3.tweets.df2) ## Remove Mentions
year3.tweets.df2 <- gsub('[[:cntrl:]]', '', year3.tweets.df2) ## Remove Controls and special characters
year3.tweets.df2 <- gsub("\\d", '', year3.tweets.df2) ## Remove Controls and special characters
year3.tweets.df2 <- gsub('[[:punct:]]', '', year3.tweets.df2) ## Remove Punctuations
year3.tweets.df2 <- gsub("^[[:space:]]*","", year3.tweets.df2) ## Remove leading whitespaces
year3.tweets.df2 <- gsub("[[:space:]]*$","", year3.tweets.df2) ## Remove trailing whitespaces
year3.tweets.df2 <- gsub(' +',' ', year3.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year3.tweets.word.df <- as.vector(year3.tweets.df2)
year3.tweets.emotion.df <- get_nrc_sentiment(year3.tweets.word.df)
year3.tweets.emotion.df2 <- cbind(year3.tweets.df2, year3.tweets.emotion.df) 
head(year3.tweets.word.df)
head(year3.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year3.tweets.sent.value <- get_sentiment(year3.tweets.word.df)

year3.tweets.positive.tweets <- year3.tweets.word.df[year3.tweets.sent.value > 0]
year3.tweets.negative.tweets <- year3.tweets.word.df[year3.tweets.sent.value < 0]
year3.tweets.neutral.tweets <- year3.tweets.word.df[year3.tweets.sent.value == 0]

year3.tweets.most.positive <- year3.tweets.word.df[year3.tweets.sent.value == max(year3.tweets.sent.value)]
print(year3.tweets.most.positive)

year3.tweets.most.negative <- year3.tweets.word.df[year3.tweets.sent.value <= min(year3.tweets.sent.value)] 
print(year3.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year3.tweets.Positive <- length(year3.tweets.positive.tweets)
year3.tweets.Neutral <- length(year3.tweets.neutral.tweets)
year3.tweets.Negative <- length(year3.tweets.negative.tweets)

year3.tweets.Sentiments <- c(year3.tweets.Positive, year3.tweets.Neutral,
                             year3.tweets.Negative)

print(year3.tweets.Sentiments)

year3.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year3.tweets.Sentiments, year3.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2013)",
    col = rainbow(length(year3.tweets.Sentiments)))

legend('topright', year3.tweets.labels, cex=0.8,
       fill = rainbow(length(year3.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2013 ELON MUSK TWEETS

year3.tweets.tweet_corpus <- Corpus(VectorSource(year3.tweets.word.df))


year3.tweets.tdm <- TermDocumentMatrix(year3.tweets.tweet_corpus,
control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
            stopwords =  c("tweets") ,stopwords("english"),
            removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2013)

head(year3.tweets.tdm)
year3.tweets.DF <- tidy(year3.tweets.tdm)
head(year3.tweets.DF)
head(year3.tweets.DF$term)
year3.tweets.DF.texts <- as.vector(year3.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
year3.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year3.tweets.DF.texts))

year3.tweets.positive =sum(year3.tweets.DF.texts.Sentiment$positive)
year3.tweets.anger =sum(year3.tweets.DF.texts.Sentiment$anger)
year3.tweets.anticipation =sum(year3.tweets.DF.texts.Sentiment$anticipation)
year3.tweets.disgust =sum(year3.tweets.DF.texts.Sentiment$disgust)
year3.tweets.fear =sum(year3.tweets.DF.texts.Sentiment$fear)
year3.tweets.joy =sum(year3.tweets.DF.texts.Sentiment$joy)
year3.tweets.sadness =sum(year3.tweets.DF.texts.Sentiment$sadness)
year3.tweets.surprise =sum(year3.tweets.DF.texts.Sentiment$surprise)
year3.tweets.trust =sum(year3.tweets.DF.texts.Sentiment$trust)
year3.tweets.negative =sum(year3.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
year3.tweets.yAxis <- c(year3.tweets.positive,
                        + year3.tweets.anger,
                        + year3.tweets.anticipation,
                        + year3.tweets.disgust,
                        + year3.tweets.fear,
                        + year3.tweets.joy,
                        + year3.tweets.sadness,
                        + year3.tweets.surprise,
                        + year3.tweets.trust,
                        + year3.tweets.negative)

year3.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

year3.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

year3.tweets.yRange <- range(0, year3.tweets.yAxis) 

barplot(year3.tweets.yAxis, names.arg = year3.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2013) SENTIMENT ANALYSIS", 
        col = year3.tweets.colors, border = "black", ylim = year3.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year3.tweets.tdm.matrix <- as.matrix(year3.tweets.tdm)

year3.tweets.word_freqs <- sort(rowSums(year3.tweets.tdm.matrix), decreasing=TRUE) 
year3.tweets.dm <- data.frame(word=names(year3.tweets.word_freqs), freq=year3.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year3.tweets.dm$word, year3.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################

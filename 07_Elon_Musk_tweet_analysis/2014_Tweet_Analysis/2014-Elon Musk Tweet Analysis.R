################################################################################
## R - NLP & Text Mining Project 4

## Analysis of 2014 time frame Elon Musk's Tweets.

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

year4.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2014.csv")
head(year4.tweets.df$tweet)
year4.tweets.df2 <- year4.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year4.tweets.df2 <- gsub('http\\S+\\s*', '', year4.tweets.df2) ## Remove URLs
year4.tweets.df2 <- gsub('[^\x01-\x7F]', '', year4.tweets.df2) ## Removing Unwanted Chars
year4.tweets.df2 <- gsub('https:\\S+\\s*', '', year4.tweets.df2) ## Remove URLs
year4.tweets.df2 <- gsub('https\\S+\\s*', '', year4.tweets.df2) ## Remove URLs
year4.tweets.df2 <- gsub('\\b+RT', '', year4.tweets.df2) ## Remove RT
year4.tweets.df2 <- gsub('#\\S+', '', year4.tweets.df2) ## Remove Hashtags
year4.tweets.df2 <- gsub('@\\S+', '', year4.tweets.df2) ## Remove Mentions
year4.tweets.df2 <- gsub('[[:cntrl:]]', '', year4.tweets.df2) ## Remove Controls and special characters
year4.tweets.df2 <- gsub("\\d", '', year4.tweets.df2) ## Remove Controls and special characters
year4.tweets.df2 <- gsub('[[:punct:]]', '', year4.tweets.df2) ## Remove Punctuations
year4.tweets.df2 <- gsub("^[[:space:]]*","", year4.tweets.df2) ## Remove leading whitespaces
year4.tweets.df2 <- gsub("[[:space:]]*$","", year4.tweets.df2) ## Remove trailing whitespaces
year4.tweets.df2 <- gsub(' +',' ', year4.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year4.tweets.word.df <- as.vector(year4.tweets.df2)
year4.tweets.emotion.df <- get_nrc_sentiment(year4.tweets.word.df)
year4.tweets.emotion.df2 <- cbind(year4.tweets.df2, year4.tweets.emotion.df) 
head(year4.tweets.word.df)
head(year4.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year4.tweets.sent.value <- get_sentiment(year4.tweets.word.df)

year4.tweets.positive.tweets <- year4.tweets.word.df[year4.tweets.sent.value > 0]
year4.tweets.negative.tweets <- year4.tweets.word.df[year4.tweets.sent.value < 0]
year4.tweets.neutral.tweets <- year4.tweets.word.df[year4.tweets.sent.value == 0]

year4.tweets.most.positive <- year4.tweets.word.df[year4.tweets.sent.value == max(year4.tweets.sent.value)]
print(year4.tweets.most.positive)

year4.tweets.most.negative <- year4.tweets.word.df[year4.tweets.sent.value <= min(year4.tweets.sent.value)] 
print(year4.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year4.tweets.Positive <- length(year4.tweets.positive.tweets)
year4.tweets.Neutral <- length(year4.tweets.neutral.tweets)
year4.tweets.Negative <- length(year4.tweets.negative.tweets)

year4.tweets.Sentiments <- c(year4.tweets.Positive, year4.tweets.Neutral,
                             year4.tweets.Negative)

print(year4.tweets.Sentiments)

year4.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year4.tweets.Sentiments, year4.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2014)",
    col = rainbow(length(year4.tweets.Sentiments)))

legend('topright', year4.tweets.labels, cex=0.8,
       fill = rainbow(length(year4.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2014 ELON MUSK TWEETS

year4.tweets.tweet_corpus <- Corpus(VectorSource(year4.tweets.word.df))


year4.tweets.tdm <- TermDocumentMatrix(year4.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2014)

head(year4.tweets.tdm)
year4.tweets.DF <- tidy(year4.tweets.tdm)
head(year4.tweets.DF)
head(year4.tweets.DF$term)
year4.tweets.DF.texts <- as.vector(year4.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
year4.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year4.tweets.DF.texts))

year4.tweets.positive =sum(year4.tweets.DF.texts.Sentiment$positive)
year4.tweets.anger =sum(year4.tweets.DF.texts.Sentiment$anger)
year4.tweets.anticipation =sum(year4.tweets.DF.texts.Sentiment$anticipation)
year4.tweets.disgust =sum(year4.tweets.DF.texts.Sentiment$disgust)
year4.tweets.fear =sum(year4.tweets.DF.texts.Sentiment$fear)
year4.tweets.joy =sum(year4.tweets.DF.texts.Sentiment$joy)
year4.tweets.sadness =sum(year4.tweets.DF.texts.Sentiment$sadness)
year4.tweets.surprise =sum(year4.tweets.DF.texts.Sentiment$surprise)
year4.tweets.trust =sum(year4.tweets.DF.texts.Sentiment$trust)
year4.tweets.negative =sum(year4.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
year4.tweets.yAxis <- c(year4.tweets.positive,
                        + year4.tweets.anger,
                        + year4.tweets.anticipation,
                        + year4.tweets.disgust,
                        + year4.tweets.fear,
                        + year4.tweets.joy,
                        + year4.tweets.sadness,
                        + year4.tweets.surprise,
                        + year4.tweets.trust,
                        + year4.tweets.negative)

year4.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

year4.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

year4.tweets.yRange <- range(0, year4.tweets.yAxis) 

barplot(year4.tweets.yAxis, names.arg = year4.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2014) SENTIMENT ANALYSIS", 
        col = year4.tweets.colors, border = "black", ylim = year4.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year4.tweets.tdm.matrix <- as.matrix(year4.tweets.tdm)

year4.tweets.word_freqs <- sort(rowSums(year4.tweets.tdm.matrix), decreasing=TRUE) 
year4.tweets.dm <- data.frame(word=names(year4.tweets.word_freqs), freq=year4.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year4.tweets.dm$word, year4.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
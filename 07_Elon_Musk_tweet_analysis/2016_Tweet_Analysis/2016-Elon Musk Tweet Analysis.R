################################################################################
## R - NLP & Text Mining Project 6

## Analysis of 2016 time frame Elon Musk's Tweets.

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

year6.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2016.csv")
head(year6.tweets.df$tweet)
year6.tweets.df2 <- year6.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year6.tweets.df2 <- gsub('http\\S+\\s*', '', year6.tweets.df2) ## Remove URLs
year6.tweets.df2 <- gsub('[^\x01-\x7F]', '', year6.tweets.df2) ## Removing Unwanted Chars
year6.tweets.df2 <- gsub('https:\\S+\\s*', '', year6.tweets.df2) ## Remove URLs
year6.tweets.df2 <- gsub('https\\S+\\s*', '', year6.tweets.df2) ## Remove URLs
year6.tweets.df2 <- gsub('\\b+RT', '', year6.tweets.df2) ## Remove RT
year6.tweets.df2 <- gsub('#\\S+', '', year6.tweets.df2) ## Remove Hashtags
year6.tweets.df2 <- gsub('@\\S+', '', year6.tweets.df2) ## Remove Mentions
year6.tweets.df2 <- gsub('[[:cntrl:]]', '', year6.tweets.df2) ## Remove Controls and special characters
year6.tweets.df2 <- gsub("\\d", '', year6.tweets.df2) ## Remove Controls and special characters
year6.tweets.df2 <- gsub('[[:punct:]]', '', year6.tweets.df2) ## Remove Punctuations
year6.tweets.df2 <- gsub("^[[:space:]]*","", year6.tweets.df2) ## Remove leading whitespaces
year6.tweets.df2 <- gsub("[[:space:]]*$","", year6.tweets.df2) ## Remove trailing whitespaces
year6.tweets.df2 <- gsub(' +',' ', year6.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year6.tweets.word.df <- as.vector(year6.tweets.df2)
year6.tweets.emotion.df <- get_nrc_sentiment(year6.tweets.word.df)
year6.tweets.emotion.df2 <- cbind(year6.tweets.df2, year6.tweets.emotion.df) 
head(year6.tweets.word.df)
head(year6.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year6.tweets.sent.value <- get_sentiment(year6.tweets.word.df)

year6.tweets.positive.tweets <- year6.tweets.word.df[year6.tweets.sent.value > 0]
year6.tweets.negative.tweets <- year6.tweets.word.df[year6.tweets.sent.value < 0]
year6.tweets.neutral.tweets <- year6.tweets.word.df[year6.tweets.sent.value == 0]

year6.tweets.most.positive <- year6.tweets.word.df[year6.tweets.sent.value == max(year6.tweets.sent.value)]
print(year6.tweets.most.positive)

year6.tweets.most.negative <- year6.tweets.word.df[year6.tweets.sent.value <= min(year6.tweets.sent.value)] 
print(year6.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year6.tweets.Positive <- length(year6.tweets.positive.tweets)
year6.tweets.Neutral <- length(year6.tweets.neutral.tweets)
year6.tweets.Negative <- length(year6.tweets.negative.tweets)

year6.tweets.Sentiments <- c(year6.tweets.Positive, year6.tweets.Neutral,
                             year6.tweets.Negative)

print(year6.tweets.Sentiments)

year6.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year6.tweets.Sentiments, year6.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2016)",
    col = rainbow(length(year6.tweets.Sentiments)))

legend('topright', year6.tweets.labels, cex=0.8,
       fill = rainbow(length(year6.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2016 ELON MUSK TWEETS

year6.tweets.tweet_corpus <- Corpus(VectorSource(year6.tweets.word.df))


year6.tweets.tdm <- TermDocumentMatrix(year6.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2016)

head(year6.tweets.tdm)
year6.tweets.DF <- tidy(year6.tweets.tdm)
head(year6.tweets.DF)
head(year6.tweets.DF$term)
year6.tweets.DF.texts <- as.vector(year6.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
year6.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year6.tweets.DF.texts))

year6.tweets.positive =sum(year6.tweets.DF.texts.Sentiment$positive)
year6.tweets.anger =sum(year6.tweets.DF.texts.Sentiment$anger)
year6.tweets.anticipation =sum(year6.tweets.DF.texts.Sentiment$anticipation)
year6.tweets.disgust =sum(year6.tweets.DF.texts.Sentiment$disgust)
year6.tweets.fear =sum(year6.tweets.DF.texts.Sentiment$fear)
year6.tweets.joy =sum(year6.tweets.DF.texts.Sentiment$joy)
year6.tweets.sadness =sum(year6.tweets.DF.texts.Sentiment$sadness)
year6.tweets.surprise =sum(year6.tweets.DF.texts.Sentiment$surprise)
year6.tweets.trust =sum(year6.tweets.DF.texts.Sentiment$trust)
year6.tweets.negative =sum(year6.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
year6.tweets.yAxis <- c(year6.tweets.positive,
                        + year6.tweets.anger,
                        + year6.tweets.anticipation,
                        + year6.tweets.disgust,
                        + year6.tweets.fear,
                        + year6.tweets.joy,
                        + year6.tweets.sadness,
                        + year6.tweets.surprise,
                        + year6.tweets.trust,
                        + year6.tweets.negative)

year6.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

year6.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

year6.tweets.yRange <- range(0, year6.tweets.yAxis) 

barplot(year6.tweets.yAxis, names.arg = year6.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2016) SENTIMENT ANALYSIS", 
        col = year6.tweets.colors, border = "black", ylim = year6.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year6.tweets.tdm.matrix <- as.matrix(year6.tweets.tdm)

year6.tweets.word_freqs <- sort(rowSums(year6.tweets.tdm.matrix), decreasing=TRUE) 
year6.tweets.dm <- data.frame(word=names(year6.tweets.word_freqs), freq=year6.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year6.tweets.dm$word, year6.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
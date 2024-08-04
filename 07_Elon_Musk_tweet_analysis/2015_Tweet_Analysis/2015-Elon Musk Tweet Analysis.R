################################################################################
## R - NLP & Text Mining Project 5

## Analysis of 2015 time frame Elon Musk's Tweets.

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

year5.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2015.csv")
head(year5.tweets.df$tweet)
year5.tweets.df2 <- year5.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year5.tweets.df2 <- gsub('http\\S+\\s*', '', year5.tweets.df2) ## Remove URLs
year5.tweets.df2 <- gsub('[^\x01-\x7F]', '', year5.tweets.df2) ## Removing Unwanted Chars
year5.tweets.df2 <- gsub('https:\\S+\\s*', '', year5.tweets.df2) ## Remove URLs
year5.tweets.df2 <- gsub('https\\S+\\s*', '', year5.tweets.df2) ## Remove URLs
year5.tweets.df2 <- gsub('\\b+RT', '', year5.tweets.df2) ## Remove RT
year5.tweets.df2 <- gsub('#\\S+', '', year5.tweets.df2) ## Remove Hashtags
year5.tweets.df2 <- gsub('@\\S+', '', year5.tweets.df2) ## Remove Mentions
year5.tweets.df2 <- gsub('[[:cntrl:]]', '', year5.tweets.df2) ## Remove Controls and special characters
year5.tweets.df2 <- gsub("\\d", '', year5.tweets.df2) ## Remove Controls and special characters
year5.tweets.df2 <- gsub('[[:punct:]]', '', year5.tweets.df2) ## Remove Punctuations
year5.tweets.df2 <- gsub("^[[:space:]]*","", year5.tweets.df2) ## Remove leading whitespaces
year5.tweets.df2 <- gsub("[[:space:]]*$","", year5.tweets.df2) ## Remove trailing whitespaces
year5.tweets.df2 <- gsub(' +',' ', year5.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year5.tweets.word.df <- as.vector(year5.tweets.df2)
year5.tweets.emotion.df <- get_nrc_sentiment(year5.tweets.word.df)
year5.tweets.emotion.df2 <- cbind(year5.tweets.df2, year5.tweets.emotion.df) 
head(year5.tweets.word.df)
head(year5.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year5.tweets.sent.value <- get_sentiment(year5.tweets.word.df)

year5.tweets.positive.tweets <- year5.tweets.word.df[year5.tweets.sent.value > 0]
year5.tweets.negative.tweets <- year5.tweets.word.df[year5.tweets.sent.value < 0]
year5.tweets.neutral.tweets <- year5.tweets.word.df[year5.tweets.sent.value == 0]

year5.tweets.most.positive <- year5.tweets.word.df[year5.tweets.sent.value == max(year5.tweets.sent.value)]
print(year5.tweets.most.positive)

year5.tweets.most.negative <- year5.tweets.word.df[year5.tweets.sent.value <= min(year5.tweets.sent.value)] 
print(year5.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year5.tweets.Positive <- length(year5.tweets.positive.tweets)
year5.tweets.Neutral <- length(year5.tweets.neutral.tweets)
year5.tweets.Negative <- length(year5.tweets.negative.tweets)

year5.tweets.Sentiments <- c(year5.tweets.Positive, year5.tweets.Neutral,
                             year5.tweets.Negative)

print(year5.tweets.Sentiments)

year5.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year5.tweets.Sentiments, year5.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2015)",
    col = rainbow(length(year5.tweets.Sentiments)))

legend('topright', year5.tweets.labels, cex=0.8,
       fill = rainbow(length(year5.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2015 ELON MUSK TWEETS

year5.tweets.tweet_corpus <- Corpus(VectorSource(year5.tweets.word.df))


year5.tweets.tdm <- TermDocumentMatrix(year5.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2015)

head(year5.tweets.tdm)
year5.tweets.DF <- tidy(year5.tweets.tdm)
head(year5.tweets.DF)
head(year5.tweets.DF$term)
year5.tweets.DF.texts <- as.vector(year5.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
year5.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year5.tweets.DF.texts))

year5.tweets.positive =sum(year5.tweets.DF.texts.Sentiment$positive)
year5.tweets.anger =sum(year5.tweets.DF.texts.Sentiment$anger)
year5.tweets.anticipation =sum(year5.tweets.DF.texts.Sentiment$anticipation)
year5.tweets.disgust =sum(year5.tweets.DF.texts.Sentiment$disgust)
year5.tweets.fear =sum(year5.tweets.DF.texts.Sentiment$fear)
year5.tweets.joy =sum(year5.tweets.DF.texts.Sentiment$joy)
year5.tweets.sadness =sum(year5.tweets.DF.texts.Sentiment$sadness)
year5.tweets.surprise =sum(year5.tweets.DF.texts.Sentiment$surprise)
year5.tweets.trust =sum(year5.tweets.DF.texts.Sentiment$trust)
year5.tweets.negative =sum(year5.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
year5.tweets.yAxis <- c(year5.tweets.positive,
                        + year5.tweets.anger,
                        + year5.tweets.anticipation,
                        + year5.tweets.disgust,
                        + year5.tweets.fear,
                        + year5.tweets.joy,
                        + year5.tweets.sadness,
                        + year5.tweets.surprise,
                        + year5.tweets.trust,
                        + year5.tweets.negative)

year5.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

year5.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

year5.tweets.yRange <- range(0, year5.tweets.yAxis) 

barplot(year5.tweets.yAxis, names.arg = year5.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2015) SENTIMENT ANALYSIS", 
        col = year5.tweets.colors, border = "black", ylim = year5.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year5.tweets.tdm.matrix <- as.matrix(year5.tweets.tdm)

year5.tweets.word_freqs <- sort(rowSums(year5.tweets.tdm.matrix), decreasing=TRUE) 
year5.tweets.dm <- data.frame(word=names(year5.tweets.word_freqs), freq=year5.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year5.tweets.dm$word, year5.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
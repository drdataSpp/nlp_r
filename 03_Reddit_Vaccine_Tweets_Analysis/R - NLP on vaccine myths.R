################################################################################
## R - NLP & Text Mining Project.

## Analysis of Reddit Vaccine Myths.

################################################################################

################################################################################
## INSTALLING THE REQUIRED LIBRARIES 
################################################################################

# install.packages(tm)
# install.packages(twitteR)
# install.packages(ggplot2)
# install.packages(syuzhet)
# install.packages(tidytext)
# install.packages(wordcloud)
# install.packages(dplyr)

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

vaccine.myth.tweets.df <- read.csv("D:/001_Data/NLP/Reddit Vaccine Tweets/reddit_vm.csv")
head(vaccine.myth.tweets.df$body)
vaccine.myth.tweets.df2 <- vaccine.myth.tweets.df$body


## TASK 2 - CLEANING THE TWEETS

vaccine.myth.tweets.df2 <- gsub('http\\S+\\s*', '', vaccine.myth.tweets.df2) ## Remove URLs
vaccine.myth.tweets.df2 <- gsub('[^\x01-\x7F]', '', vaccine.myth.tweets.df2) ## Removing Unwanted Chars
vaccine.myth.tweets.df2 <- gsub('https:\\S+\\s*', '', vaccine.myth.tweets.df2) ## Remove URLs
vaccine.myth.tweets.df2 <- gsub('https\\S+\\s*', '', vaccine.myth.tweets.df2) ## Remove URLs
vaccine.myth.tweets.df2 <- gsub('\\b+RT', '', vaccine.myth.tweets.df2) ## Remove RT
vaccine.myth.tweets.df2 <- gsub('#\\S+', '', vaccine.myth.tweets.df2) ## Remove Hashtags
vaccine.myth.tweets.df2 <- gsub('@\\S+', '', vaccine.myth.tweets.df2) ## Remove Mentions
vaccine.myth.tweets.df2 <- gsub('[[:cntrl:]]', '', vaccine.myth.tweets.df2) ## Remove Controls and special characters
vaccine.myth.tweets.df2 <- gsub("\\d", '', vaccine.myth.tweets.df2) ## Remove Controls and special characters
vaccine.myth.tweets.df2 <- gsub('[[:punct:]]', '', vaccine.myth.tweets.df2) ## Remove Punctuations
vaccine.myth.tweets.df2 <- gsub("^[[:space:]]*","", vaccine.myth.tweets.df2) ## Remove leading whitespaces
vaccine.myth.tweets.df2 <- gsub("[[:space:]]*$","", vaccine.myth.tweets.df2) ## Remove trailing whitespaces
vaccine.myth.tweets.df2 <- gsub(' +',' ', vaccine.myth.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

vaccine.myth.tweets.word.df <- as.vector(vaccine.myth.tweets.df2)
vaccine.myth.tweets.emotion.df <- get_nrc_sentiment(vaccine.myth.tweets.word.df)
vaccine.myth.tweets.emotion.df2 <- cbind(vaccine.myth.tweets.df2, vaccine.myth.tweets.emotion.df) 
head(vaccine.myth.tweets.word.df)
head(vaccine.myth.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET

vaccine.myth.tweets.sent.value <- get_sentiment(vaccine.myth.tweets.word.df)

vaccine.myth.tweets.positive.tweets <- vaccine.myth.tweets.word.df[vaccine.myth.tweets.sent.value > 0]
vaccine.myth.tweets.negative.tweets <- vaccine.myth.tweets.word.df[vaccine.myth.tweets.sent.value < 0]
vaccine.myth.tweets.neutral.tweets <- vaccine.myth.tweets.word.df[vaccine.myth.tweets.sent.value == 0]

vaccine.myth.tweets.most.positive <- vaccine.myth.tweets.word.df[vaccine.myth.tweets.sent.value == max(vaccine.myth.tweets.sent.value)]
print(vaccine.myth.tweets.most.positive)

vaccine.myth.tweets.most.negative <- vaccine.myth.tweets.word.df[vaccine.myth.tweets.sent.value <= min(vaccine.myth.tweets.sent.value)] 
print(vaccine.myth.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

vaccine.myth.tweets.Positive <- length(vaccine.myth.tweets.positive.tweets)
vaccine.myth.tweets.Neutral <- length(vaccine.myth.tweets.neutral.tweets)
vaccine.myth.tweets.Negative <- length(vaccine.myth.tweets.negative.tweets)

vaccine.myth.tweets.Sentiments <- c(vaccine.myth.tweets.Positive, vaccine.myth.tweets.Neutral,
                                      vaccine.myth.tweets.Negative)

print(vaccine.myth.tweets.Sentiments)

vaccine.myth.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(vaccine.myth.tweets.Sentiments, vaccine.myth.tweets.Sentiments,
    main = "Sentiment Analysis on vaccine myth tweets",
    col = rainbow(length(vaccine.myth.tweets.Sentiments)))

legend('topright', vaccine.myth.tweets.labels, cex=0.8,
       fill = rainbow(length(vaccine.myth.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF THE TWEETS

vaccine.myth.tweets.tweet_corpus <- Corpus(VectorSource(vaccine.myth.tweets.word.df))


vaccine.myth.tweets.tdm <- TermDocumentMatrix(vaccine.myth.tweets.tweet_corpus,
                                                control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                               stopwords =  c("RT") ,stopwords("english"),
                                                               removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM THE TWEETS

head(vaccine.myth.tweets.tdm)
vaccine.myth.tweets.DF <- tidy(vaccine.myth.tweets.tdm)
head(vaccine.myth.tweets.DF)
head(vaccine.myth.tweets.DF$term)
vaccine.myth.tweets.DF.texts <- as.vector(vaccine.myth.tweets.DF$term)

# EMOTIONS FROM THE TWEETS
vaccine.myth.tweets.DF.texts.Sentiment<-get_nrc_sentiment((vaccine.myth.tweets.DF.texts))

vaccine.myth.tweets.positive =sum(vaccine.myth.tweets.DF.texts.Sentiment$positive)
vaccine.myth.tweets.anger =sum(vaccine.myth.tweets.DF.texts.Sentiment$anger)
vaccine.myth.tweets.anticipation =sum(vaccine.myth.tweets.DF.texts.Sentiment$anticipation)
vaccine.myth.tweets.disgust =sum(vaccine.myth.tweets.DF.texts.Sentiment$disgust)
vaccine.myth.tweets.fear =sum(vaccine.myth.tweets.DF.texts.Sentiment$fear)
vaccine.myth.tweets.joy =sum(vaccine.myth.tweets.DF.texts.Sentiment$joy)
vaccine.myth.tweets.sadness =sum(vaccine.myth.tweets.DF.texts.Sentiment$sadness)
vaccine.myth.tweets.surprise =sum(vaccine.myth.tweets.DF.texts.Sentiment$surprise)
vaccine.myth.tweets.trust =sum(vaccine.myth.tweets.DF.texts.Sentiment$trust)
vaccine.myth.tweets.negative =sum(vaccine.myth.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
vaccine.myth.tweets.yAxis <- c(vaccine.myth.tweets.positive,
                                 + vaccine.myth.tweets.anger,
                                 + vaccine.myth.tweets.anticipation,
                                 + vaccine.myth.tweets.disgust,
                                 + vaccine.myth.tweets.fear,
                                 + vaccine.myth.tweets.joy,
                                 + vaccine.myth.tweets.sadness,
                                 + vaccine.myth.tweets.surprise,
                                 + vaccine.myth.tweets.trust,
                                 + vaccine.myth.tweets.negative)

vaccine.myth.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                                 "Joy","Sadness","Surprise","Trust","Negative")

vaccine.myth.tweets.colors <- c("green","red","blue",
                                  "orange","red","green","orange","blue","green","red")

vaccine.myth.tweets.yRange <- range(0, vaccine.myth.tweets.yAxis) 

barplot(vaccine.myth.tweets.yAxis, names.arg = vaccine.myth.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "Bar Chart on vaccine myth tweets", 
        col = vaccine.myth.tweets.colors, border = "black", ylim = vaccine.myth.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


vaccine.myth.tweets.tdm.matrix <- as.matrix(vaccine.myth.tweets.tdm)

vaccine.myth.tweets.word_freqs <- sort(rowSums(vaccine.myth.tweets.tdm.matrix), decreasing=TRUE) 
vaccine.myth.tweets.dm <- data.frame(word=names(vaccine.myth.tweets.word_freqs), freq=vaccine.myth.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(vaccine.myth.tweets.dm$word, vaccine.myth.tweets.dm$freq, 
          min.freq = 20, max.words = 100, random.order=FALSE, 
          main="Word Cloud on India Currency vaccine.myth Tweets",
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
################################################################################
## R - NLP & Text Mining Project.

## Analysis of Negative Women's Ecommerce Clothing reviews.

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

negative.reviews.tweets.df <- read.csv("D:/001_Data/NLP/Women E-Commerce Reviews/negative-reviews.csv")
head(negative.reviews.tweets.df$Review)
negative.reviews.tweets.df2 <- negative.reviews.tweets.df$Review


## TASK 2 - CLEANING THE TWEETS

negative.reviews.tweets.df2 <- gsub('http\\S+\\s*', '', negative.reviews.tweets.df2) ## Remove URLs
negative.reviews.tweets.df2 <- gsub('[^\x01-\x7F]', '', negative.reviews.tweets.df2) ## Removing Unwanted Chars
negative.reviews.tweets.df2 <- gsub('https:\\S+\\s*', '', negative.reviews.tweets.df2) ## Remove URLs
negative.reviews.tweets.df2 <- gsub('https\\S+\\s*', '', negative.reviews.tweets.df2) ## Remove URLs
negative.reviews.tweets.df2 <- gsub('\\b+RT', '', negative.reviews.tweets.df2) ## Remove RT
negative.reviews.tweets.df2 <- gsub('#\\S+', '', negative.reviews.tweets.df2) ## Remove Hashtags
negative.reviews.tweets.df2 <- gsub('@\\S+', '', negative.reviews.tweets.df2) ## Remove Mentions
negative.reviews.tweets.df2 <- gsub('[[:cntrl:]]', '', negative.reviews.tweets.df2) ## Remove Controls and special characters
negative.reviews.tweets.df2 <- gsub("\\d", '', negative.reviews.tweets.df2) ## Remove Controls and special characters
negative.reviews.tweets.df2 <- gsub('[[:punct:]]', '', negative.reviews.tweets.df2) ## Remove Punctuations
negative.reviews.tweets.df2 <- gsub("^[[:space:]]*","", negative.reviews.tweets.df2) ## Remove leading whitespaces
negative.reviews.tweets.df2 <- gsub("[[:space:]]*$","", negative.reviews.tweets.df2) ## Remove trailing whitespaces
negative.reviews.tweets.df2 <- gsub(' +',' ', negative.reviews.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CONVERTING INTO VECTOR

negative.reviews.tweets.word.df <- as.vector(negative.reviews.tweets.df2)

## TASK 4 - TERM DOCUMENT MATRIX OF THE TWEETS

negative.reviews.tweets.tweet_corpus <- Corpus(VectorSource(negative.reviews.tweets.word.df))


negative.reviews.tweets.tdm <- TermDocumentMatrix(negative.reviews.tweets.tweet_corpus,
                control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                               stopwords = stopwords("english"),
                               removeNumbers = TRUE, tolower = TRUE))


## TASK 5 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

head(negative.reviews.tweets.tdm)
negative.reviews.tweets.DF <- tidy(negative.reviews.tweets.tdm)
head(negative.reviews.tweets.DF)
head(negative.reviews.tweets.DF$term)
negative.reviews.tweets.DF.texts <- as.vector(negative.reviews.tweets.DF$term)
negative.reviews.tweets.tdm.matrix <- as.matrix(negative.reviews.tweets.tdm)

negative.reviews.tweets.word_freqs <- sort(rowSums(negative.reviews.tweets.tdm.matrix), decreasing=TRUE) 
negative.reviews.tweets.dm <- data.frame(word=names(negative.reviews.tweets.word_freqs), freq=negative.reviews.tweets.word_freqs)

wordcloud(negative.reviews.tweets.dm$word, negative.reviews.tweets.dm$freq, 
          min.freq = 50, max.words = 50, random.order=FALSE, 
          main="Most used words in the Negative Reviews",
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
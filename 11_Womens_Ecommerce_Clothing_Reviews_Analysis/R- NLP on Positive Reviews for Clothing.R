################################################################################
## R - NLP & Text Mining Project.

## Analysis of Positive Women's Ecommerce Clothing reviews.

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
library(dplyr)

## TASK 1 - IMPORTING THE TWEETS

positive.reviews.tweets.df <- read.csv("D:/001_Data/NLP/Women E-Commerce Reviews/positive-reviews.csv")

dim(positive.reviews.tweets.df)
positive.reviews.tweets.df <- sample_n(positive.reviews.tweets.df, 5000)
dim(positive.reviews.tweets.df)

head(positive.reviews.tweets.df$Review)
dim(positive.reviews.tweets.df)
positive.reviews.tweets.df2 <- positive.reviews.tweets.df$Review


## TASK 2 - CLEANING THE TWEETS

positive.reviews.tweets.df2 <- gsub('http\\S+\\s*', '', positive.reviews.tweets.df2) ## Remove URLs
positive.reviews.tweets.df2 <- gsub('[^\x01-\x7F]', '', positive.reviews.tweets.df2) ## Removing Unwanted Chars
positive.reviews.tweets.df2 <- gsub('https:\\S+\\s*', '', positive.reviews.tweets.df2) ## Remove URLs
positive.reviews.tweets.df2 <- gsub('https\\S+\\s*', '', positive.reviews.tweets.df2) ## Remove URLs
positive.reviews.tweets.df2 <- gsub('\\b+RT', '', positive.reviews.tweets.df2) ## Remove RT
positive.reviews.tweets.df2 <- gsub('#\\S+', '', positive.reviews.tweets.df2) ## Remove Hashtags
positive.reviews.tweets.df2 <- gsub('@\\S+', '', positive.reviews.tweets.df2) ## Remove Mentions
positive.reviews.tweets.df2 <- gsub('[[:cntrl:]]', '', positive.reviews.tweets.df2) ## Remove Controls and special characters
positive.reviews.tweets.df2 <- gsub("\\d", '', positive.reviews.tweets.df2) ## Remove Controls and special characters
positive.reviews.tweets.df2 <- gsub('[[:punct:]]', '', positive.reviews.tweets.df2) ## Remove Punctuations
positive.reviews.tweets.df2 <- gsub("^[[:space:]]*","", positive.reviews.tweets.df2) ## Remove leading whitespaces
positive.reviews.tweets.df2 <- gsub("[[:space:]]*$","", positive.reviews.tweets.df2) ## Remove trailing whitespaces
positive.reviews.tweets.df2 <- gsub(' +',' ', positive.reviews.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CONVERTING INTO VECTOR

positive.reviews.tweets.word.df <- as.vector(positive.reviews.tweets.df2)

## TASK 4 - TERM DOCUMENT MATRIX OF THE TWEETS

positive.reviews.tweets.tweet_corpus <- Corpus(VectorSource(positive.reviews.tweets.word.df))


positive.reviews.tweets.tdm <- TermDocumentMatrix(positive.reviews.tweets.tweet_corpus,
                                                  control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                                 stopwords = stopwords("english"),
                                                                 removeNumbers = TRUE, tolower = TRUE))


## TASK 8 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

head(positive.reviews.tweets.tdm)
positive.reviews.tweets.DF <- tidy(positive.reviews.tweets.tdm)
head(positive.reviews.tweets.DF)
head(positive.reviews.tweets.DF$term)
positive.reviews.tweets.DF.texts <- as.vector(positive.reviews.tweets.DF$term)
positive.reviews.tweets.tdm.matrix <- as.matrix(positive.reviews.tweets.tdm)

positive.reviews.tweets.word_freqs <- sort(rowSums(positive.reviews.tweets.tdm.matrix), decreasing=TRUE) 
positive.reviews.tweets.dm <- data.frame(word=names(positive.reviews.tweets.word_freqs), freq=positive.reviews.tweets.word_freqs)

wordcloud(positive.reviews.tweets.dm$word, positive.reviews.tweets.dm$freq, 
          min.freq = 50, max.words = 50, random.order=FALSE, 
          main="Most used words in the Positive Reviews",
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
################################################################################
## R - NLP & Text Mining Project.

## Analysis of Positive & Negative Hotel reviews.

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
##------------------------------------------------------------------------------
hotel.reviews.tweets.df <- read.table(file="D:/001_Data/NLP/Hotel Reviews/Restaurant_Reviews.tsv",
                                         sep = "\t", header = T)


dim(hotel.reviews.tweets.df)
sum(is.na(hotel.reviews.tweets.df))
head(hotel.reviews.tweets.df)
tail(hotel.reviews.tweets.df)


## TASK 2 - SPLITING THE DATA
##------------------------------------------------------------------------------

positive.reviews <- filter(hotel.reviews.tweets.df, 
                           hotel.reviews.tweets.df$Liked == 1)

negative.reviews <- filter(hotel.reviews.tweets.df, 
                           hotel.reviews.tweets.df$Liked == 0)

print(dim(positive.reviews))
print(dim(negative.reviews))



## TASK 3 - CLEANING THE TWEETS
##------------------------------------------------------------------------------

positive.reviews.tweets.df2 <- positive.reviews$Review
negative.reviews.tweets.df2 <- negative.reviews$Review


## POSITIVE REVIEWS
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


## NEGATIVE REVIEWS
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
##------------------------------------------------------------------------------


## TASK 4 - CONVERTING INTO VECTOR
##------------------------------------------------------------------------------

positive.reviews.tweets.word.df <- as.vector(positive.reviews.tweets.df2)
negative.reviews.tweets.word.df <- as.vector(negative.reviews.tweets.df2)
##------------------------------------------------------------------------------


## TASK 5 - TERM DOCUMENT MATRIX OF THE TWEETS
##------------------------------------------------------------------------------

positive.reviews.tweets.tweet_corpus <- Corpus(VectorSource(positive.reviews.tweets.word.df))
negative.reviews.tweets.tweet_corpus <- Corpus(VectorSource(negative.reviews.tweets.word.df))


positive.reviews.tweets.tdm <- TermDocumentMatrix(positive.reviews.tweets.tweet_corpus,
                                                  control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                                 stopwords = stopwords("english"),
                                                                 removeNumbers = TRUE, tolower = TRUE))

negative.reviews.tweets.tdm <- TermDocumentMatrix(negative.reviews.tweets.tweet_corpus,
                                                  control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                                 stopwords = stopwords("english"),
                                                                 removeNumbers = TRUE, tolower = TRUE))
##------------------------------------------------------------------------------


## TASK 6 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS
##------------------------------------------------------------------------------


## POSITIVE REVIEWS

head(positive.reviews.tweets.tdm)
positive.reviews.tweets.DF <- tidy(positive.reviews.tweets.tdm)
head(positive.reviews.tweets.DF)
head(positive.reviews.tweets.DF$term)
positive.reviews.tweets.DF.texts <- as.vector(positive.reviews.tweets.DF$term)
positive.reviews.tweets.tdm.matrix <- as.matrix(positive.reviews.tweets.tdm)

positive.reviews.tweets.word_freqs <- sort(rowSums(positive.reviews.tweets.tdm.matrix), decreasing=TRUE) 
positive.reviews.tweets.dm <- data.frame(word=names(positive.reviews.tweets.word_freqs), freq=positive.reviews.tweets.word_freqs)

wordcloud(positive.reviews.tweets.dm$word, positive.reviews.tweets.dm$freq, 
          min.freq = 3, max.words = 75, random.order=FALSE, 
          main="Most used words in the Positive Reviews",
          colors=brewer.pal(8, "Dark2"))


## NEGATIVE REVIEWS

head(negative.reviews.tweets.tdm)
negative.reviews.tweets.DF <- tidy(negative.reviews.tweets.tdm)
head(negative.reviews.tweets.DF)
head(negative.reviews.tweets.DF$term)
negative.reviews.tweets.DF.texts <- as.vector(negative.reviews.tweets.DF$term)
negative.reviews.tweets.tdm.matrix <- as.matrix(negative.reviews.tweets.tdm)

negative.reviews.tweets.word_freqs <- sort(rowSums(negative.reviews.tweets.tdm.matrix), decreasing=TRUE) 
negative.reviews.tweets.dm <- data.frame(word=names(negative.reviews.tweets.word_freqs), freq=negative.reviews.tweets.word_freqs)

wordcloud(negative.reviews.tweets.dm$word, negative.reviews.tweets.dm$freq, 
          min.freq = 3, max.words = 75, random.order=FALSE, 
          main="Most used words in the negative Reviews",
          colors=brewer.pal(8, "Dark2"))

## THE END

################################################################################
################################################################################
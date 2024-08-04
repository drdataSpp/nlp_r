################################################################################
## R - NLP & Text Mining Project.

## Analysis of Racist & Non-Racist tweets.

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
racist.tweets.df <- read.csv(file="D:\\001_Data\\NLP\\R\\Racisim Tweets\\twitter_racism_parsed_dataset.csv")


dim(racist.tweets.df)
sum(is.na(racist.tweets.df))
head(racist.tweets.df)
tail(racist.tweets.df)


## TASK 2 - SPLITING THE DATA
##------------------------------------------------------------------------------

racist.tweets <- filter(racist.tweets.df, 
                           racist.tweets.df$oh_label == 1)

non.racist.tweets <- filter(racist.tweets.df, 
                             racist.tweets.df$oh_label == 0)

print(dim(racist.tweets))
print(dim(non.racist.tweets))



## TASK 3 - CLEANING THE TWEETS
##------------------------------------------------------------------------------

racist.tweets.df2 <- racist.tweets$Text
non.racist.tweets.df2 <- non.racist.tweets$Text


## RACIST TWEETS
racist.tweets.df2 <- gsub('http\\S+\\s*', '', racist.tweets.df2) ## Remove URLs
racist.tweets.df2 <- gsub('[^\x01-\x7F]', '', racist.tweets.df2) ## Removing Unwanted Chars
racist.tweets.df2 <- gsub('https:\\S+\\s*', '', racist.tweets.df2) ## Remove URLs
racist.tweets.df2 <- gsub('https\\S+\\s*', '', racist.tweets.df2) ## Remove URLs
racist.tweets.df2 <- gsub('\\b+RT', '', racist.tweets.df2) ## Remove RT
racist.tweets.df2 <- gsub('#\\S+', '', racist.tweets.df2) ## Remove Hashtags
racist.tweets.df2 <- gsub('@\\S+', '', racist.tweets.df2) ## Remove Mentions
racist.tweets.df2 <- gsub('[[:cntrl:]]', '', racist.tweets.df2) ## Remove Controls and special characters
racist.tweets.df2 <- gsub("\\d", '', racist.tweets.df2) ## Remove Controls and special characters
racist.tweets.df2 <- gsub('[[:punct:]]', '', racist.tweets.df2) ## Remove Punctuations
racist.tweets.df2 <- gsub("^[[:space:]]*","", racist.tweets.df2) ## Remove leading whitespaces
racist.tweets.df2 <- gsub("[[:space:]]*$","", racist.tweets.df2) ## Remove trailing whitespaces
racist.tweets.df2 <- gsub(' +',' ', racist.tweets.df2) ## Remove extra whitespaces


## NON-RACIST TWEETS
non.racist.tweets.df2 <- gsub('http\\S+\\s*', '', non.racist.tweets.df2) ## Remove URLs
non.racist.tweets.df2 <- gsub('[^\x01-\x7F]', '', non.racist.tweets.df2) ## Removing Unwanted Chars
non.racist.tweets.df2 <- gsub('https:\\S+\\s*', '', non.racist.tweets.df2) ## Remove URLs
non.racist.tweets.df2 <- gsub('https\\S+\\s*', '', non.racist.tweets.df2) ## Remove URLs
non.racist.tweets.df2 <- gsub('\\b+RT', '', non.racist.tweets.df2) ## Remove RT
non.racist.tweets.df2 <- gsub('#\\S+', '', non.racist.tweets.df2) ## Remove Hashtags
non.racist.tweets.df2 <- gsub('@\\S+', '', non.racist.tweets.df2) ## Remove Mentions
non.racist.tweets.df2 <- gsub('[[:cntrl:]]', '', non.racist.tweets.df2) ## Remove Controls and special characters
non.racist.tweets.df2 <- gsub("\\d", '', non.racist.tweets.df2) ## Remove Controls and special characters
non.racist.tweets.df2 <- gsub('[[:punct:]]', '', non.racist.tweets.df2) ## Remove Punctuations
non.racist.tweets.df2 <- gsub("^[[:space:]]*","", non.racist.tweets.df2) ## Remove leading whitespaces
non.racist.tweets.df2 <- gsub("[[:space:]]*$","", non.racist.tweets.df2) ## Remove trailing whitespaces
non.racist.tweets.df2 <- gsub(' +',' ', non.racist.tweets.df2) ## Remove extra whitespaces
##------------------------------------------------------------------------------


## TASK 4 - CONVERTING INTO VECTOR
##------------------------------------------------------------------------------

racist.word.df <- as.vector(racist.tweets.df2)
non.racist.word.df <- as.vector(non.racist.tweets.df2)
##------------------------------------------------------------------------------


## TASK 5 - TERM DOCUMENT MATRIX OF THE TWEETS
##------------------------------------------------------------------------------

racist.corpus <- Corpus(VectorSource(racist.word.df))
non.racist.corpus <- Corpus(VectorSource(non.racist.word.df))


racist.tdm <- TermDocumentMatrix(racist.corpus,
                control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                               stopwords = stopwords("english"),
                               removeNumbers = TRUE, tolower = TRUE))

non.racist.tdm <- TermDocumentMatrix(non.racist.corpus,
                control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                               stopwords = stopwords("english"),
                               removeNumbers = TRUE, tolower = TRUE))
##------------------------------------------------------------------------------


## TASK 6 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS
##------------------------------------------------------------------------------


## RACIST TWEETS

head(racist.tdm)
racist.tweets.DF <- tidy(racist.tdm)
head(racist.tweets.DF)
head(racist.tweets.DF$term)
racist.tweets.DF.texts <- as.vector(racist.tweets.DF$term)
racist.tdm.matrix <- as.matrix(racist.tdm)
racist.tweets.word_freqs <- sort(rowSums(racist.tdm.matrix), decreasing=TRUE) 
racist.tweets.dm <- data.frame(word=names(racist.tweets.word_freqs), freq=racist.tweets.word_freqs)

wordcloud(racist.tweets.dm$word, racist.tweets.dm$freq, 
          min.freq = 15, max.words = 25, random.order=FALSE, 
          main="Most used words in the Racist Tweets",
          colors=brewer.pal(8, "Dark2"))


## NON RACIST TWEETS

head(non.racist.tdm)
non.racist.tweets.DF <- tidy(non.racist.tdm)
head(non.racist.tweets.DF)
head(non.racist.tweets.DF$term)
non.racist.tweets.DF.texts <- as.vector(non.racist.tweets.DF$term)
non.racist.tweets.tdm.matrix <- as.matrix(non.racist.tdm)
non.racist.tweets.word_freqs <- sort(rowSums(non.racist.tweets.tdm.matrix), decreasing=TRUE) 
non.racist.tweets.dm <- data.frame(word=names(non.racist.tweets.word_freqs), freq=non.racist.tweets.word_freqs)

wordcloud(non.racist.tweets.dm$word, non.racist.tweets.dm$freq, 
          min.freq = 15, max.words = 25, random.order=FALSE, 
          main="Most used words in the Non Racist Tweets",
          colors=brewer.pal(8, "Dark2"))

## THE END

################################################################################
################################################################################
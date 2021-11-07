################################################################################
## R - NLP & Text Mining Project 

# Analysis of the tweets based on different keywords such as killing, slavery, 
# soldering, enslavement, deportation/forcible transportation, illegal imprisonment, 
# political imprisonment, etc, which can be useful in monitoring Human Rights 
# Violation on Social Media platforms.

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
library(dplyr)

## TASK 1 - IMPORTING THE TWEETS
##------------------------------------------------------------------------------

tweet.df <- read.csv("D:\\001_Data\\NLP\\Data\\Human Rights Violation - tweets.csv")
head(tweet.df$Text)
tweet.df2 <- tweet.df$Text
length(tweet.df2)


## TASK 2 - CLEANING THE TWEETS
##------------------------------------------------------------------------------

tweet.df2 <- gsub('http\\S+\\s*', '', tweet.df2) ## Remove URLs
tweet.df2 <- gsub('https:\\S+\\s*', '', tweet.df2) ## Remove URLs
tweet.df2 <- gsub('https\\S+\\s*', '', tweet.df2) ## Remove URLs
tweet.df2 <- gsub('\\b+RT', '', tweet.df2) ## Remove RT
tweet.df2 <- gsub('#\\S+', '', tweet.df2) ## Remove Hashtags
tweet.df2 <- gsub('@\\S+', '', tweet.df2) ## Remove Mentions
tweet.df2 <- gsub('[[:cntrl:]]', '', tweet.df2) ## Remove Controls and special characters
tweet.df2 <- gsub("\\d", '', tweet.df2) ## Remove Controls and special characters
tweet.df2 <- gsub('[[:punct:]]', '', tweet.df2) ## Remove Punctuations
tweet.df2 <- gsub("^[[:space:]]*","", tweet.df2) ## Remove leading whitespaces
tweet.df2 <- gsub("[[:space:]]*$","", tweet.df2) ## Remove trailing whitespaces
tweet.df2 <- gsub(' +',' ', tweet.df2) ## Remove extra whitespaces
tweet.df2 <- gsub('[^[:graph:]]',' ', tweet.df2) ## Remove special chars



## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS
##------------------------------------------------------------------------------

word.df <- as.vector(tweet.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweet.df2, emotion.df) 
head(word.df)
head(emotion.df2)



## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET
##------------------------------------------------------------------------------

tweet.sent.value <- get_sentiment(word.df)

positive.tweets <- word.df[tweet.sent.value > 0]
negative.tweets <- word.df[tweet.sent.value < 0]
neutral.tweets <- word.df[tweet.sent.value == 0]

most.positive <- word.df[tweet.sent.value == max(tweet.sent.value)]
print(most.positive)

most.negative <- word.df[tweet.sent.value <= min(tweet.sent.value)] 
print(most.negative)



## TASK 5 - CREATING PIE CHART OF CALCULATED SENTIMENTS
##------------------------------------------------------------------------------

Tweet.Positive <- length(positive.tweets)
Tweet.Neutral <- length(neutral.tweets)
Tweet.Negative <- length(negative.tweets)

Tweet.Sentiments <- c(Tweet.Positive, Tweet.Neutral,
                      Tweet.Negative)

print(Tweet.Sentiments)

Tweet.labels <- c("Positive", "Negative", "Neutral")

pie(Tweet.Sentiments, Tweet.Sentiments,
    main = "Sentiment Analysis On Tweets",
    col = rainbow(length(Tweet.Sentiments)))

legend('topright', Tweet.labels, cex=0.8,
       fill = rainbow(length(Tweet.labels)))



## TASK 6 - TERM DOCUMENT MATRIX 
##------------------------------------------------------------------------------

tweet_corpus <- Corpus(VectorSource(word.df))


tweet.tdm <- TermDocumentMatrix(tweet_corpus,
                                     control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                    stopwords = c('comment', 'conspiracy', 'theory', 
                                                                  'theories', 'google'),stopwords("english"),
                                                    removeNumbers = TRUE, tolower = TRUE))

tweet.tdm.matrix <- as.matrix(tweet.tdm)

tweet.word_freqs <- sort(rowSums(tweet.tdm.matrix), decreasing=TRUE) 
tweet.dm <- data.frame(word=names(tweet.word_freqs), freq=tweet.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS
##------------------------------------------------------------------------------

wordcloud(tweet.dm$word, tweet.dm$freq, 
          min.freq = 3, max.words = 50, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
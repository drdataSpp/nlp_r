################################################################################
## R - NLP & Text Mining Project 

## Analysis of Tweets from Pfizer.

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
##------------------------------------------------------------------------------

pfizer.tweets.df <- read.csv("D:\\001_Data\\NLP\\R\\Pfizer Tweets\\vaccination_tweets.csv")
head(pfizer.tweets.df$text)
pfizer.tweets.df2 <- pfizer.tweets.df$text



## TASK 2 - CLEANING THE TWEETS
##------------------------------------------------------------------------------

pfizer.tweets.df2 <- gsub('http\\S+\\s*', '', pfizer.tweets.df2) ## Remove URLs
pfizer.tweets.df2 <- gsub('https:\\S+\\s*', '', pfizer.tweets.df2) ## Remove URLs
pfizer.tweets.df2 <- gsub('https\\S+\\s*', '', pfizer.tweets.df2) ## Remove URLs
pfizer.tweets.df2 <- gsub('\\b+RT', '', pfizer.tweets.df2) ## Remove RT
pfizer.tweets.df2 <- gsub('#\\S+', '', pfizer.tweets.df2) ## Remove Hashtags
pfizer.tweets.df2 <- gsub('@\\S+', '', pfizer.tweets.df2) ## Remove Mentions
pfizer.tweets.df2 <- gsub('[[:cntrl:]]', '', pfizer.tweets.df2) ## Remove Controls and special characters
pfizer.tweets.df2 <- gsub("\\d", '', pfizer.tweets.df2) ## Remove Controls and special characters
pfizer.tweets.df2 <- gsub('[[:punct:]]', '', pfizer.tweets.df2) ## Remove Punctuations
pfizer.tweets.df2 <- gsub("^[[:space:]]*","", pfizer.tweets.df2) ## Remove leading whitespaces
pfizer.tweets.df2 <- gsub("[[:space:]]*$","", pfizer.tweets.df2) ## Remove trailing whitespaces
pfizer.tweets.df2 <- gsub(' +',' ', pfizer.tweets.df2) ## Remove extra whitespaces
pfizer.tweets.df2 <- gsub('[^[:graph:]]',' ', pfizer.tweets.df2) ## Remove special chars



## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS
##------------------------------------------------------------------------------

pfizer.tweets.word.df <- as.vector(pfizer.tweets.df2)
pfizer.tweets.emotion.df <- get_nrc_sentiment(pfizer.tweets.word.df)
pfizer.tweets.emotion.df2 <- cbind(pfizer.tweets.df2, pfizer.tweets.emotion.df) 
head(pfizer.tweets.word.df)
head(pfizer.tweets.emotion.df2)



## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET
##------------------------------------------------------------------------------

pfizer.tweets.sent.value <- get_sentiment(pfizer.tweets.word.df)

pfizer.tweets.positive.tweets <- pfizer.tweets.word.df[pfizer.tweets.sent.value > 0]
pfizer.tweets.negative.tweets <- pfizer.tweets.word.df[pfizer.tweets.sent.value < 0]
pfizer.tweets.neutral.tweets <- pfizer.tweets.word.df[pfizer.tweets.sent.value == 0]

pfizer.tweets.most.positive <- pfizer.tweets.word.df[pfizer.tweets.sent.value == max(pfizer.tweets.sent.value)]
print(pfizer.tweets.most.positive)

pfizer.tweets.most.negative <- pfizer.tweets.word.df[pfizer.tweets.sent.value <= min(pfizer.tweets.sent.value)] 
print(pfizer.tweets.most.negative)



## TASK 5 - CREATING PIE CHART OF CALCULATED SENTIMENTS
##------------------------------------------------------------------------------

pfizer.tweets.Positive <- length(pfizer.tweets.positive.tweets)
pfizer.tweets.Neutral <- length(pfizer.tweets.neutral.tweets)
pfizer.tweets.Negative <- length(pfizer.tweets.negative.tweets)

pfizer.tweets.Sentiments <- c(pfizer.tweets.Positive, pfizer.tweets.Neutral,
                             pfizer.tweets.Negative)

print(pfizer.tweets.Sentiments)

pfizer.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(pfizer.tweets.Sentiments, pfizer.tweets.Sentiments,
    main = "Sentiment Analysis On Pfizer Tweets",
    col = rainbow(length(pfizer.tweets.Sentiments)))

legend('topright', pfizer.tweets.labels, cex=0.8,
       fill = rainbow(length(pfizer.tweets.labels)))



## TASK 6 - TERM DOCUMENT MATRIX OF PFIZER TWEETS
##------------------------------------------------------------------------------

pfizer.tweets.tweet_corpus <- Corpus(VectorSource(pfizer.tweets.word.df))


pfizer.tweets.tdm <- TermDocumentMatrix(pfizer.tweets.tweet_corpus,
control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
              stopwords("english"),
              removeNumbers = TRUE, tolower = TRUE))

pfizer.tweets.tdm.matrix <- as.matrix(pfizer.tweets.tdm)

pfizer.tweets.word_freqs <- sort(rowSums(pfizer.tweets.tdm.matrix), decreasing=TRUE) 
pfizer.tweets.dm <- data.frame(word=names(pfizer.tweets.word_freqs), freq=pfizer.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS
##------------------------------------------------------------------------------
  
wordcloud(pfizer.tweets.dm$word, pfizer.tweets.dm$freq, 
          min.freq = 10, max.words = 50, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
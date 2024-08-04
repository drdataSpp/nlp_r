################################################################################
## R - NLP & Text Mining Project 7

## Analysis of 2017 time frame Elon Musk's Tweets.

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

year7.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2017.csv")
head(year7.tweets.df$tweet)
year7.tweets.df2 <- year7.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year7.tweets.df2 <- gsub('http\\S+\\s*', '', year7.tweets.df2) ## Remove URLs
year7.tweets.df2 <- gsub('[^\x01-\x7F]', '', year7.tweets.df2) ## Removing Unwanted Chars
year7.tweets.df2 <- gsub('https:\\S+\\s*', '', year7.tweets.df2) ## Remove URLs
year7.tweets.df2 <- gsub('https\\S+\\s*', '', year7.tweets.df2) ## Remove URLs
year7.tweets.df2 <- gsub('\\b+RT', '', year7.tweets.df2) ## Remove RT
year7.tweets.df2 <- gsub('#\\S+', '', year7.tweets.df2) ## Remove Hashtags
year7.tweets.df2 <- gsub('@\\S+', '', year7.tweets.df2) ## Remove Mentions
year7.tweets.df2 <- gsub('[[:cntrl:]]', '', year7.tweets.df2) ## Remove Controls and special characters
year7.tweets.df2 <- gsub("\\d", '', year7.tweets.df2) ## Remove Controls and special characters
year7.tweets.df2 <- gsub('[[:punct:]]', '', year7.tweets.df2) ## Remove Punctuations
year7.tweets.df2 <- gsub("^[[:space:]]*","", year7.tweets.df2) ## Remove leading whitespaces
year7.tweets.df2 <- gsub("[[:space:]]*$","", year7.tweets.df2) ## Remove trailing whitespaces
year7.tweets.df2 <- gsub(' +',' ', year7.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year7.tweets.word.df <- as.vector(year7.tweets.df2)
year7.tweets.emotion.df <- get_nrc_sentiment(year7.tweets.word.df)
year7.tweets.emotion.df2 <- cbind(year7.tweets.df2, year7.tweets.emotion.df) 
head(year7.tweets.word.df)
head(year7.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year7.tweets.sent.value <- get_sentiment(year7.tweets.word.df)

year7.tweets.positive.tweets <- year7.tweets.word.df[year7.tweets.sent.value > 0]
year7.tweets.negative.tweets <- year7.tweets.word.df[year7.tweets.sent.value < 0]
year7.tweets.neutral.tweets <- year7.tweets.word.df[year7.tweets.sent.value == 0]

year7.tweets.most.positive <- year7.tweets.word.df[year7.tweets.sent.value == max(year7.tweets.sent.value)]
print(year7.tweets.most.positive)

year7.tweets.most.negative <- year7.tweets.word.df[year7.tweets.sent.value <= min(year7.tweets.sent.value)] 
print(year7.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year7.tweets.Positive <- length(year7.tweets.positive.tweets)
year7.tweets.Neutral <- length(year7.tweets.neutral.tweets)
year7.tweets.Negative <- length(year7.tweets.negative.tweets)

year7.tweets.Sentiments <- c(year7.tweets.Positive, year7.tweets.Neutral,
                             year7.tweets.Negative)

print(year7.tweets.Sentiments)

year7.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year7.tweets.Sentiments, year7.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2017)",
    col = rainbow(length(year7.tweets.Sentiments)))

legend('topright', year7.tweets.labels, cex=0.8,
       fill = rainbow(length(year7.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2017 ELON MUSK TWEETS

year7.tweets.tweet_corpus <- Corpus(VectorSource(year7.tweets.word.df))


year7.tweets.tdm <- TermDocumentMatrix(year7.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))


head(year7.tweets.tdm)
year7.tweets.DF <- tidy(year7.tweets.tdm)
head(year7.tweets.DF)
head(year7.tweets.DF$term)
year7.tweets.DF.texts <- as.vector(year7.tweets.DF$term)


year7.tweets.tdm.matrix <- as.matrix(year7.tweets.tdm)

year7.tweets.word_freqs <- sort(rowSums(year7.tweets.tdm.matrix), decreasing=TRUE) 
year7.tweets.dm <- data.frame(word=names(year7.tweets.word_freqs), freq=year7.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year7.tweets.dm$word, year7.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
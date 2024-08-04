################################################################################
## R - NLP & Text Mining Project 9

## Analysis of 2019 time frame Elon Musk's Tweets.

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

year9.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2019.csv")
head(year9.tweets.df$tweet)
year9.tweets.df2 <- year9.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year9.tweets.df2 <- gsub('http\\S+\\s*', '', year9.tweets.df2) ## Remove URLs
year9.tweets.df2 <- gsub('[^\x01-\x7F]', '', year9.tweets.df2) ## Removing Unwanted Chars
year9.tweets.df2 <- gsub('https:\\S+\\s*', '', year9.tweets.df2) ## Remove URLs
year9.tweets.df2 <- gsub('https\\S+\\s*', '', year9.tweets.df2) ## Remove URLs
year9.tweets.df2 <- gsub('\\b+RT', '', year9.tweets.df2) ## Remove RT
year9.tweets.df2 <- gsub('#\\S+', '', year9.tweets.df2) ## Remove Hashtags
year9.tweets.df2 <- gsub('@\\S+', '', year9.tweets.df2) ## Remove Mentions
year9.tweets.df2 <- gsub('[[:cntrl:]]', '', year9.tweets.df2) ## Remove Controls and special characters
year9.tweets.df2 <- gsub("\\d", '', year9.tweets.df2) ## Remove Controls and special characters
year9.tweets.df2 <- gsub('[[:punct:]]', '', year9.tweets.df2) ## Remove Punctuations
year9.tweets.df2 <- gsub("^[[:space:]]*","", year9.tweets.df2) ## Remove leading whitespaces
year9.tweets.df2 <- gsub("[[:space:]]*$","", year9.tweets.df2) ## Remove trailing whitespaces
year9.tweets.df2 <- gsub(' +',' ', year9.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year9.tweets.word.df <- as.vector(year9.tweets.df2)
year9.tweets.emotion.df <- get_nrc_sentiment(year9.tweets.word.df)
year9.tweets.emotion.df2 <- cbind(year9.tweets.df2, year9.tweets.emotion.df) 
head(year9.tweets.word.df)
head(year9.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year9.tweets.sent.value <- get_sentiment(year9.tweets.word.df)

year9.tweets.positive.tweets <- year9.tweets.word.df[year9.tweets.sent.value > 0]
year9.tweets.negative.tweets <- year9.tweets.word.df[year9.tweets.sent.value < 0]
year9.tweets.neutral.tweets <- year9.tweets.word.df[year9.tweets.sent.value == 0]

year9.tweets.most.positive <- year9.tweets.word.df[year9.tweets.sent.value == max(year9.tweets.sent.value)]
print(year9.tweets.most.positive)

year9.tweets.most.negative <- year9.tweets.word.df[year9.tweets.sent.value <= min(year9.tweets.sent.value)] 
print(year9.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year9.tweets.Positive <- length(year9.tweets.positive.tweets)
year9.tweets.Neutral <- length(year9.tweets.neutral.tweets)
year9.tweets.Negative <- length(year9.tweets.negative.tweets)

year9.tweets.Sentiments <- c(year9.tweets.Positive, year9.tweets.Neutral,
                             year9.tweets.Negative)

print(year9.tweets.Sentiments)

year9.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year9.tweets.Sentiments, year9.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2019)",
    col = rainbow(length(year9.tweets.Sentiments)))

legend('topright', year9.tweets.labels, cex=0.8,
       fill = rainbow(length(year9.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2019 ELON MUSK TWEETS

year9.tweets.tweet_corpus <- Corpus(VectorSource(year9.tweets.word.df))


year9.tweets.tdm <- TermDocumentMatrix(year9.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))


head(year9.tweets.tdm)
year9.tweets.DF <- tidy(year9.tweets.tdm)
head(year9.tweets.DF)
head(year9.tweets.DF$term)
year9.tweets.DF.texts <- as.vector(year9.tweets.DF$term)


year9.tweets.tdm.matrix <- as.matrix(year9.tweets.tdm)

year9.tweets.word_freqs <- sort(rowSums(year9.tweets.tdm.matrix), decreasing=TRUE) 
year9.tweets.dm <- data.frame(word=names(year9.tweets.word_freqs), freq=year9.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year9.tweets.dm$word, year9.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
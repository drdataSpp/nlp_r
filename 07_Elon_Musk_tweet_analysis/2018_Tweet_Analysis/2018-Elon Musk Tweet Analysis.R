################################################################################
## R - NLP & Text Mining Project 8

## Analysis of 2018 time frame Elon Musk's Tweets.

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

year8.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2018.csv")
head(year8.tweets.df$tweet)
year8.tweets.df2 <- year8.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year8.tweets.df2 <- gsub('http\\S+\\s*', '', year8.tweets.df2) ## Remove URLs
year8.tweets.df2 <- gsub('[^\x01-\x7F]', '', year8.tweets.df2) ## Removing Unwanted Chars
year8.tweets.df2 <- gsub('https:\\S+\\s*', '', year8.tweets.df2) ## Remove URLs
year8.tweets.df2 <- gsub('https\\S+\\s*', '', year8.tweets.df2) ## Remove URLs
year8.tweets.df2 <- gsub('\\b+RT', '', year8.tweets.df2) ## Remove RT
year8.tweets.df2 <- gsub('#\\S+', '', year8.tweets.df2) ## Remove Hashtags
year8.tweets.df2 <- gsub('@\\S+', '', year8.tweets.df2) ## Remove Mentions
year8.tweets.df2 <- gsub('[[:cntrl:]]', '', year8.tweets.df2) ## Remove Controls and special characters
year8.tweets.df2 <- gsub("\\d", '', year8.tweets.df2) ## Remove Controls and special characters
year8.tweets.df2 <- gsub('[[:punct:]]', '', year8.tweets.df2) ## Remove Punctuations
year8.tweets.df2 <- gsub("^[[:space:]]*","", year8.tweets.df2) ## Remove leading whitespaces
year8.tweets.df2 <- gsub("[[:space:]]*$","", year8.tweets.df2) ## Remove trailing whitespaces
year8.tweets.df2 <- gsub(' +',' ', year8.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year8.tweets.word.df <- as.vector(year8.tweets.df2)
year8.tweets.emotion.df <- get_nrc_sentiment(year8.tweets.word.df)
year8.tweets.emotion.df2 <- cbind(year8.tweets.df2, year8.tweets.emotion.df) 
head(year8.tweets.word.df)
head(year8.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year8.tweets.sent.value <- get_sentiment(year8.tweets.word.df)

year8.tweets.positive.tweets <- year8.tweets.word.df[year8.tweets.sent.value > 0]
year8.tweets.negative.tweets <- year8.tweets.word.df[year8.tweets.sent.value < 0]
year8.tweets.neutral.tweets <- year8.tweets.word.df[year8.tweets.sent.value == 0]

year8.tweets.most.positive <- year8.tweets.word.df[year8.tweets.sent.value == max(year8.tweets.sent.value)]
print(year8.tweets.most.positive)

year8.tweets.most.negative <- year8.tweets.word.df[year8.tweets.sent.value <= min(year8.tweets.sent.value)] 
print(year8.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year8.tweets.Positive <- length(year8.tweets.positive.tweets)
year8.tweets.Neutral <- length(year8.tweets.neutral.tweets)
year8.tweets.Negative <- length(year8.tweets.negative.tweets)

year8.tweets.Sentiments <- c(year8.tweets.Positive, year8.tweets.Neutral,
                             year8.tweets.Negative)

print(year8.tweets.Sentiments)

year8.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year8.tweets.Sentiments, year8.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2018)",
    col = rainbow(length(year8.tweets.Sentiments)))

legend('topright', year8.tweets.labels, cex=0.8,
       fill = rainbow(length(year8.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2018 ELON MUSK TWEETS

year8.tweets.tweet_corpus <- Corpus(VectorSource(year8.tweets.word.df))


year8.tweets.tdm <- TermDocumentMatrix(year8.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                      stopwords =  c("tweets") ,stopwords("english"),
                                                      removeNumbers = TRUE, tolower = TRUE))


head(year8.tweets.tdm)
year8.tweets.DF <- tidy(year8.tweets.tdm)
head(year8.tweets.DF)
head(year8.tweets.DF$term)
year8.tweets.DF.texts <- as.vector(year8.tweets.DF$term)


year8.tweets.tdm.matrix <- as.matrix(year8.tweets.tdm)

year8.tweets.word_freqs <- sort(rowSums(year8.tweets.tdm.matrix), decreasing=TRUE) 
year8.tweets.dm <- data.frame(word=names(year8.tweets.word_freqs), freq=year8.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year8.tweets.dm$word, year8.tweets.dm$freq, 
          min.freq = 10, max.words = 100, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
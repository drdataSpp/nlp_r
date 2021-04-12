## INDIA DEMONITIZATION DATA
##------------------------------------------------------------------------------

library('wordcloud')
library('tm')
library('SnowballC')
library('RWeka')
library('RSentiment')
library('DT')
library('tm')
library('twitteR')
library('ggplot2') # Data visualization
library('syuzhet')
library('tidytext')

##------------------------------------------------------------------------------

demonetization.df <- read.csv("D:\\001_Data\\NLP\\India Demonitization\\Demonetization_data29th.csv")

head(demonetization.df)
tail(demonetization.df)

tweets.df2 <- gsub("[^\x01-\x7F]", "", demonetization.df$CONTENT)
tweets.df2 <- gsub("@.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("http.*","",tweets.df2)
tweets.df2 <- gsub("https:*","",tweets.df2)

word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df)

emotion.df2 <- cbind(tweets.df2, emotion.df) 

head(emotion.df2)

##------------------------------------------------------------------------------

sent.value <- get_sentiment(word.df)

positive.tweets <- word.df[sent.value > 0]

negative.tweets <- word.df[sent.value < 0]

neutral.tweets <- word.df[sent.value == 0]

Positive <- length(positive.tweets)

Neutral <- length(neutral.tweets)

Negative <- length(negative.tweets)

x <- c(Positive, Neutral, Negative)

labels <- c("Positive", "Negative", "Neutral")

pie(x, labels, main = "Sentiment Analysis - India Monetization", col = rainbow(length(x)))

##------------------------------------------------------------------------------

tweet_corpus <- Corpus(VectorSource(word.df))
ns
tdm <- TermDocumentMatrix(tweet_corpus,
                          control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                         stopwords = c("RT", stopwords("english")),
                                         removeNumbers = TRUE, tolower = TRUE))


# define tdm as matrix so we can calculate word frequencies
tdm.matrix <- as.matrix(tdm)

# get word counts in decreasing order
word_freqs <- sort(rowSums(tdm.matrix), decreasing=TRUE) 

# create a data frame with words and their frequencies
dm <- data.frame(word=names(word_freqs), freq=word_freqs)

# plot wordcloud with words that appear at least 10 times
wordcloud(dm$word, dm$freq, min.freq = 15, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

##------------------------------------------------------------------------------

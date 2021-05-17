################################################################################
## R - NLP & Text Mining Project on India's Demonetization Tweets.

## Analysis of India's Demonetization Tweets..

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

demonetization.tweets.df <- read.csv("D:/001_Data/NLP/India Demonitization/Demonetization_data29th.csv")
head(demonetization.tweets.df$CONTENT)
demonetization.tweets.df2 <- demonetization.tweets.df$CONTENT


## TASK 2 - CLEANING THE TWEETS

demonetization.tweets.df2 <- gsub('http\\S+\\s*', '', demonetization.tweets.df2) ## Remove URLs
demonetization.tweets.df2 <- gsub('[^\x01-\x7F]', '', demonetization.tweets.df2) ## Removing Unwanted Chars
demonetization.tweets.df2 <- gsub('https:\\S+\\s*', '', demonetization.tweets.df2) ## Remove URLs
demonetization.tweets.df2 <- gsub('https\\S+\\s*', '', demonetization.tweets.df2) ## Remove URLs
demonetization.tweets.df2 <- gsub('\\b+RT', '', demonetization.tweets.df2) ## Remove RT
demonetization.tweets.df2 <- gsub('#\\S+', '', demonetization.tweets.df2) ## Remove Hashtags
demonetization.tweets.df2 <- gsub('@\\S+', '', demonetization.tweets.df2) ## Remove Mentions
demonetization.tweets.df2 <- gsub('[[:cntrl:]]', '', demonetization.tweets.df2) ## Remove Controls and special characters
demonetization.tweets.df2 <- gsub("\\d", '', demonetization.tweets.df2) ## Remove Controls and special characters
demonetization.tweets.df2 <- gsub('[[:punct:]]', '', demonetization.tweets.df2) ## Remove Punctuations
demonetization.tweets.df2 <- gsub("^[[:space:]]*","", demonetization.tweets.df2) ## Remove leading whitespaces
demonetization.tweets.df2 <- gsub("[[:space:]]*$","", demonetization.tweets.df2) ## Remove trailing whitespaces
demonetization.tweets.df2 <- gsub(' +',' ', demonetization.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

demonetization.tweets.word.df <- as.vector(demonetization.tweets.df2)
demonetization.tweets.emotion.df <- get_nrc_sentiment(demonetization.tweets.word.df)
demonetization.tweets.emotion.df2 <- cbind(demonetization.tweets.df2, demonetization.tweets.emotion.df) 
head(demonetization.tweets.word.df)
head(demonetization.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

demonetization.tweets.sent.value <- get_sentiment(demonetization.tweets.word.df)

demonetization.tweets.positive.tweets <- demonetization.tweets.word.df[demonetization.tweets.sent.value > 0]
demonetization.tweets.negative.tweets <- demonetization.tweets.word.df[demonetization.tweets.sent.value < 0]
demonetization.tweets.neutral.tweets <- demonetization.tweets.word.df[demonetization.tweets.sent.value == 0]

demonetization.tweets.most.positive <- demonetization.tweets.word.df[demonetization.tweets.sent.value == max(demonetization.tweets.sent.value)]
print(demonetization.tweets.most.positive)

demonetization.tweets.most.negative <- demonetization.tweets.word.df[demonetization.tweets.sent.value <= min(demonetization.tweets.sent.value)] 
print(demonetization.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

demonetization.tweets.Positive <- length(demonetization.tweets.positive.tweets)
demonetization.tweets.Neutral <- length(demonetization.tweets.neutral.tweets)
demonetization.tweets.Negative <- length(demonetization.tweets.negative.tweets)

demonetization.tweets.Sentiments <- c(demonetization.tweets.Positive, demonetization.tweets.Neutral,
                             demonetization.tweets.Negative)

print(demonetization.tweets.Sentiments)

demonetization.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(demonetization.tweets.Sentiments, demonetization.tweets.Sentiments,
    main = "Sentiment Analysis on India Currency Demonetization Tweets",
    col = rainbow(length(demonetization.tweets.Sentiments)))

legend('topright', demonetization.tweets.labels, cex=0.8,
       fill = rainbow(length(demonetization.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2011 ELON MUSK TWEETS

demonetization.tweets.tweet_corpus <- Corpus(VectorSource(demonetization.tweets.word.df))


demonetization.tweets.tdm <- TermDocumentMatrix(demonetization.tweets.tweet_corpus,
                                       control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                          stopwords =  c("RT") ,stopwords("english"),
                          removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2011)

head(demonetization.tweets.tdm)
demonetization.tweets.DF <- tidy(demonetization.tweets.tdm)
head(demonetization.tweets.DF)
head(demonetization.tweets.DF$term)
demonetization.tweets.DF.texts <- as.vector(demonetization.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
demonetization.tweets.DF.texts.Sentiment<-get_nrc_sentiment((demonetization.tweets.DF.texts))

demonetization.tweets.positive =sum(demonetization.tweets.DF.texts.Sentiment$positive)
demonetization.tweets.anger =sum(demonetization.tweets.DF.texts.Sentiment$anger)
demonetization.tweets.anticipation =sum(demonetization.tweets.DF.texts.Sentiment$anticipation)
demonetization.tweets.disgust =sum(demonetization.tweets.DF.texts.Sentiment$disgust)
demonetization.tweets.fear =sum(demonetization.tweets.DF.texts.Sentiment$fear)
demonetization.tweets.joy =sum(demonetization.tweets.DF.texts.Sentiment$joy)
demonetization.tweets.sadness =sum(demonetization.tweets.DF.texts.Sentiment$sadness)
demonetization.tweets.surprise =sum(demonetization.tweets.DF.texts.Sentiment$surprise)
demonetization.tweets.trust =sum(demonetization.tweets.DF.texts.Sentiment$trust)
demonetization.tweets.negative =sum(demonetization.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
demonetization.tweets.yAxis <- c(demonetization.tweets.positive,
                        + demonetization.tweets.anger,
                        + demonetization.tweets.anticipation,
                        + demonetization.tweets.disgust,
                        + demonetization.tweets.fear,
                        + demonetization.tweets.joy,
                        + demonetization.tweets.sadness,
                        + demonetization.tweets.surprise,
                        + demonetization.tweets.trust,
                        + demonetization.tweets.negative)

demonetization.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

demonetization.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

demonetization.tweets.yRange <- range(0, demonetization.tweets.yAxis) 

barplot(demonetization.tweets.yAxis, names.arg = demonetization.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "Bar Chart on India Currency Demonetization Tweets", 
        col = demonetization.tweets.colors, border = "black", ylim = demonetization.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


demonetization.tweets.tdm.matrix <- as.matrix(demonetization.tweets.tdm)

demonetization.tweets.word_freqs <- sort(rowSums(demonetization.tweets.tdm.matrix), decreasing=TRUE) 
demonetization.tweets.dm <- data.frame(word=names(demonetization.tweets.word_freqs), freq=demonetization.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(demonetization.tweets.dm$word, demonetization.tweets.dm$freq, 
          min.freq = 50, max.words = 35, random.order=FALSE, 
          main="Word Cloud on India Currency Demonetization Tweets",
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################

################################################################################
## NLP ON RADIO NZ TWEETS
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

################################################################################
## RADIO NZ (RNZ)
################################################################################

## TASK 1 - IMPORTING THE TWEETS

rnz.df <- read.csv("radionz.csv")
head(rnz.df$text)
rnz.df2 <- rnz.df$text

## TASK 2 - CLEANING THE TWEETS

rnz.df2 <- gsub("[^\x01-\x7F]","",rnz.df2)
rnz.df2 <- gsub("http.*","",rnz.df2)
rnz.df2 <- gsub("https.*","",rnz.df2)
rnz.df2 <- gsub("https:*","",rnz.df2)
rnz.df2 <- gsub("[\n\n]+","",rnz.df2)
rnz.df2 <- gsub("[#]+","",rnz.df2)
rnz.df2 <- gsub("[@]+","",rnz.df2)
rnz.df2 <- gsub("#*","",rnz.df2)
rnz.df2 <- gsub("@*","",rnz.df2)

## TASK 3 - CALCULATING THE SENTIMENTS/ EMOTIONS

rnz.word.df <- as.vector(rnz.df2)
rnz.emotion.df <- get_nrc_sentiment(rnz.word.df)
rnz.emotion.df2 <- cbind(rnz.df2, rnz.emotion.df) 
head(rnz.df2)
head(rnz.emotion.df2)

## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEETS

rnz.sent.value <- get_sentiment(rnz.word.df)

rnz.positive.tweets <- rnz.word.df[rnz.sent.value > 0]
rnz.negative.tweets <- rnz.word.df[rnz.sent.value < 0]
rnz.neutral.tweets <- rnz.word.df[rnz.sent.value == 0]

rnz.most.positive <- rnz.word.df[rnz.sent.value == max(rnz.sent.value)]
rnz.most.positive

rnz.most.negative <- rnz.word.df[rnz.sent.value <= min(rnz.sent.value)] 
rnz.most.negative

## TASK 5 - CREATING PIE CHART OF SENTIMENTS 

rnz.Positive <- length(rnz.positive.tweets)
rnz.Neutral <- length(rnz.neutral.tweets)
rnz.Negative <- length(rnz.negative.tweets)

rnz.Sentiments <- c(rnz.Positive, rnz.Neutral,rnz.Negative)

print(rnz.Sentiments)

rnz.labels <- c("Positive", "Negative", "Neutral")

pie(rnz.Sentiments, rnz.Sentiments,
    main = "Sentiment Analysis On Radio NZ",
    col = rainbow(length(rnz.Sentiments)))

legend('topright', rnz.labels, cex=0.8,
       fill = rainbow(length(rnz.labels)))

## TASK 6 - TERM DOCUMENT MATRIX

rnz.tweet_corpus <- Corpus(VectorSource(rnz.word.df))


rnz.tdm <- TermDocumentMatrix(rnz.tweet_corpus,
                              control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                             stopwords = c("would","yesterday", "think", "around", "there",
                                                           "after", "their", "icymi", "those", "listen", "being", "about","zealand", 
                                                           "rossa"),stopwords("english"),
                                             removeNumbers = TRUE, tolower = TRUE))

## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS

head(rnz.tdm)
rnz.DF <- tidy(rnz.tdm)
head(rnz.DF)
head(rnz.DF$term)
rnz.DF.texts <- as.vector(rnz.DF$term)

# SENTIMENT ANALYSIS ON MAGIC TALKS RADIO
rnz.DF.texts.Sentiment<-get_nrc_sentiment((rnz.DF.texts))

rnz.positive =sum(rnz.DF.texts.Sentiment$positive)
rnz.anger =sum(rnz.DF.texts.Sentiment$anger)
rnz.anticipation =sum(rnz.DF.texts.Sentiment$anticipation)
rnz.disgust =sum(rnz.DF.texts.Sentiment$disgust)
rnz.fear =sum(rnz.DF.texts.Sentiment$fear)
rnz.joy =sum(rnz.DF.texts.Sentiment$joy)
rnz.sadness =sum(rnz.DF.texts.Sentiment$sadness)
rnz.surprise =sum(rnz.DF.texts.Sentiment$surprise)
rnz.trust =sum(rnz.DF.texts.Sentiment$trust)
rnz.negative =sum(rnz.DF.texts.Sentiment$negative)

# BAR CHART ON RADIO NZ SENTIMENTS
rnz.yAxis <- c(rnz.positive,
               + rnz.anger,
               + rnz.anticipation,
               + rnz.disgust,
               + rnz.fear,
               + rnz.joy,
               + rnz.sadness,
               + rnz.surprise,
               + rnz.trust,
               + rnz.negative)

rnz.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
               "Joy","Sadness","Surprise","Trust","Negative")

rnz.colors <- c("green","red","blue",
                "orange","red","green","orange","blue","green","red")

rnz.yRange <- range(0, rnz.yAxis) 

barplot(rnz.yAxis, names.arg = rnz.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "RADIO NZ'S SENTIMENT ANALYSIS", 
        col = rnz.colors, border = "black", ylim = rnz.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


rnz.tdm.matrix <- as.matrix(rnz.tdm)

rnz.word_freqs <- sort(rowSums(rnz.tdm.matrix), decreasing=TRUE) 
rnz.dm <- data.frame(word=names(rnz.word_freqs), freq=rnz.word_freqs)

## TASK 7 - PREPARING WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(rnz.dm$word, rnz.dm$freq, 
          min.freq = 65, max.words = 30, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

## Finding the Association
rnz.freqr <- rowSums(as.matrix(rnz.tdm))

rnz.ordr <- order(rnz.freqr,decreasing=TRUE)

rnz.freqr[head(rnz.ordr)]
rnz.freqr[tail(rnz.ordr)]

findFreqTerms(rnz.tdm,lowfreq=25)

findAssocs(rnz.tdm,"americas",0.35)
findAssocs(rnz.tdm,"covid",0.45)
findAssocs(rnz.tdm,"people",0.30)
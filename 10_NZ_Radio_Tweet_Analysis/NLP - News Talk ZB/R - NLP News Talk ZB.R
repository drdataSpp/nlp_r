################################################################################
## NLP ON NEWS TALK ZB TWEETS
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
## NEWS TALK ZB
################################################################################

## TASK 1 - IMPORTING THE TWEETS

news.talk.df <- read.csv("NewstalkZB.csv")
head(news.talk.df$text)
news.talk.df2 <- news.talk.df$text

## TASK 2 - CLEANIN THE TWEETS

news.talk.df2 <- gsub("[^\x01-\x7F]","",news.talk.df2)
news.talk.df2 <- gsub("http.*","",news.talk.df2)
news.talk.df2 <- gsub("https.*","",news.talk.df2)
news.talk.df2 <- gsub("https:*","",news.talk.df2)
news.talk.df2 <- gsub("[\n\n]+","",news.talk.df2)
news.talk.df2 <- gsub("[#]+","",news.talk.df2)
news.talk.df2 <- gsub("[@]+","",news.talk.df2)
news.talk.df2 <- gsub("#*","",news.talk.df2)
news.talk.df2 <- gsub("@*","",news.talk.df2)

## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

news.talk.word.df <- as.vector(news.talk.df2)
news.talk.emotion.df <- get_nrc_sentiment(news.talk.word.df)
news.talk.emotion.df2 <- cbind(news.talk.df2, news.talk.emotion.df) 
head(news.talk.word.df)
head(news.talk.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET

news.talk.sent.value <- get_sentiment(news.talk.word.df)

news.talk.positive.tweets <- news.talk.word.df[news.talk.sent.value > 0]
news.talk.negative.tweets <- news.talk.word.df[news.talk.sent.value < 0]
news.talk.neutral.tweets <- news.talk.word.df[news.talk.sent.value == 0]

news.talk.most.positive <- news.talk.word.df[news.talk.sent.value == max(news.talk.sent.value)]
news.talk.most.positive

news.talk.most.negative <- news.talk.word.df[news.talk.sent.value <= min(news.talk.sent.value)] 
news.talk.most.negative

## TASK 5 - CREATING PIE CHART OF SENTIMENTS

news.talk.Positive <- length(news.talk.positive.tweets)
news.talk.Neutral <- length(news.talk.neutral.tweets)
news.talk.Negative <- length(news.talk.negative.tweets)

news.talk.Sentiments <- c(news.talk.Positive, news.talk.Neutral,
                          news.talk.Negative)

print(news.talk.Sentiments)

news.talk.labels <- c("Positive", "Negative", "Neutral")

pie(news.talk.Sentiments, news.talk.Sentiments,
    main = "Sentiment Analysis On News Talk",
    col = rainbow(length(news.talk.Sentiments)))

legend('topright', news.talk.labels, cex=0.8,
       fill = rainbow(length(news.talk.labels)))

## TASK 6 - TERM DOCUMENT MATRIX

news.talk.tweet_corpus <- Corpus(VectorSource(news.talk.word.df))


news.talk.tdm <- TermDocumentMatrix(news.talk.tweet_corpus,
                                    control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                   stopwords =  c("LISTEN", "listen", "hawkesby", "plessisallan",
                                                                  "harry", "hosking", "mikes", "zealand"),stopwords("english"),
                                                   removeNumbers = TRUE, tolower = TRUE))

## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS

head(news.talk.tdm)
news.talk.DF <- tidy(news.talk.tdm)
head(news.talk.DF)
head(news.talk.DF$term)
news.talk.DF.texts <- as.vector(news.talk.DF$term)

# SENTIMENT ANALYSIS ON MAGIC TALKS RADIO
news.talk.DF.texts.Sentiment<-get_nrc_sentiment((news.talk.DF.texts))

news.talk.positive =sum(news.talk.DF.texts.Sentiment$positive)
news.talk.anger =sum(news.talk.DF.texts.Sentiment$anger)
news.talk.anticipation =sum(news.talk.DF.texts.Sentiment$anticipation)
news.talk.disgust =sum(news.talk.DF.texts.Sentiment$disgust)
news.talk.fear =sum(news.talk.DF.texts.Sentiment$fear)
news.talk.joy =sum(news.talk.DF.texts.Sentiment$joy)
news.talk.sadness =sum(news.talk.DF.texts.Sentiment$sadness)
news.talk.surprise =sum(news.talk.DF.texts.Sentiment$surprise)
news.talk.trust =sum(news.talk.DF.texts.Sentiment$trust)
news.talk.negative =sum(news.talk.DF.texts.Sentiment$negative)

# BAR CHART ON MAGIC TALK SENTIMENTS
news.talk.yAxis <- c(news.talk.positive,
                     + news.talk.anger,
                     + news.talk.anticipation,
                     + news.talk.disgust,
                     + news.talk.fear,
                     + news.talk.joy,
                     + news.talk.sadness,
                     + news.talk.surprise,
                     + news.talk.trust,
                     + news.talk.negative)

news.talk.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                     "Joy","Sadness","Surprise","Trust","Negative")

news.talk.colors <- c("green","red","blue",
                      "orange","red","green","orange","blue","green","red")

news.talk.yRange <- range(0, news.talk.yAxis) 

barplot(news.talk.yAxis, names.arg = news.talk.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "NEWS TALK'S SENTIMENT ANALYSIS", 
        col = news.talk.colors, border = "black", ylim = news.talk.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


news.talk.tdm.matrix <- as.matrix(news.talk.tdm)

news.talk.word_freqs <- sort(rowSums(news.talk.tdm.matrix), decreasing=TRUE) 
news.talk.dm <- data.frame(word=names(news.talk.word_freqs), freq=news.talk.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(news.talk.dm$word, news.talk.dm$freq, 
          min.freq = 25, max.words = 35, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

## Finding the Association  
news.talk.freqr <- rowSums(as.matrix(news.talk.tdm))

news.talk.ordr <- order(news.talk.freqr,decreasing=TRUE)

news.talk.freqr[head(news.talk.ordr)]
news.talk.freqr[tail(news.talk.ordr)]

findFreqTerms(news.talk.tdm,lowfreq=100)

findAssocs(news.talk.tdm,"covid",0.35)
findAssocs(news.talk.tdm,"after",0.15)
findAssocs(news.talk.tdm,"auckland",0.25)
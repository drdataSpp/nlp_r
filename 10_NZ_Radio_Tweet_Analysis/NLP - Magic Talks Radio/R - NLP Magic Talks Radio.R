################################################################################
## NLP ON MAGIC TALK RADIO TWEETS 
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
## MAGIC TALK RADIO
################################################################################

## TASK 1 - IMPORTING THE TWEETS

Magic.Radio.df <- read.csv("MagicTalkRadio.csv")
head(Magic.Radio.df$text)
Magic.Radio.df2 <- Magic.Radio.df$text

## TASK 2 - CLEANING THE TWEETS

Magic.Radio.df2 <- gsub("[^\x01-\x7F]","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("http.*","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("https.*","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("https:*","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("[\n\n]+","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("[#]+","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("[@]+","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("#*","",Magic.Radio.df2)
Magic.Radio.df2 <- gsub("@*","",Magic.Radio.df2)

## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

Magic.Radio.word.df <- as.vector(Magic.Radio.df2)
Magic.Radio.emotion.df <- get_nrc_sentiment(Magic.Radio.word.df)
Magic.Radio.emotion.df2 <- cbind(Magic.Radio.df2, Magic.Radio.emotion.df)
head(Magic.Radio.word.df)
head(Magic.Radio.emotion.df2)

## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEETS

Magic.Radio.sent.value <- get_sentiment(Magic.Radio.word.df)

Magic.Radio.positive.tweets <- Magic.Radio.word.df[Magic.Radio.sent.value > 0]
Magic.Radio.negative.tweets <- Magic.Radio.word.df[Magic.Radio.sent.value < 0]
Magic.Radio.neutral.tweets <- Magic.Radio.word.df[Magic.Radio.sent.value == 0]

Magic.Radio.most.positive <- Magic.Radio.word.df[Magic.Radio.sent.value == max(Magic.Radio.sent.value)]
Magic.Radio.most.positive

Magic.Radio.most.negative <- Magic.Radio.word.df[Magic.Radio.sent.value <= min(Magic.Radio.sent.value)] 
Magic.Radio.most.negative

## TASK 5 - CREATING PIE CHART OF SENTIMENTS

Magic.Radio.Positive <- length(Magic.Radio.positive.tweets)
Magic.Radio.Neutral <- length(Magic.Radio.neutral.tweets)
Magic.Radio.Negative <- length(Magic.Radio.negative.tweets)

Magic.Radio.Sentiments <- c(Magic.Radio.Positive, Magic.Radio.Neutral,
                            Magic.Radio.Negative)

print(Magic.Radio.Sentiments)

Magic.Radio.labels <- c("Positive", "Negative", "Neutral")

pie(Magic.Radio.Sentiments, Magic.Radio.Sentiments,
    main = "Sentiment Analysis On Magic Talk",
    col = rainbow(length(Magic.Radio.Sentiments)))

legend('topright', Magic.Radio.labels, cex=0.8,
       fill = rainbow(length(Magic.Radio.labels)))

## TASK 6 - TERM DOCUMENT MATRIX

Magic.Radio.tweet_corpus <- Corpus(VectorSource(Magic.Radio.word.df))


Magic.Radio.tdm <- TermDocumentMatrix(Magic.Radio.tweet_corpus,
                                      control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                                                     stopwords = c("magic","talks", "talk","listen","marcdaalder","watson", 
                                                                   "interview", "great",
                                                                   "about" ,"yesterday", "think", "around", "there", 
                                                                   "peter", "williams", "danny","those", "should", 
                                                                   "could","would", "theamshownz", "therealpcb"),stopwords("english"),
                                                     removeNumbers = TRUE, tolower = TRUE))

## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS

head(Magic.Radio.tdm)
Magic.Radio.DF <- tidy(Magic.Radio.tdm)
head(Magic.Radio.DF)
head(Magic.Radio.DF$term)
Magic.Radio.DF.texts <- as.vector(Magic.Radio.DF$term)

# SENTIMENT ANALYSIS ON MAGIC TALKS RADIO
Magic.Radio.DF.texts.Sentiment<-get_nrc_sentiment((Magic.Radio.DF.texts))

Magic.Radio.positive =sum(Magic.Radio.DF.texts.Sentiment$positive)
Magic.Radio.anger =sum(Magic.Radio.DF.texts.Sentiment$anger)
Magic.Radio.anticipation =sum(Magic.Radio.DF.texts.Sentiment$anticipation)
Magic.Radio.disgust =sum(Magic.Radio.DF.texts.Sentiment$disgust)
Magic.Radio.fear =sum(Magic.Radio.DF.texts.Sentiment$fear)
Magic.Radio.joy =sum(Magic.Radio.DF.texts.Sentiment$joy)
Magic.Radio.sadness =sum(Magic.Radio.DF.texts.Sentiment$sadness)
Magic.Radio.surprise =sum(Magic.Radio.DF.texts.Sentiment$surprise)
Magic.Radio.trust =sum(Magic.Radio.DF.texts.Sentiment$trust)
Magic.Radio.negative =sum(Magic.Radio.DF.texts.Sentiment$negative)

# BAR CHART ON MAGIC TALK SENTIMENTS
Magic.Radio.yAxis <- c(Magic.Radio.positive,
                       + Magic.Radio.anger,
                       + Magic.Radio.anticipation,
                       + Magic.Radio.disgust,
                       + Magic.Radio.fear,
                       + Magic.Radio.joy,
                       + Magic.Radio.sadness,
                       + Magic.Radio.surprise,
                       + Magic.Radio.trust,
                       + Magic.Radio.negative)

Magic.Radio.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                       "Joy","Sadness","Surprise","Trust","Negative")

Magic.Radio.colors <- c("green","red","blue",
                        "orange","red","green","orange","blue","green","red")

Magic.Radio.yRange <- range(0,Magic.Radio.yAxis) 

barplot(Magic.Radio.yAxis, names.arg = Magic.Radio.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "MAGIC RADIO'S SENTIMENT ANALYSIS", 
        col = Magic.Radio.colors, border = "black", ylim = Magic.Radio.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


Magic.Radio.tdm.matrix <- as.matrix(Magic.Radio.tdm)

Magic.Radio.word_freqs <- sort(rowSums(Magic.Radio.tdm.matrix), decreasing=TRUE) 
Magic.Radio.dm <- data.frame(word=names(Magic.Radio.word_freqs), freq=Magic.Radio.word_freqs)

## TASK 7 - PREPARING WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(Magic.Radio.dm$word, Magic.Radio.dm$freq, 
          min.freq = 150, max.words = 20, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

## Finding the Association
Magic.Radio.freqr <- rowSums(as.matrix(Magic.Radio.tdm))

Magic.Radio.ordr <- order(Magic.Radio.freqr,decreasing=TRUE)

Magic.Radio.freqr[head(Magic.Radio.ordr)]
Magic.Radio.freqr[tail(Magic.Radio.ordr)]

findFreqTerms(Magic.Radio.tdm,lowfreq=100)

findAssocs(Magic.Radio.tdm,"breaking",0.40)
findAssocs(Magic.Radio.tdm,"today",0.35)
findAssocs(Magic.Radio.tdm,"level",0.45)

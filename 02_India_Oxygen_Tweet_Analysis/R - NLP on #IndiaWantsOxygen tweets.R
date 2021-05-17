################################################################################
## R - NLP & Text Mining Project

## Analysis of #IndiaWantsOxygen hashtag Tweets. 

################################################################################

################################################################################
## INSTALLING THE REQUIRED LIBRARIES 
################################################################################

# install.packages(tm)
# install.packages(twitteR)
# install.packages(ggplot2)
# install.packages(syuzhet)
# install.packages(tidytext)
# install.packages(wordcloud)
# install.packages(dplyr)


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

India_Oxygen.tweets.df <- read.csv("IndiaWantsOxygen.csv")
head(India_Oxygen.tweets.df$text)
dim(India_Oxygen.tweets.df)

## RANDOM SAMPLING THE DATASET 

sample_tweets <- sample_n(India_Oxygen.tweets.df, 2500, prop = 1)
India_Oxygen.tweets.df2 <- sample_tweets$text


## TASK 2 - CLEANING THE TWEETS

India_Oxygen.tweets.df2 <- gsub('http\\S+\\s*', '', India_Oxygen.tweets.df2) ## Remove URLs
India_Oxygen.tweets.df2 <- gsub('[^\x01-\x7F]', '', India_Oxygen.tweets.df2) ## Removing Unwanted Chars
India_Oxygen.tweets.df2 <- gsub('https:\\S+\\s*', '', India_Oxygen.tweets.df2) ## Remove URLs
India_Oxygen.tweets.df2 <- gsub('https\\S+\\s*', '', India_Oxygen.tweets.df2) ## Remove URLs
India_Oxygen.tweets.df2 <- gsub('\\b+RT', '', India_Oxygen.tweets.df2) ## Remove RT
India_Oxygen.tweets.df2 <- gsub('#\\S+', '', India_Oxygen.tweets.df2) ## Remove Hashtags
India_Oxygen.tweets.df2 <- gsub('@\\S+', '', India_Oxygen.tweets.df2) ## Remove Mentions
India_Oxygen.tweets.df2 <- gsub('[[:cntrl:]]', '', India_Oxygen.tweets.df2) ## Remove Controls and special characters
India_Oxygen.tweets.df2 <- gsub("\\d", '', India_Oxygen.tweets.df2) ## Remove Controls and special characters
India_Oxygen.tweets.df2 <- gsub('[[:punct:]]', '', India_Oxygen.tweets.df2) ## Remove Punctuations
India_Oxygen.tweets.df2 <- gsub("^[[:space:]]*","", India_Oxygen.tweets.df2) ## Remove leading whitespaces
India_Oxygen.tweets.df2 <- gsub("[[:space:]]*$","", India_Oxygen.tweets.df2) ## Remove trailing whitespaces
India_Oxygen.tweets.df2 <- gsub(' +',' ', India_Oxygen.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

India_Oxygen.tweets.word.df <- as.vector(India_Oxygen.tweets.df2)
India_Oxygen.tweets.emotion.df <- get_nrc_sentiment(India_Oxygen.tweets.word.df)
India_Oxygen.tweets.emotion.df2 <- cbind(India_Oxygen.tweets.df2, India_Oxygen.tweets.emotion.df) 
head(India_Oxygen.tweets.word.df)
head(India_Oxygen.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET

India_Oxygen.tweets.sent.value <- get_sentiment(India_Oxygen.tweets.word.df)

India_Oxygen.tweets.positive.tweets <- India_Oxygen.tweets.word.df[India_Oxygen.tweets.sent.value > 0]
India_Oxygen.tweets.negative.tweets <- India_Oxygen.tweets.word.df[India_Oxygen.tweets.sent.value < 0]
India_Oxygen.tweets.neutral.tweets <- India_Oxygen.tweets.word.df[India_Oxygen.tweets.sent.value == 0]

India_Oxygen.tweets.most.positive <- India_Oxygen.tweets.word.df[India_Oxygen.tweets.sent.value == max(India_Oxygen.tweets.sent.value)]
print(India_Oxygen.tweets.most.positive)

India_Oxygen.tweets.most.negative <- India_Oxygen.tweets.word.df[India_Oxygen.tweets.sent.value <= min(India_Oxygen.tweets.sent.value)] 
print(India_Oxygen.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

India_Oxygen.tweets.Positive <- length(India_Oxygen.tweets.positive.tweets)
India_Oxygen.tweets.Neutral <- length(India_Oxygen.tweets.neutral.tweets)
India_Oxygen.tweets.Negative <- length(India_Oxygen.tweets.negative.tweets)

India_Oxygen.tweets.Sentiments <- c(India_Oxygen.tweets.Positive, India_Oxygen.tweets.Neutral,
                             India_Oxygen.tweets.Negative)

print(India_Oxygen.tweets.Sentiments)

India_Oxygen.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(India_Oxygen.tweets.Sentiments, India_Oxygen.tweets.Sentiments,
    main = "Sentiment Analysis on #IndiaWantsOxygen hashatg Tweets",
    col = rainbow(length(India_Oxygen.tweets.Sentiments)))

legend('topright', India_Oxygen.tweets.labels, cex=0.8,
       fill = rainbow(length(India_Oxygen.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF TWEETS

India_Oxygen.tweets.tweet_corpus <- Corpus(VectorSource(India_Oxygen.tweets.word.df))


India_Oxygen.tweets.tdm <- TermDocumentMatrix(India_Oxygen.tweets.tweet_corpus,
           control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                          stopwords = stopwords("english"),
                          removeNumbers = TRUE, tolower = TRUE))



## CALCULATING EMOTIONS FROM THE TWEETS.

head(India_Oxygen.tweets.tdm)
India_Oxygen.tweets.DF <- tidy(India_Oxygen.tweets.tdm)
head(India_Oxygen.tweets.DF)
head(India_Oxygen.tweets.DF$term)
India_Oxygen.tweets.DF.texts <- as.vector(India_Oxygen.tweets.DF$term)

India_Oxygen.tweets.DF.texts.Sentiment<-get_nrc_sentiment((India_Oxygen.tweets.DF.texts))

India_Oxygen.tweets.positive =sum(India_Oxygen.tweets.DF.texts.Sentiment$positive)
India_Oxygen.tweets.anger =sum(India_Oxygen.tweets.DF.texts.Sentiment$anger)
India_Oxygen.tweets.anticipation =sum(India_Oxygen.tweets.DF.texts.Sentiment$anticipation)
India_Oxygen.tweets.disgust =sum(India_Oxygen.tweets.DF.texts.Sentiment$disgust)
India_Oxygen.tweets.fear =sum(India_Oxygen.tweets.DF.texts.Sentiment$fear)
India_Oxygen.tweets.joy =sum(India_Oxygen.tweets.DF.texts.Sentiment$joy)
India_Oxygen.tweets.sadness =sum(India_Oxygen.tweets.DF.texts.Sentiment$sadness)
India_Oxygen.tweets.surprise =sum(India_Oxygen.tweets.DF.texts.Sentiment$surprise)
India_Oxygen.tweets.trust =sum(India_Oxygen.tweets.DF.texts.Sentiment$trust)
India_Oxygen.tweets.negative =sum(India_Oxygen.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED EMOTIONS
India_Oxygen.tweets.yAxis <- c(India_Oxygen.tweets.positive,
                        + India_Oxygen.tweets.anger,
                        + India_Oxygen.tweets.anticipation,
                        + India_Oxygen.tweets.disgust,
                        + India_Oxygen.tweets.fear,
                        + India_Oxygen.tweets.joy,
                        + India_Oxygen.tweets.sadness,
                        + India_Oxygen.tweets.surprise,
                        + India_Oxygen.tweets.trust,
                        + India_Oxygen.tweets.negative)

India_Oxygen.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

India_Oxygen.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

India_Oxygen.tweets.yRange <- range(0, India_Oxygen.tweets.yAxis) 

barplot(India_Oxygen.tweets.yAxis, names.arg = India_Oxygen.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "Emotion Bar Chart on #IndiaWantsOxygen hashtag Tweets", 
        col = India_Oxygen.tweets.colors, border = "black", ylim = India_Oxygen.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


India_Oxygen.tweets.tdm.matrix <- as.matrix(India_Oxygen.tweets.tdm)

India_Oxygen.tweets.word_freqs <- sort(rowSums(India_Oxygen.tweets.tdm.matrix), decreasing=TRUE) 
India_Oxygen.tweets.dm <- data.frame(word=names(India_Oxygen.tweets.word_freqs), freq=India_Oxygen.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(India_Oxygen.tweets.dm$word, India_Oxygen.tweets.dm$freq, 
          min.freq = 15, max.words = 150, random.order=FALSE, 
          main="Word Cloud on #IndiaWantsOxygen hashtag Tweets.",
          colors=brewer.pal(8, "Dark2"), size=5)

png("oxygent_wordcloud.png", width=12,height=8, units='in', res=300)


## THE END

################################################################################
################################################################################
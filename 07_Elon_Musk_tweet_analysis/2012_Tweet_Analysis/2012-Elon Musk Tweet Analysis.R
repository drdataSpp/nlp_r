################################################################################
## R - NLP & Text Mining Project 2

## Analysis of 2012 time frame Elon Musk's Tweets.

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

year2.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2012.csv")
head(year2.tweets.df$tweet)
year2.tweets.df2 <- year2.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year2.tweets.df2 <- gsub('http\\S+\\s*', '', year2.tweets.df2) ## Remove URLs
year2.tweets.df2 <- gsub('[^\x01-\x7F]', '', year2.tweets.df2) ## Removing Unwanted Chars
year2.tweets.df2 <- gsub('https:\\S+\\s*', '', year2.tweets.df2) ## Remove URLs
year2.tweets.df2 <- gsub('https\\S+\\s*', '', year2.tweets.df2) ## Remove URLs
year2.tweets.df2 <- gsub('\\b+RT', '', year2.tweets.df2) ## Remove RT
year2.tweets.df2 <- gsub('#\\S+', '', year2.tweets.df2) ## Remove Hashtags
year2.tweets.df2 <- gsub('@\\S+', '', year2.tweets.df2) ## Remove Mentions
year2.tweets.df2 <- gsub('[[:cntrl:]]', '', year2.tweets.df2) ## Remove Controls and special characters
year2.tweets.df2 <- gsub("\\d", '', year2.tweets.df2) ## Remove Controls and special characters
year2.tweets.df2 <- gsub('[[:punct:]]', '', year2.tweets.df2) ## Remove Punctuations
year2.tweets.df2 <- gsub("^[[:space:]]*","", year2.tweets.df2) ## Remove leading whitespaces
year2.tweets.df2 <- gsub("[[:space:]]*$","", year2.tweets.df2) ## Remove trailing whitespaces
year2.tweets.df2 <- gsub(' +',' ', year2.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year2.tweets.word.df <- as.vector(year2.tweets.df2)
year2.tweets.emotion.df <- get_nrc_sentiment(year2.tweets.word.df)
year2.tweets.emotion.df2 <- cbind(year2.tweets.df2, year2.tweets.emotion.df) 
head(year2.tweets.word.df)
head(year2.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET

year2.tweets.sent.value <- get_sentiment(year2.tweets.word.df)

year2.tweets.positive.tweets <- year2.tweets.word.df[year2.tweets.sent.value > 0]
year2.tweets.negative.tweets <- year2.tweets.word.df[year2.tweets.sent.value < 0]
year2.tweets.neutral.tweets <- year2.tweets.word.df[year2.tweets.sent.value == 0]

year2.tweets.most.positive <- year2.tweets.word.df[year2.tweets.sent.value == max(year2.tweets.sent.value)]
print(year2.tweets.most.positive)

year2.tweets.most.negative <- year2.tweets.word.df[year2.tweets.sent.value <= min(year2.tweets.sent.value)] 
print(year2.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year2.tweets.Positive <- length(year2.tweets.positive.tweets)
year2.tweets.Neutral <- length(year2.tweets.neutral.tweets)
year2.tweets.Negative <- length(year2.tweets.negative.tweets)

year2.tweets.Sentiments <- c(year2.tweets.Positive, year2.tweets.Neutral,
                             year2.tweets.Negative)

print(year2.tweets.Sentiments)

year2.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year2.tweets.Sentiments, year2.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2012)",
    col = rainbow(length(year2.tweets.Sentiments)))

legend('topright', year2.tweets.labels, cex=0.8,
       fill = rainbow(length(year2.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF TWEETS

year2.tweets.tweet_corpus <- Corpus(VectorSource(year2.tweets.word.df))


year2.tweets.tdm <- TermDocumentMatrix(year2.tweets.tweet_corpus,
     control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
                    stopwords =  c("tweets", "others", "today", "carsâby",
                                   "ideaâ") ,stopwords("english"),
                    removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE EMOTIONS FROM THE TWEETS

head(year2.tweets.tdm)
year2.tweets.DF <- tidy(year2.tweets.tdm)
head(year2.tweets.DF)
head(year2.tweets.DF$term)
year2.tweets.DF.texts <- as.vector(year2.tweets.DF$term)


year2.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year2.tweets.DF.texts))

year2.tweets.positive =sum(year2.tweets.DF.texts.Sentiment$positive)
year2.tweets.anger =sum(year2.tweets.DF.texts.Sentiment$anger)
year2.tweets.anticipation =sum(year2.tweets.DF.texts.Sentiment$anticipation)
year2.tweets.disgust =sum(year2.tweets.DF.texts.Sentiment$disgust)
year2.tweets.fear =sum(year2.tweets.DF.texts.Sentiment$fear)
year2.tweets.joy =sum(year2.tweets.DF.texts.Sentiment$joy)
year2.tweets.sadness =sum(year2.tweets.DF.texts.Sentiment$sadness)
year2.tweets.surprise =sum(year2.tweets.DF.texts.Sentiment$surprise)
year2.tweets.trust =sum(year2.tweets.DF.texts.Sentiment$trust)
year2.tweets.negative =sum(year2.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON EMOTIONS
year2.tweets.yAxis <- c(year2.tweets.positive,
                        + year2.tweets.anger,
                        + year2.tweets.anticipation,
                        + year2.tweets.disgust,
                        + year2.tweets.fear,
                        + year2.tweets.joy,
                        + year2.tweets.sadness,
                        + year2.tweets.surprise,
                        + year2.tweets.trust,
                        + year2.tweets.negative)

year2.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                        "Joy","Sadness","Surprise","Trust","Negative")

year2.tweets.colors <- c("green","red","blue",
                         "orange","red","green","orange","blue","green","red")

year2.tweets.yRange <- range(0, year2.tweets.yAxis) 

barplot(year2.tweets.yAxis, names.arg = year2.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2012) SENTIMENT ANALYSIS", 
        col = year2.tweets.colors, border = "black", ylim = year2.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year2.tweets.tdm.matrix <- as.matrix(year2.tweets.tdm)

year2.tweets.word_freqs <- sort(rowSums(year2.tweets.tdm.matrix), decreasing=TRUE) 
year2.tweets.dm <- data.frame(word=names(year2.tweets.word_freqs), freq=year2.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year2.tweets.dm$word, year2.tweets.dm$freq, 
          min.freq = 50, max.words = 35, random.order=FALSE, 
          main="Word Cloud on Elon Musk's 2012 Tweets.",
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################

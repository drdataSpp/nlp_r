################################################################################
## R - NLP & Text Mining Project 1 

## Analysis of 2011 time frame Elon Musk's Tweets.

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

year1.tweets.df <- read.csv("D:/001_Data/NLP/Elon Musk Tweets/2011.csv")
head(year1.tweets.df$tweet)
year1.tweets.df2 <- year1.tweets.df$tweet


## TASK 2 - CLEANING THE TWEETS

year1.tweets.df2 <- gsub('http\\S+\\s*', '', year1.tweets.df2) ## Remove URLs
year1.tweets.df2 <- gsub('https:\\S+\\s*', '', year1.tweets.df2) ## Remove URLs
year1.tweets.df2 <- gsub('https\\S+\\s*', '', year1.tweets.df2) ## Remove URLs
year1.tweets.df2 <- gsub('\\b+RT', '', year1.tweets.df2) ## Remove RT
year1.tweets.df2 <- gsub('#\\S+', '', year1.tweets.df2) ## Remove Hashtags
year1.tweets.df2 <- gsub('@\\S+', '', year1.tweets.df2) ## Remove Mentions
year1.tweets.df2 <- gsub('[[:cntrl:]]', '', year1.tweets.df2) ## Remove Controls and special characters
year1.tweets.df2 <- gsub("\\d", '', year1.tweets.df2) ## Remove Controls and special characters
year1.tweets.df2 <- gsub('[[:punct:]]', '', year1.tweets.df2) ## Remove Punctuations
year1.tweets.df2 <- gsub("^[[:space:]]*","", year1.tweets.df2) ## Remove leading whitespaces
year1.tweets.df2 <- gsub("[[:space:]]*$","", year1.tweets.df2) ## Remove trailing whitespaces
year1.tweets.df2 <- gsub(' +',' ', year1.tweets.df2) ## Remove extra whitespaces


## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS

year1.tweets.word.df <- as.vector(year1.tweets.df2)
year1.tweets.emotion.df <- get_nrc_sentiment(year1.tweets.word.df)
year1.tweets.emotion.df2 <- cbind(year1.tweets.df2, year1.tweets.emotion.df) 
head(year1.tweets.word.df)
head(year1.tweets.emotion.df2)


## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE ELON MUSK'S TWEET

year1.tweets.sent.value <- get_sentiment(year1.tweets.word.df)

year1.tweets.positive.tweets <- year1.tweets.word.df[year1.tweets.sent.value > 0]
year1.tweets.negative.tweets <- year1.tweets.word.df[year1.tweets.sent.value < 0]
year1.tweets.neutral.tweets <- year1.tweets.word.df[year1.tweets.sent.value == 0]

year1.tweets.most.positive <- year1.tweets.word.df[year1.tweets.sent.value == max(year1.tweets.sent.value)]
print(year1.tweets.most.positive)

year1.tweets.most.negative <- year1.tweets.word.df[year1.tweets.sent.value <= min(year1.tweets.sent.value)] 
print(year1.tweets.most.negative)


## TASK 5 - CREATING PIE CHART OF SENTIMENTS

year1.tweets.Positive <- length(year1.tweets.positive.tweets)
year1.tweets.Neutral <- length(year1.tweets.neutral.tweets)
year1.tweets.Negative <- length(year1.tweets.negative.tweets)

year1.tweets.Sentiments <- c(year1.tweets.Positive, year1.tweets.Neutral,
                             year1.tweets.Negative)

print(year1.tweets.Sentiments)

year1.tweets.labels <- c("Positive", "Negative", "Neutral")

pie(year1.tweets.Sentiments, year1.tweets.Sentiments,
    main = "Sentiment Analysis On Elon Musk Tweets (Year = 2011)",
    col = rainbow(length(year1.tweets.Sentiments)))

legend('topright', year1.tweets.labels, cex=0.8,
       fill = rainbow(length(year1.tweets.labels)))


## TASK 6 - TERM DOCUMENT MATRIX OF 2011 ELON MUSK TWEETS

year1.tweets.tweet_corpus <- Corpus(VectorSource(year1.tweets.word.df))


year1.tweets.tdm <- TermDocumentMatrix(year1.tweets.tweet_corpus,
control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
             stopwords =  c("tweets", "others", "today") ,stopwords("english"),
             removeNumbers = TRUE, tolower = TRUE))



## CALCULATING THE COUNTS OF DIFFERENT EMOTIONS FROM ELON MUSK TWEETS (Year = 2011)

head(year1.tweets.tdm)
year1.tweets.DF <- tidy(year1.tweets.tdm)
head(year1.tweets.DF)
head(year1.tweets.DF$term)
year1.tweets.DF.texts <- as.vector(year1.tweets.DF$term)

# SENTIMENT ANALYSIS ON ELON MUSK'S TWEETS
year1.tweets.DF.texts.Sentiment<-get_nrc_sentiment((year1.tweets.DF.texts))

year1.tweets.positive =sum(year1.tweets.DF.texts.Sentiment$positive)
year1.tweets.anger =sum(year1.tweets.DF.texts.Sentiment$anger)
year1.tweets.anticipation =sum(year1.tweets.DF.texts.Sentiment$anticipation)
year1.tweets.disgust =sum(year1.tweets.DF.texts.Sentiment$disgust)
year1.tweets.fear =sum(year1.tweets.DF.texts.Sentiment$fear)
year1.tweets.joy =sum(year1.tweets.DF.texts.Sentiment$joy)
year1.tweets.sadness =sum(year1.tweets.DF.texts.Sentiment$sadness)
year1.tweets.surprise =sum(year1.tweets.DF.texts.Sentiment$surprise)
year1.tweets.trust =sum(year1.tweets.DF.texts.Sentiment$trust)
year1.tweets.negative =sum(year1.tweets.DF.texts.Sentiment$negative)

# BAR CHART ON CALCULATED SENTIMENTS
year1.tweets.yAxis <- c(year1.tweets.positive,
                     + year1.tweets.anger,
                     + year1.tweets.anticipation,
                     + year1.tweets.disgust,
                     + year1.tweets.fear,
                     + year1.tweets.joy,
                     + year1.tweets.sadness,
                     + year1.tweets.surprise,
                     + year1.tweets.trust,
                     + year1.tweets.negative)

year1.tweets.xAxis <- c("Positive","Anger","Anticipation","Disgust","Fear",
                     "Joy","Sadness","Surprise","Trust","Negative")

year1.tweets.colors <- c("green","red","blue",
                      "orange","red","green","orange","blue","green","red")

year1.tweets.yRange <- range(0, year1.tweets.yAxis) 

barplot(year1.tweets.yAxis, names.arg = year1.tweets.xAxis, 
        xlab = "Sentiment Analysis", ylab = "Score", 
        main = "ELON MUSK'S TWEET (YEAR-2011) SENTIMENT ANALYSIS", 
        col = year1.tweets.colors, border = "black", ylim = year1.tweets.yRange, 
        xpd = F, axisnames = T, cex.axis = 0.8, cex.sub = 0.8, col.sub = "blue")


year1.tweets.tdm.matrix <- as.matrix(year1.tweets.tdm)

year1.tweets.word_freqs <- sort(rowSums(year1.tweets.tdm.matrix), decreasing=TRUE) 
year1.tweets.dm <- data.frame(word=names(year1.tweets.word_freqs), freq=year1.tweets.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS

wordcloud(year1.tweets.dm$word, year1.tweets.dm$freq, 
          min.freq = 50, max.words = 35, random.order=FALSE, colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
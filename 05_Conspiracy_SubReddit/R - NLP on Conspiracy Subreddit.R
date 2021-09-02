################################################################################
## R - NLP & Text Mining Project 

## Analysis of Sub-Reddit where people discuss conspiracy theories.

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
##------------------------------------------------------------------------------

conspiracy.df <- read.csv("D:\\001_Data\\NLP\\R\\Conspiracy Reddit Group\\reddit_ct.csv")
head(conspiracy.df$title)
conspiracy.df2 <- conspiracy.df$title
length(conspiracy.df2)


## TASK 2 - CLEANING THE TWEETS
##------------------------------------------------------------------------------

conspiracy.df2 <- gsub('http\\S+\\s*', '', conspiracy.df2) ## Remove URLs
conspiracy.df2 <- gsub('https:\\S+\\s*', '', conspiracy.df2) ## Remove URLs
conspiracy.df2 <- gsub('https\\S+\\s*', '', conspiracy.df2) ## Remove URLs
conspiracy.df2 <- gsub('\\b+RT', '', conspiracy.df2) ## Remove RT
conspiracy.df2 <- gsub('#\\S+', '', conspiracy.df2) ## Remove Hashtags
conspiracy.df2 <- gsub('@\\S+', '', conspiracy.df2) ## Remove Mentions
conspiracy.df2 <- gsub('[[:cntrl:]]', '', conspiracy.df2) ## Remove Controls and special characters
conspiracy.df2 <- gsub("\\d", '', conspiracy.df2) ## Remove Controls and special characters
conspiracy.df2 <- gsub('[[:punct:]]', '', conspiracy.df2) ## Remove Punctuations
conspiracy.df2 <- gsub("^[[:space:]]*","", conspiracy.df2) ## Remove leading whitespaces
conspiracy.df2 <- gsub("[[:space:]]*$","", conspiracy.df2) ## Remove trailing whitespaces
conspiracy.df2 <- gsub(' +',' ', conspiracy.df2) ## Remove extra whitespaces
conspiracy.df2 <- gsub('[^[:graph:]]',' ', conspiracy.df2) ## Remove special chars



## TASK 3 - CALCULATING SENTIMENTS/ EMOTIONS
##------------------------------------------------------------------------------

conspiracy.word.df <- as.vector(conspiracy.df2)
conspiracy.emotion.df <- get_nrc_sentiment(conspiracy.word.df)
conspiracy.emotion.df2 <- cbind(conspiracy.df2, conspiracy.emotion.df) 
head(conspiracy.word.df)
head(conspiracy.emotion.df2)



## TASK 4 - FINDING THE MOST POSITIVE & NEGATIVE TWEET
##------------------------------------------------------------------------------

conspiracy.sent.value <- get_sentiment(conspiracy.word.df)

conspiracy.positive.tweets <- conspiracy.word.df[conspiracy.sent.value > 0]
conspiracy.negative.tweets <- conspiracy.word.df[conspiracy.sent.value < 0]
conspiracy.neutral.tweets <- conspiracy.word.df[conspiracy.sent.value == 0]

conspiracy.most.positive <- conspiracy.word.df[conspiracy.sent.value == max(conspiracy.sent.value)]
print(conspiracy.most.positive)

conspiracy.most.negative <- conspiracy.word.df[conspiracy.sent.value <= min(conspiracy.sent.value)] 
print(conspiracy.most.negative)



## TASK 5 - CREATING PIE CHART OF CALCULATED SENTIMENTS
##------------------------------------------------------------------------------

conspiracy.Positive <- length(conspiracy.positive.tweets)
conspiracy.Neutral <- length(conspiracy.neutral.tweets)
conspiracy.Negative <- length(conspiracy.negative.tweets)

conspiracy.Sentiments <- c(conspiracy.Positive, conspiracy.Neutral,
                             conspiracy.Negative)

print(conspiracy.Sentiments)

conspiracy.labels <- c("Positive", "Negative", "Neutral")

pie(conspiracy.Sentiments, conspiracy.Sentiments,
    main = "Sentiment Analysis On Conspiracy Sub Reddit",
    col = rainbow(length(conspiracy.Sentiments)))

legend('topright', conspiracy.labels, cex=0.8,
       fill = rainbow(length(conspiracy.labels)))



## TASK 6 - TERM DOCUMENT MATRIX OF PFIZER TWEETS
##------------------------------------------------------------------------------

conspiracy.tweet_corpus <- Corpus(VectorSource(conspiracy.word.df))


conspiracy.tdm <- TermDocumentMatrix(conspiracy.tweet_corpus,
control = list(removePunctuation = TRUE, wordLengths=c(5, 15),
               stopwords = c('comment', 'conspiracy', 'theory', 
                 'theories', 'google'),stopwords("english"),
              removeNumbers = TRUE, tolower = TRUE))

conspiracy.tdm.matrix <- as.matrix(conspiracy.tdm)

conspiracy.word_freqs <- sort(rowSums(conspiracy.tdm.matrix), decreasing=TRUE) 
conspiracy.dm <- data.frame(word=names(conspiracy.word_freqs), freq=conspiracy.word_freqs)


## TASK 7 - PREPARING THE WORD CLOUD TO EXTRACT INSIGHTS
##------------------------------------------------------------------------------
  
wordcloud(conspiracy.dm$word, conspiracy.dm$freq, 
          min.freq = 3, max.words = 50, random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))


## THE END

################################################################################
################################################################################
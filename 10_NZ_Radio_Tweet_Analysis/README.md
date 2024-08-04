# NLP & Text Mining project on 3 popular NZ Radio's Tweets.
*This repo has NLP and Text Mining tasks performed on NZ Radio channel's tweet: Magic Talk Radio, News Talk ZB, Radio NZ.*

<hr></hr>

## How were these projects done?
- The tweets/ text data is imported first.
- The imported data is cleaned using the R function called [gsub()](https://www.journaldev.com/43690/sub-and-gsub-function-r#the-gsub-function-in-r) which is used to replace all the matches of a pattern from a string. If the pattern is not found the string will be returned as it is.
- After cleaning the text data, the sentiment of each and every tweet is calculated using the R function called [get_nrc_sentiment()](https://www.rdocumentation.org/packages/syuzhet/versions/1.0.6/topics/get_nrc_sentiment) which calculates the presence of eight different emotions and their corresponding valence in the tweets/ text data. Then, the tweets are concatenated with their corresponding emotion.
- Once the sentiments are calculated, I have found the most positive and negative tweets in the data set.
- A pie chart is generated to visually see the distribution and number of positive, negative and neutral tweets in the data set.
- After creating the pie chart, I have created a bar chart to visually classify the 8 different emotions (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust) and two sentiments (negative and positive) present in our data set.
- After calculating the sentiments and emotions, I have create the the ***Term Document Matrix*** to count the occurrence of each word, to identify popular or trending topics using the R function called [TermDocumentMatrix()](https://www.rdocumentation.org/packages/tm/versions/0.7-8/topics/TermDocumentMatrix). This step generates a table containing the frequency of words. 
- Using the TermDocumentMatrix, I have created a Word Cloud which is one of the most popular ways to visualize and analyze qualitative data. It’s an image composed of keywords found within a body of text, where the size of each word indicates its frequency in that body of text. The word cloud is generated using the R function called [WordCloud](https://www.rdocumentation.org/packages/wordcloud/versions/2.6/topics/wordcloud) .

<hr></hr>

## Project 1: NLP & Text Mining on Magic Talk Radio's Tweets.

**1.1 Sentiment Pie Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Magic%20Talks%20Radio/Pie%20Chart%20-%20MT.png" width="600" height="500"/>

**1.2 Emotions Bar Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Magic%20Talks%20Radio/Bar%20Chart%20-%20MT.png" width="600" height="400"/>

**1.3 Popular Topics discussed by Magic Talks Radio:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Magic%20Talks%20Radio/Word%20Cloud%20-%20MT.png" width="600" height="500"/>

[**1.4 Project 1 R Script**](https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Magic%20Talks%20Radio/R%20-%20NLP%20Magic%20Talks%20Radio.R)

<hr></hr>
<hr></hr>

## Project 2: NLP & Text Mining on News Talk Radio's Tweets.

**2.1 Sentiment Pie Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20News%20Talk%20ZB/Pie%20-%20NT.png" width="600" height="500"/>

**2.2 Emotions Bar Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20News%20Talk%20ZB/Bar%20-%20NT.png" width="600" height="400"/>

**2.3 Popular Topics discussed by News Talk Radio:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20News%20Talk%20ZB/WC%20-%20NT.png" width="600" height="500"/>

[**2.4 Project 2 R Script**](https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20News%20Talk%20ZB/R%20-%20NLP%20News%20Talk%20ZB.R)

<hr></hr>
<hr></hr>

## Project 3: NLP & Text Mining on Radio New Zealand Tweets.

**3.1 Sentiment Pie Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Radio%20NZ/Pie%20-%20RNZ.png" width="600" height="500"/>

**3.2 Emotions Bar Chart:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Radio%20NZ/Bar%20-%20RNZ.png" width="600" height="400"/>

**3.3 Popular Topics discussed by Radio New Zealand:**

<img src="https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Radio%20NZ/WC%20-%20RNZ.png" width="600" height="500"/>

[**3.4 Project 3 R Script**](https://github.com/drdataSpp/Spp-NLP-NZ-Radio-Tweets/blob/master/NLP%20-%20Radio%20NZ/R%20-%20NLP%20Radio%20NZ.R)

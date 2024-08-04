# NLP & Text Mining On Elon Musks Tweets

*Using NLP and Text Mining techniques to analyze Elon Musk's tweets from 2011 to 2021.*

<hr></hr>

## How was this project done?
- The tweets/ text data is imported first.
- The imported data is cleaned using the R function called [gsub()](https://www.journaldev.com/43690/sub-and-gsub-function-r#the-gsub-function-in-r) which is used to replace all the matches of a pattern from a string. If the pattern is not found the string will be returned as it is.
- After cleaning the text data, the sentiment of each and every tweet is calculated using the R function called [get_nrc_sentiment()](https://www.rdocumentation.org/packages/syuzhet/versions/1.0.6/topics/get_nrc_sentiment) which calculates the presence of eight different emotions and their corresponding valence in the tweets/ text data. Then, the tweets are concatenated with their corresponding emotion.
- Once the sentiments are calculated, I have found the most positive and negative tweets in the data set.
- A pie chart is generated to visually see the distribution and number of positive, negative and neutral tweets in the data set.
- After creating the pie chart, I have created a bar chart to visually classify the 8 different emotions (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust) and two sentiments (negative and positive) present in our data set.
- After calculating the sentiments and emotions, I have create the the ***Term Document Matrix*** to count the occurrence of each word, to identify popular or trending topics using the R function called [TermDocumentMatrix()](https://www.rdocumentation.org/packages/tm/versions/0.7-8/topics/TermDocumentMatrix). This step generates a table containing the frequency of words. 
- Using the TermDocumentMatrix, I have created a Word Cloud which is one of the most popular ways to visualize and analyze qualitative data. It’s an image composed of keywords found within a body of text, where the size of each word indicates its frequency in that body of text. The word cloud is generated using the R function called [WordCloud](https://www.rdocumentation.org/packages/wordcloud/versions/2.6/topics/wordcloud) .

<hr></hr>

## 1. Analyzing Elon Musk's Tweets from *2011 to 2012*.

## [1.1 Sentiment Pie Chart (2011)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2011_Tweet_Analysis/2011%20-%20SA%20Pie%20Chart.png)

## [1.2 Emotions Bar Chart (2011)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2011_Tweet_Analysis/2011%20-%20SA%20Bar%20Chart.png)

## [1.3 Word Cloud Analysis (2011)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2011_Tweet_Analysis/2011%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2011_Tweet_Analysis/2011%20-%20SA%20Word%20Cloud.png" width="600" height="500"/>

## [1.4 2011 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2011_Tweet_Analysis/2011-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 2. Analyzing Elon Musk's Tweets from *2012 to 2013*.

## [2.1 Sentiment Pie Chart (2012)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2012_Tweet_Analysis/2012%20-%20SA%20Pie%20Chart.png)

## [2.2 Emotions Bar Chart (2012)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2012_Tweet_Analysis/2012%20-%20SA%20Bar%20Chart.png)

## [2.3 Word Cloud Analysis (2012)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2012_Tweet_Analysis/2012%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2012_Tweet_Analysis/2012%20-%20SA%20Word%20Cloud.png" width="600" height="500"/>

## [2.4 2012 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2012_Tweet_Analysis/2012-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 3. Analyzing Elon Musk's Tweets from *2013 to 2014*.

## [3.1 Sentiment Pie Chart (2013)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2013_Tweet_Analysis/2013%20-%20SA%20Pie%20Chart.png)

## [3.2 Emotions Bar Chart (2013)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2013_Tweet_Analysis/2013%20-%20SA%20Bar%20Chart.png)

## [3.3 Word Cloud Analysis (2013)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2013_Tweet_Analysis/2013%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2013_Tweet_Analysis/2013%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [3.4 2013 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2013_Tweet_Analysis/2013-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 4. Analyzing Elon Musk's Tweets from *2014 to 2015*.

## [4.1 Sentiment Pie Chart (2014)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2014_Tweet_Analysis/2014%20-%20SA%20Pie%20Chart.png)

## [4.2 Emotions Bar Chart (2014)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2014_Tweet_Analysis/2014%20-%20SA%20Bar%20Chart.png)

## [4.3 Word Cloud Analysis (2014)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2014_Tweet_Analysis/2014%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2014_Tweet_Analysis/2014%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [4.4 2014 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2014_Tweet_Analysis/2014-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 5. Analyzing Elon Musk's Tweets from *2015 to 2016*.

## [5.1 Sentiment Pie Chart (2015)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2015_Tweet_Analysis/2015%20-%20SA%20Pie%20Chart.png)

## [5.2 Emotions Bar Chart (2015)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2015_Tweet_Analysis/2015%20-%20SA%20Bar%20Chart.png)

## [5.3 Word Cloud Analysis (2015)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2015_Tweet_Analysis/2015%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2015_Tweet_Analysis/2015%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [5.4 2015 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2015_Tweet_Analysis/2015-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 6. Analyzing Elon Musk's Tweets from *2016 to 2017*.

## [6.1 Sentiment Pie Chart (2016)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2016_Tweet_Analysis/2016%20-%20SA%20Pie%20Chart.png)

## [6.2 Emotions Bar Chart (2016)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2016_Tweet_Analysis/2016%20-%20SA%20Bar%20Chart.png)

## [6.3 Word Cloud Analysis (2016)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2016_Tweet_Analysis/2016%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2016_Tweet_Analysis/2016%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [6.4 2016 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2016_Tweet_Analysis/2016-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 7. Analyzing Elon Musk's Tweets from *2017 to 2018*.

## [7.1 Sentiment Pie Chart (2017)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2017_Tweet_Analysis/2017%20-%20SA%20Pie%20Chart.png)

## [7.2 Word Cloud Analysis (2017)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2017_Tweet_Analysis/2017%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2017_Tweet_Analysis/2017%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [7.3 2017 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2017_Tweet_Analysis/2017-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 8. Analyzing Elon Musk's Tweets from *2018 to 2019*.

## [8.1 Sentiment Pie Chart (2018)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2018_Tweet_Analysis/2018%20-%20SA%20Pie%20Chart.png)

## [8.2 Word Cloud Analysis (2018)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2018_Tweet_Analysis/2018%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2018_Tweet_Analysis/2018%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [8.3 2018 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2018_Tweet_Analysis/2018-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>

## 9. Analyzing Elon Musk's Tweets from *2019 to 2020*.

## [9.1 Sentiment Pie Chart (2019)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2019_Tweet_Analysis/2019%20-%20SA%20Pie%20Chart.png)

## [9.2 Word Cloud Analysis (2019)](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2019_Tweet_Analysis/2019%20-%20SA%20Word%20Cloud.png)

<img src="https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2019_Tweet_Analysis/2019%20-%20SA%20Word%20Cloud.png" width="600" height="400"/>

## [9.3 2019 Tweet Analysis - R Script Link](https://github.com/drdataSpp/Spp-NLP-On-Elon-Musks-Tweets/blob/master/2019_Tweet_Analysis/2019-Elon%20Musk%20Tweet%20Analysis.R)

<hr></hr>



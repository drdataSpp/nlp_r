# NLP & Text Mining On Womens Ecommerce Clothing Reviews
This repository has R Scripts in which I have performed NLP and Text Mining on Women’s Clothing E-Commerce dataset revolving around the reviews written by customers.  

## How this project was done?
- The text data is imported first.
- The imported data is cleaned using the R function called [gsub()](https://www.journaldev.com/43690/sub-and-gsub-function-r#the-gsub-function-in-r) which is used to replace all the matches of a pattern from a string. If the pattern is not found the string will be returned as it is.
- After cleaning the text data, the sentiment of each and every tweet is calculated using the R function called [get_nrc_sentiment()](https://www.rdocumentation.org/packages/syuzhet/versions/1.0.6/topics/get_nrc_sentiment) which calculates the presence of eight different emotions and their corresponding valence in the tweets/ text data. Then, the tweets are concatenated with their corresponding emotion.
- Once the sentiments are calculated, I have found the most positive and negative tweets in the data set.
- A pie chart is generated to visually see the distribution and number of positive, negative and neutral tweets in the data set.
- After creating the pie chart, I have created a bar chart to visually classify the 8 different emotions (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust) and two sentiments (negative and positive) present in our data set.
- After calculating the sentiments and emotions, I have create the the ***Term Document Matrix*** to count the occurrence of each word, to identify popular or trending topics using the R function called [TermDocumentMatrix()](https://www.rdocumentation.org/packages/tm/versions/0.7-8/topics/TermDocumentMatrix). This step generates a table containing the frequency of words. 
- Using the TermDocumentMatrix, I have created a Word Cloud which is one of the most popular ways to visualize and analyze qualitative data. It’s an image composed of keywords found within a body of text, where the size of each word indicates its frequency in that body of text. The word cloud is generated using the R function called [WordCloud](https://www.rdocumentation.org/packages/wordcloud/versions/2.6/topics/wordcloud) .

## How the analysis was performed?
- The orginal dataset was split into two subsets namely: Positive reviews and Negative Reviews.
- This subsets were used to perform NLP and Text Mining seperately to extract insights. 
- **The main purpose** of this project is to build a word cloud to understand what are the most used words while classifying a cloth as a good or a bad one. 

## How an executive is benefited here?
The Executive can note the most frequent terms/ words in the negative reviews word cloud and improve the clothing based on those factors, for example, he or she could work on improving the quality of the fabric and material of the cloth to imporve customer satisfaction.  


## What people like about the clothes?
<img src="https://github.com/drdataSpp/Spp-NLP-On-Womens-Ecommerce-Clothing-Reviews/blob/master/Word%20Cloud%20-%20Positive%20Reviews.png" width="600" height="400"/>

**Top words:** 
- Color
- Fabric
- Comfortable
- Etc..

## What people dislike about the clothes?
<img src="https://github.com/drdataSpp/Spp-NLP-On-Womens-Ecommerce-Clothing-Reviews/blob/master/Word%20Cloud%20-%20Negative%20Reviews.png" width="600" height="400"/>

**Top words:** 
- Small
- Fabric
- Material
- Quality 
- Color
- Etc..


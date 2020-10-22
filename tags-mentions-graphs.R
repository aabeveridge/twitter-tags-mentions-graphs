library(quanteda)
library(readtext)
library(ndjson)
library(tidyverse)

#####################################################################################################
# workflow for converting Twitter json, reducing dataset, renaming variables, and saving as CSV file
#####################################################################################################

# tweets.data <- stream_in('senator-tweets.json') %>%
#   as_tibble() %>%
#   select(created_at, text, user.description, user.favourites_count,
#          user.followers_count, user.friends_count, user.location,
#          user.name, user.screen_name, user.statuses_count,
#          entities.user_mentions.0.screen_name, retweeted_status.user.screen_name,
#          entities.urls.0.expanded_url, retweeted_status.user.entities.url.urls.0.expanded_url,
#          retweet_count) %>%
#   rename(tweet.datetime = created_at, total.favorites = user.favourites_count,
#          total.followers = user.followers_count, total.friends = user.friends_count,
#          screen.name = user.screen_name, total.statuses = user.statuses_count,
#          tweet.mentions = entities.user_mentions.0.screen_name,
#          retweet.mentions = retweeted_status.user.screen_name, url = entities.urls.0.expanded_url,
#          retweet.url = retweeted_status.user.entities.url.urls.0.expanded_url, total.retweets = retweet_count)
#
# write.csv(tweets.data, file="senator-tweets.csv")

#############################################
# read in CSV and convert to quanteda corpus
#############################################

# read in csv file of tweets
tweets.data <- readtext('senator-tweets.csv', text_field='text')

# convert to quanteda corpus structure
tweets.corpus <- corpus(tweets.data)

# convert to document feature matrix
tweet.dfm <- dfm(tweets.corpus, remove_punct = TRUE)

# explore
head(tweet.dfm)

#######################
# explore top hashtags
#######################

# extract the most frequently used hashtags
tag.dfm <- dfm_select(tweet.dfm, pattern = ("#*"))
toptag <- names(topfeatures(tag.dfm, 50))

# explore top hashtags
head(toptag)

#################################
# graph co-occurance of hashtags
#################################

# construct feature co-occurance matrix
tag.fcm <- fcm(tag.dfm)
head(tag.fcm)

# create graph of co-occurance relationships for tags
topgat.fcm <- fcm_select(tag.fcm, pattern = toptag)
textplot_network(topgat.fcm, min_freq = 0.1, edge_alpha = 0.8, edge_size = 5)

########################
# explore top usernames
########################

# extract the most frequently mentioned usernames
user.dfm <- dfm_select(tweet.dfm, pattern = "@*")
topuser <- names(topfeatures(user.dfm, 50))

# explore top usernames
head(topuser)

##########################################
# graph co-occurance of username mentions
##########################################

# construct feature co-occurance matrix of usernames
user.fcm <- fcm(user.dfm)
head(user.fcm)

# create a graph of co-occurance relationships for mentioned usernames
user.fcm <- fcm_select(user.fcm, pattern = topuser)
textplot_network(user.fcm, min_freq = 0.1, edge_color = "orange", edge_alpha = 0.8, edge_size = 5)

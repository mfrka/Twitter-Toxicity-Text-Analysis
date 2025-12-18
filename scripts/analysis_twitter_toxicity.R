# Library 
setwd("~/NEW LIFE/For Portofolio")
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)
library(tidytext)
library(skimr)

# Membersihkan Environment
rm(list = ls())
options(stringsAsFactors = FALSE)

#Load Data dan Melihat struktur data
twitter_toxic_tweets <- read_csv("Data/twitter_toxic_tweets.csv")
glimpse(twitter_toxic_tweets)

# Data hilang dan duplikat
colSums(is.na(twitter_toxic_tweets))
sum(duplicated(twitter_toxic_tweets))

# Label Tweets
twitter_toxic_tweets <- twitter_toxic_tweets %>%mutate(label = 
        factor(label, levels = c(0, 1),labels = 
        c("Non-Toxic", "Toxic")))

# Panjang Tweets
twitter_toxic_tweets <- twitter_toxic_tweets %>%mutate(
                        tweet_length = str_length(tweet),
                        word_count   = str_count(tweet, "\\S+"))

# Text Cleaning
twitter_toxic_tweets <- twitter_toxic_tweets %>%
  mutate(
    tweet_clean = tweet %>%
      str_to_lower() %>%
      str_remove_all("http\\S+") %>%   # remove URLs
      str_remove_all("@\\w+") %>%      # remove mentions
      str_remove_all("#\\w+") %>%      # remove hashtags
      str_remove_all("[[:punct:]]") %>%
      str_squish()
  )

# Distribusi Label 
label_summary <- twitter_toxic_tweets %>%
  count(label) %>%
  mutate(percent = n / sum(n) * 100)

# Visualisasi Proporsi Toxic
Proporsi_Toxic <- ggplot(label_summary, aes(x = label, y = n, fill = label)) +
  geom_col(show.legend = FALSE) + labs(title = "Distribusi Tweet Toxic vs Non-Toxic",
    x = NULL, y = "Jumlah Tweet") + theme_minimal()

ggsave(filename = "~/NEW LIFE/For Portofolio/Output/Proporsi Toxic vs Non-Toxic.png",
       plot = Proporsi_Toxic, width = 7, height = 5, dpi = 300)

# Panjang Tweet vs Toxicity
Panjang_tweet <- ggplot(twitter_toxic_tweets, aes(x = label, y = tweet_length, fill = label)) +
  geom_boxplot(show.legend = FALSE) + labs(title = "Panjang Tweet berdasarkan Toxicity",
    x = NULL, y = "Jumlah Karakter") + theme_minimal()

ggsave(filename = "~/NEW LIFE/For Portofolio/Output/Panjang tweet Toxic vs Non-Toxic.png",
       plot = Panjang_tweet, width = 7, height = 5, dpi = 300)

# Tokenisasi tweet 
tweet_words <- twitter_toxic_tweets %>%
  select(id, label, tweet) %>%
  unnest_tokens(word, tweet)

# Text Cleaning
data("stop_words")
tweet_words_clean <- tweet_words %>%
  anti_join(stop_words, by = "word") %>%
  filter(str_detect(word, "^[a-z]+$"))

# Kata Paling Sering Muncul (Global)
top_words <- tweet_words_clean %>%
  count(word, sort = TRUE) %>%
  slice_head(n = 15)

plot_top_words <- top_words %>% ggplot(aes(x = reorder(word, n), y = n, fill = n)) +
  geom_col(alpha = 0.9) + coord_flip() + scale_fill_gradient(low = "#A6CEE3", high = "#1F78B4") +
  labs(title = "15 Kata Paling Sering Muncul dalam Tweet",
       subtitle = "Berdasarkan keseluruhan dataset",
       x = NULL, y = "Frekuensi") + theme_minimal(base_size = 13) + 
  theme(plot.title = element_text(face = "bold"), panel.grid.minor = element_blank(), legend.position = "none")

ggsave(filename = "~/NEW LIFE/For Portofolio/Output/15 Kata Paling Sering Muncul.png",
       plot = plot_top_words, width = 7, height = 5, dpi = 300)

# Topik Paling Sering Setiap Label
top_words_label <- tweet_words_clean %>%
  count(label, word, sort = TRUE) %>%
  group_by(label) %>%
  slice_head(n = 10);top_words_label

top_tweet <- top_words_label %>% mutate(word = reorder_within(word, n, label)) %>%
  ggplot(aes(x = word, y = n, fill = label)) + geom_col(show.legend = FALSE, alpha = 0.85) +
  facet_wrap(~label, scales = "free") + scale_x_reordered() + coord_flip() +
  labs(title = "10 Kata Paling Sering Muncul Berdasarkan Kategori Tweet", 
       x = NULL, y = "Frekuensi Kemunculan") + theme_minimal(base_size = 12)

ggsave(filename = "~/NEW LIFE/For Portofolio/Output/Top Tweet Toxic vs Non-Toxic.png",
       plot = top_tweet, width = 7, height = 5, dpi = 300)

# TF-IDF (Kata Khas Toxic vs Non-Toxic)
tfidf_words <- tweet_words_clean %>%
  count(label, word) %>%
  bind_tf_idf(word, label, n)

# Top TF-IDF Per Label
top_tfidf <- tfidf_words %>%
  group_by(label) %>%
  slice_max(tf_idf, n = 10)

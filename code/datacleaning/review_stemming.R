library(SnowballC)
df = read.csv("review_cleaned.csv")
df$text = as.character(df$text)

words = df %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)

#stemming
wordss = df %>%
  unnest_tokens(word,text) %>%
  mutate(stem = wordStem(word)) %>%
  count(stem,sort=TRUE)

words.5 = df[which(df$stars==5),] %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)

words.4 = df[which(df$stars==4),] %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)

words.3 = df[which(df$stars==3),] %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)

words.2 = df[which(df$stars==2),] %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)

words.1 = df[which(df$stars==1),] %>%
  unnest_tokens(word,text) %>%
  count(word,sort=TRUE)
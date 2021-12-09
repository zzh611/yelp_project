library(tidyverse)
library(tidytext)
library(tm)
library(textcat)
library(fastText)
d = read.csv("review.csv")
t = d$text
t = as.character(t)
clean <- function(x) {
  x %>%
    str_remove_all(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)") %>%
    str_remove_all("#[[:alnum:]_]+") %>%
    str_replace_all("&amp;", "and") %>%
    str_remove_all("[[:punct:]]") %>%
    str_remove_all("[[:digit:]]") %>%
    str_replace_all("\\\n", " ") %>%
    str_to_lower() %>%
    removeWords(stopwords("en")) %>%
    str_replace_all(" us "," ") %>%
    str_replace_all(" just "," ") %>%
    str_replace_all(" dont ", " ") %>%
    str_replace_all(" im "," ") %>%
    str_replace_all(" ive "," ") %>%
    str_replace_all(" didnt "," ") %>%
    str_replace_all(" one "," ") %>%
    str_replace_all(" two "," ") %>%
    str_trim("both")
}
t1 = t %>% clean
t1 = gsub("([[:alpha:]])\\1{2,}", "\\1",t1)


file_pretrained = system.file("language_identification/lid.176.ftz", package = "fastText")
l = language_identification(t1,pre_trained_language_model_path = file_pretrained,verbose=T)
d1 = d
d1$text = t1
d1 = d1[-which(l$iso_lang_1!="en"),]
write.csv(d1,"review_cleaned.csv")
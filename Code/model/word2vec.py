import pandas as pd
import re 
from nltk.tokenize import sent_tokenize
from gensim.models import Word2Vec

# read dataset
review = pd.read_csv("review.csv")
review['text'] = [i.replace('  ',' ').replace('  ', ' ') for i in review['text']]
good_reviews = ''.join(review[review['stars'] > 3]['text'])
# split the long string into sentences
sentences_good = sent_tokenize(good_reviews)
good_token_clean = list()
# get tokens for each sentence
for sentence in sentences_good:
    eng_word = re.findall(r'[A-Za-z\-]+', sentence)
    good_token_clean.append([i.lower() for i in eng_word])
model_ted = Word2Vec(sentences=good_token_clean, vector_size=100, window=10, min_count=1, workers=8, sg=0)
with open('good_service.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['service'], topn=10))
with open('good_food.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['food'], topn=10))
with open('good_price.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['price'], topn=10))
with open('good_atmosphere.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['atmosphere'], topn=10))
with open('staff.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['staff'], topn=10))
with open('meat.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['meat'], topn=10))
with open('pork.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['pork'], topn=10))
with open('beef.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['beef'], topn=10))
with open('chicken.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['chicken'], topn=10))
with open('place.txt', 'w') as f:
    f.write(model_ted.predict_output_word(['place'], topn=10))
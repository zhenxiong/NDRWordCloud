library(tm)
library(wordcloud)
library(RColorBrewer)

#reading text file
speech <- scan("./ndr2015.txt", skip=7, what="character")

# create a corpus
speech_corpus = Corpus(VectorSource(speech))

# create document term matrix applying some transformations
tdm = TermDocumentMatrix(speech_corpus,
                         control = list(removePunctuation = TRUE,
                                        stopwords = c("will", stopwords("english")),
                                        removeNumbers = TRUE, tolower = TRUE))

# define tdm as matrix
m = as.matrix(tdm)

# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 

# create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

# plot wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

# save the image in png format
png("2015RallyWordCloud.png", width=12, height=8, units="in", res=300)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()
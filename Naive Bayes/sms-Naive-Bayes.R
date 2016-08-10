# load data
sms <- read.csv('sms_spam.csv',header = T,stringsAsFactors = F)
sms$type <- as.factor(sms$type)
str(sms)
table(sms$type)

# create courpus : print(vignette("tm"))
library(NLP)
library(tm)
sms.corpus <- Corpus(VectorSource(sms$text))
inspect(sms.corpus)
sms.corpus.clean <- tm_map(sms.corpus.clean,stripWhitespace) ## 去除额外空格
sms.corpus.clean <- tm_map(sms.corpus,tolower) ## 小写
sms.corpus.clean <- tm_map(sms.corpus.clean,removeNumbers) ## 去除数字
sms.corpus.clean <- tm_map(sms.corpus.clean,removePunctuation) ## 去除标点符号
sms.corpus.clean <- tm_map(sms.corpus.clean,removeWords,stopwords()) ## 去除停用词,自带停用词词库(仅英文、德文)stopwords()
sms.corpus.clean <- tm_map(sms.corpus.clean,PlainTextDocument) ## 转为PlainTextDocument，预防性代码
inspect(sms.corpus.clean)

# classify data
ham <- subset(sms,type == 'ham')
spam <- subset(sms,type == 'spam')

# word cloud


library(RColorBrewer)
library(wordcloud)
wordcloud(sms.corpus.clean, min.freq = 50,random.order = F)


# dtm
sms_dtm <- DocumentTermMatrix(sms.corpus.clean)


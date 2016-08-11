# load data
sms <- read.csv('sms_spam.csv',header = T,stringsAsFactors = F)
str(sms)
sms$type <- as.factor(sms$type)
table(sms$type)

# word cloud
ham <- subset(sms,type=='ham')
spam <- subset(sms,type=='spam')
library(RColorBrewer)
library(wordcloud)
wordcloud(ham$text,max.words = 50,random.order = F)
wordcloud(spam$text,max.words = 50,random.order = F)
wordcloud(sms$text,min.freq = 5,random.order = F,scale = c(4,0.5))

# create courpus : print(vignette("tm"))
library(NLP)
library(tm)
sms.corpus <- Corpus(VectorSource(sms$text))
inspect(sms.corpus)
sms.corpus.clean <- tm_map(sms.corpus,stripWhitespace) ## 去除额外空格
sms.corpus.clean <- tm_map(sms.corpus.clean,tolower) ## 小写
sms.corpus.clean <- tm_map(sms.corpus.clean,removeNumbers) ## 去除数字
sms.corpus.clean <- tm_map(sms.corpus.clean,removePunctuation) ## 去除标点
sms.corpus.clean <- tm_map(sms.corpus.clean,removeWords,stopwords()) ## 去除停用词,自带停用词词库(仅英文、德文)stopwords()
sms.corpus.clean <- tm_map(sms.corpus.clean,PlainTextDocument) ## 转为PlainTextDocument，预防性代码
inspect(sms.corpus.clean)

# split data
n <- length(sms$type)
set.seed(9)
train.id <- sample(n,n*0.7)
train <- sms[train.id,]
test <- sms[-train.id,]
table(train$type)
test(test$type)


sms.corpus.clean.train <- sms.corpus.clean[train.id]
sms.corpus.clean.test <- sms.corpus.clean[-train.id]

# dtm
sms.dtm.train <- DocumentTermMatrix(sms.corpus.clean.train)
sms.dtm.test <- DocumentTermMatrix(sms.corpus.clean.test)
sms_dict <- findFreqTerms(sms.dtm.train,5) ## feature words
sms.dtm.train <- DocumentTermMatrix(sms.corpus.clean.train,list(dictionary = sms_dict))
sms.dtm.test <- DocumentTermMatrix(sms.corpus.clean.test,list(dictionary = sms_dict))

# matrix
sms.dtm.train <- as.matrix(sms.dtm.train)
sms.dtm.test <- as.matrix(sms.dtm.test)
nrow(sms.dtm.train)
nrow(sms.dtm.test)

# convert matrix
convert <- function(x){
  x[x!=0] <- 1
  return(x)
}
sms.dtm.train <- t(as.matrix(apply(sms.dtm.train,1,convert))) ## 1-row,2-col
sms.dtm.test <- t(as.matrix(apply(sms.dtm.test,1,convert)))

+# naive bayes model
library(e1071)
naiveBayesModel <- naiveBayes(sms.dtm.train,train$type) ## 不含拉普拉斯因子
naiveBayesModel <- naiveBayes(sms.dtm.train,train$type,laplace = 5)
test.naiveBayes.predict <- predict(naiveBayesModel,sms.dtm.test)
table(test.naiveBayes.predict,test$type)

# evluate model
library(gmodels)
CrossTable(test.naiveBayes.predict,test$type,prop.chisq = F,prop.t = F,dnn = c('predicted','actual'))



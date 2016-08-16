# load data
wdbc <- read.csv('wdbc.data.csv',head = T)
head(wdbc)
summary(wdbc)

# clean data has been done in min-max normalize kNN

# Z-Score function : scale()
wdbc.zscore <- as.data.frame(scale(wdbc[-c(1,2)]))
head(wdbc.zscore) ## 正太标准化，突出异常值权重,均值为0
summary(wdbc.zscore)
wdbc.zscore$Diagnosis <- wdbc$Diagnosis

# split data
set.seed(689)
n <- length(wdbc.zscore$radius_mean)
train.id <- sample(n,n*0.7)
train <- wdbc.zscore[train.id,]
test <- wdbc.zscore[-train.id,]

# kNN model
library(class)
# k值：近邻/投票个数：1，3，5，7
knn(train[,-31],test[,-31],train[,31],k = 3)
test.knn.predict<- knn(train[,-31],test[,-31],train[,31],k = 7)

# evaluate model
library(gmodels)
CrossTable(test$Diagnosis,test.knn.predict,digits = 2)

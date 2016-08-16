# load data
whitewines <- read.csv('whitewines.csv',header = T,stringsAsFactors = F)
str(whitewines)

# explore data
summary(whitewines)
hist(whitewines$quality) ## 钟形分布

# split data
set.seed(45)
train.id <- sample(length(whitewines$quality),length(whitewines$quality)*0.75)
train <- whitewines[train.id,]
test <- whitewines[-train.id,]

# CART:回归树(Classification and Regression Tree)
library(rpart)
wine.rpart <- rpart(quality~.,data = train)
summary(wine.rpart)
library(rpart.plot)
rpart.plot(wine.rpart,digits = 2)
rpart.plot(wine.rpart,digits = 2,fallen.leaves = T)
rpart.plot(wine.rpart,digits = 2,fallen.leaves = T,type = 2)
rpart.plot(wine.rpart,digits = 2,fallen.leaves = T,type = 3,extra = 101)

# predict test
test.predict <- predict(wine.rpart,test[,-12],type = 'vector') ## vector:预测数值,class:预测类别,prob:预测类别的概率
summary(test.predict)
summary(test$quality)

# evluate model
cor(test$quality,test.predict)
MAE <- function(actual,predicted) { return(c(mean(abs(actual-predicted)),mean(actual),mean(predicted))) }
MAE(test$quality,test.predict)
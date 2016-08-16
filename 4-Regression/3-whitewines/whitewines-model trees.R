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

# model trees
library(RWeka) ## M5-prime:模型树，叶子节点是回归方程
wine.M5P <- M5P(quality~.,data = train)
wine.M5P
summary(wine.M5P)

# predict test
test.predict <- predict(wine.M5P,test[,-12]) ## type = 'class'

# evluate model
MAE <- function(actual,predicted) { return(c(mean(abs(actual-predicted)),mean(actual),mean(predicted))) }
summary(test.predict)
summary(test$quality)
cor(test$quality,test.predict)
MAE(test$quality,test.predict)
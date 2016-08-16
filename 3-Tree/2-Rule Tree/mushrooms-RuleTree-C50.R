# load data
mushrooms <- read.csv('mushrooms.csv',header = T,stringsAsFactors = T)

# prepare data
str(mushrooms)
mushrooms$veil_type <- NULL ## factor == 1
table(mushrooms$type) ## 不平衡数据不适合规则分类

# split data
n <- length(mushrooms$type)
train.id <- sample(n,n*0.7)
train <- mushrooms[train.id,]
test <- mushrooms[-train.id,]
prop.table(table(train$type))
prop.table(table(test$type))

# rule tree model
library(C50)
C50.rule.model <- C5.0(type~.,data = mushrooms,rules = T) ## Create Rule Tree
predict(C50.rule.model,test[,-1],type = 'class')
predict(C50.rule.model,test[,-1],type = 'prob')
test.predict <- predict(C50.rule.model,test[,-1])

# evluate model
table(test$type,test.predict)
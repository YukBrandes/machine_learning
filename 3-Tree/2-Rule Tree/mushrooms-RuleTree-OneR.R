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
library(RWeka)
OneR.rule.model <- OneR(type~.,data = train) # 单一规则
summary(OneR.rule.model)
test.predict <- predict(OneR.rule.model,test)

# evluate model
table(test$type,test.predict) ## 并未将有毒的判定为无毒，规则可用

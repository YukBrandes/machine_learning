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
RIPPER.model <- JRip(type~.,data = train) ## RIPPER 规则 
RIPPER.model
summary(RIPPER.model)

# predict
test.predict <- predict(RIPPER.model,test[,-1])

# evluate model
table(test$type,test.predict)

# pmml
library("devtools")
install_github(repo = "jpmml/r2pmml")

library(pmml)



library("devtools")
library("devtools")
install_github(repo = "jpmml/r2pmml")
library(r2pmml)
r2pmml(sms_classifier,'C:/Users/Yuk/Desktop/sms_naiveBayes.pmml')

library(XML)
library(pmml)
pmml(sms_classifier,predictedField = 'type')


sms_classifier

sms_classifier_matrix <- as.data.frame(sms_classifier)
a <- as.matrix(sms_train)
a <- as.matrix(sms_tes)
c <- apply(as.matrix(sms_train), MARGIN = 2, FUN = convert_counts)


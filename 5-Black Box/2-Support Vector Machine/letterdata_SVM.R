# load data
letter <- read.csv('letterdata.csv')

# explore data
str(letter)
summary(letter)

# prepare data：skip

# split data
n <- length(letter$letter)
train.id <- sample(n,n*0.75)
train <- letter[train.id,]
table(train$letter) ## A-Z
test <- letter[-train.id,]

# SVM model：e1071,kernlab
library(kernlab)
letter.svm <- ksvm(letter~.,data = train,kernel = 'vanilladot') ## 线性核函数

# predict
test.predict <- predict(letter.svm,test)

# evaluate
table(test.predict,test$letter)
prop.table(table(test.predict == test$letter))

# improve：修改核函数kernel，增加惩罚C
letter.svm <- ksvm(letter~.,data = train,kernel = 'rbfdot') ## 高斯核函数
test.predict <- predict(letter.svm,test)
prop.table(table(test.predict == test$letter))
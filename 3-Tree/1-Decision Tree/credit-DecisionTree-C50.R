# load data
credit <- read.csv('credit.csv',header = T)
credit$default <- as.factor(credit$default)
credit$installment_rate <- as.factor(credit$installment_rate)
credit$residence_history <- as.factor(credit$residence_history)
credit$dependents <- as.factor(credit$dependents)
summary(credit)
str(credit)

# prepare data
summary(credit$months_loan_duration)
factor_Var <- function(x){
  temp <- x
  q1 <- quantile(x,0.25)
  q2 <- quantile(x,0.5)
  q3 <- quantile(x,0.75)
  x[temp <= q1] <- 'A'
  x[temp >q1 & temp <= q2] <- 'B'
  x[temp >q2 & temp <= q3] <- 'C'
  x[temp >q3] <- 'D'
  x <- as.factor(x)
}
credit$months_loan_duration_level <- factor_Var(credit$months_loan_duration)
credit$existing_credits_level <- factor_Var(credit$existing_credits)

# split data
n <- length(credit$checking_balance)
train.id <- sample(n,n*0.7)
train <- credit[train.id,]
test <- credit[-train.id,]
prop.table(table(train$default))
prop.table(table(test$default))

# decision tree model
library(C50)
C50.tree.model <- C5.0(train[,c(-21)],train$default) ## Create Decision Tree
plot(C50.tree.model) ## Plot Decision Tree -- Error in action
predict(C50.tree.model,test[,-21],type = 'class')
predict(C50.tree.model,test[,-21],type = 'prob')
test.C50.tree.model.predict <- predict(C50.tree.model,test[,-21])

# evluate model
table(test$default,test.C50.tree.model.predict)

# improve model
## adaptive boosting：自适应增强
C50.tree.model.add.trail <- C5.0(train[,c(-21)],train$default,trail = 3)
table(test$default,test.C50.tree.model.predict)

## error cost：代价矩阵
table(test$default,test.C50.tree.model.predict)
error_cost <- matrix(c(0,1,4,0),nrow =2)
C50.tree.model.add.cost <- C5.0(train[,-21],train$default,costs = error_cost)

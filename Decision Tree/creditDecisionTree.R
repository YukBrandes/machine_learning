# load data
credit <- read.csv('credit.csv',header = T)
credit$default <- as.factor(credit$default)
credit$installment_rate <- as.factor(credit$installment_rate)
credit$residence_history <- as.factor(credit$residence_history)
credit$dependents <- as.factor(credit$dependents)
summary(credit)
str(credit)


# deal data

# decision tree model

# evluate model

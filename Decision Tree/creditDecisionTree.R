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
  return(x)
}

# decision tree model


# evluate model

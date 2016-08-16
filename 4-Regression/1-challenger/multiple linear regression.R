# load data
challenger <- read.csv('challenger.csv')
summary(challenger)

# multiple linear regression model
regMultiple <- function(y,x){
  x <- as.matrix(x)
  x <- cbind(Intercept = 1,x)
  solve(t(x) %*% x) %*% t(x) %*% y
}
regMultiple(challenger$distress_ct,challenger$temperature)

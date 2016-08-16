# load data
challenger <- read.csv('challenger.csv')
summary(challenger)

# prepare data
plot(x = challenger$temperature,y = challenger$distress_ct)
plot(x = challenger$pressure,y = challenger$distress_ct)

# Corr
cov(challenger$temperature,challenger$distress_ct)/(sd(challenger$temperature)*sd(challenger$distress_ct))
cor(challenger$temperature,challenger$distress_ct)

# simple linear regression model:最小二乘法
b <- cov(challenger$temperature,challenger$distress_ct)/var(challenger$temperature)
a <- mean(challenger$distress_ct) - b*mean(challenger$temperature)
y <- function(x){return(a + b*x)}

# predict
plot(challenger$temperature,y(challenger$temperature))
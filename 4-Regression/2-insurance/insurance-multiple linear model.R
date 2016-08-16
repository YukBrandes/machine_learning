# load data
insurance <- read.csv('insurance.csv',stringsAsFactors = T)
str(insurance)
head(insurance)

# prepare data
levels(insurance$sex) <- c(0,1)
levels(insurance$smoker) <- c(0,1)
## dummy coding
insurance$northeast <- as.character(insurance$region)
insurance$northeast[!(insurance$northeast=='northeast')] <- 0
insurance$northeast[(insurance$northeast=='northeast')] <- 1

insurance$northwest <- as.character(insurance$region)
insurance$northwest[!(insurance$northwest=='northwest')] <- 0
insurance$northwest[(insurance$northwest=='northwest')] <- 1

insurance$southeast <- as.character(insurance$region)
insurance$southeast[!(insurance$southeast=='southeast')] <- 0
insurance$southeast[(insurance$southeast=='southeast')] <- 1

insurance$region <- NULL
insurance$northeast <- as.factor(insurance$northeast)
insurance$northwest <- as.factor(insurance$northwest)
insurance$southeast <- as.factor(insurance$southeast)

summary(insurance)
hist(insurance$charges)
## 相关性
cor(insurance[,c(1,3,4,7)])
## 散点图矩阵
pairs(insurance[,c(1,3,4,7)]) 
library(psych)
pairs.panels(insurance[,c(1,3,4,7)]) ## 相关椭圆越扁，相关性越强

# multiple linear model
insurance.model <- lm(charges~.,data = insurance)

# evluate model
summary(insurance.model)

# improve model
## 增加非线性关系
insurance$age2 <- insurance$age^2
insurance.model <- lm(charges~.,data = insurance)
## 数值型指标二进制
insurance$bmi30 <- ifelse(insurance$bmi >= 30,1,0)
insurance.model <- lm(charges~.,data = insurance)
## 加入相互影响
names(insurance)
insurance.model <- lm(charges ~ bmi30+smoker+bmi30:smoker,data = insurance)
insurance.model <- lm(charges ~ bmi30*smoker,data = insurance)
# load data
teens <- read.csv('snsdata.csv')

# explore data
str(teens)
summary(teens)
summary(teens$age)
table(teens$gender, useNA = 'ifany')

# clean data
teens$age <- ifelse(teens$age >= 13 & teens$age < 20,teens$age,NA)
## 插补缺失值
aggregate(data = teens,age ~ gradyear,mean,na.rm =T)
ave_age <- ave(teens$age,teens$gradyear,FUN = function(x) mean(x,na.rm =T))
teens$age <- ifelse(is.na(teens$age),ave_age,teens$age)
## 虚拟编码
teens$female <- ifelse(teens$gender == 'F',1,0)
teens$female <- ifelse(teens$gender == 'F' & !is.na(teens$gender),1,0)
teens$gender_unknow <- ifelse(is.na(teens$gender),1,0)
interests <- teens[5:40]
interests <- as.data.frame(lapply(interests,scale))

# k-means model
library(stats)
interests_kmeans <- kmeans(interests, 5)

# evaluate model
interests_kmeans$cluster
interests_kmeans$centers
interests_kmeans$size

# improve model
teens$cluster <- interests_kmeans$cluster
aggregate(data = teens,age~cluster,mean)
aggregate(data = teens,female~cluster,mean)
aggregate(data = teens,friends~cluster,mean)
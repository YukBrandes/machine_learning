# title:wdbc min-max normalize knn 
# author:YukBrandes
# load data
dir <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data'
wdbc.data <- read.csv(dir,header = F)
names(wdbc.data) <- c('ID','Diagnosis','radius_mean','texture_mean','perimeter_mean','area_mean',
                      'smoothness_mean','compactness_mean','concavity_mean','concave points_mean',
                      'symmetry_mean','fractal dimension_mean','radius_sd','texture_sd','perimeter_sd',
                      'area_sd','smoothness_sd','compactness_sd','concavity_sd','concave points_sd',
                      'symmetry_sd','fractal dimension_sd','radius_max_mean','texture_max_mean',
                      'perimeter_max_mean','area_max_mean','smoothness_max_mean',
                      'compactness_max_mean','concavity_max_mean','concave points_max_mean',
                      'symmetry_max_mean','fractal dimension_max_mean')
str(wdbc)
wdbc.data$Diagnosis <- factor(wdbc.data$Diagnosis,
                              levels =c('B','M'),
                              labels = c(B = 'benign',M = 'malignant')) ## Diagnosis must be Factor
table(wdbc.data$Diagnosis) ## M = malignant, B = benign
round(prop.table(table(wdbc$Diagnosis))*100,digits = 2)
summary(wdbc)
write.csv(wdbc,'wdbc.data.csv',row.names = F)

# numeric min-max normalize
normalize <- function(x){return((x-min(x))/(max(x)-min(x)))}
normalize(wdbc$radius_mean)
wdbc_normalize <- as.data.frame(apply(wdbc[-c(1,2)],2,normalize))
wdbc_normalize$Diagnosis <-wdbc$Diagnosis
head(wdbc_normalize)
summary(wdbc_normalize)

# split data
n <- length(wdbc_normalize$texture_mean)
set.seed(3)
trainID <- sample(n,n*0.7)
train <- wdbc_normalize[trainID,]
test <- wdbc_normalize[-trainID,]

# knn model
library(class)
test.knn.predict <- knn(train[-31],test[-31],train$Diagnosis,k=3) ## K个近邻投票,默认欧氏距离

# model evaluate
table(test.knn.predict,test$Diagnosis)
install.packages('gmodels')
library(gmodels)
CrossTable(x = test$Diagnosis,y =test.knn.predict,prop.chisq = F)
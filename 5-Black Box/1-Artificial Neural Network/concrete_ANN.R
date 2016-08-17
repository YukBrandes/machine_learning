# load data
concrete <- read.csv('concrete.csv',header = T)

# explore data
View(concrete)
str(concrete)
summary(concrete)

# prepare data
normalize <- function(x){ return((x-min(x))/(max(x)-min(x))) }
summary(normalize(concrete$slag))
concrete.normalize <- as.data.frame(apply(concrete, 2, normalize)) ## 神经网络最好将数据压缩在0的狭窄范围

# split data
n <- length(concrete.normalize$cement)
train.id <- sample(n,n*0.75) ## 不是整数
train <- concrete.normalize[train.id,]
test <- concrete.normalize[-train.id,]

# ANN model：多层前馈
library(neuralnet) ## nnet，RSNNS
concrete.FFR <- neuralnet(strength~cement+slag+ash+water+superplastic+coarseagg+fineagg+age,data = concrete.normalize,hidden = 1) ## 数值型神经网络

plot(concrete.FFR)

# predict
test.predict <- compute(concrete.FFR,test[1:8])
test.predict$neurons ## 存储每层的神经元
test.predict$net.result ## 存储预测值

# evaluate
cor(test.predict$net.result,test$strength)

# improve：increase hidden
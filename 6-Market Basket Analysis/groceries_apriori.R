# load data
library(Matrix)
library(arules)
groceries <- read.transactions('groceries.csv',sep = ',')

# explore data
summary(groceries)
inspect(groceries[1:5]) ## 前5条交易
inspect(groceries[,1:2]) ## 前2中商品
## 支持度
itemFrequency(groceries[,1]) 
itemFrequencyPlot(groceries[,1:10])
itemFrequencyPlot(groceries,support = 0.1)
itemFrequencyPlot(groceries,topN = 20)
## 绘制稀疏矩阵:对大数据无效,太密
image(groceries[1:100])

# apriori model
groceries.apriori<- apriori(groceries)
groceries.apriori<- apriori(data = groceries,parameter = list(support = 0.006,confidence = 0.25,minlen = 2))

# evaluate model
summary(groceries.apriori)
inspect(groceries.apriori[1:3])

# improve model
## 对关联规则排序
inspect(sort(groceries.apriori, by = 'lift',decresing = T)[1:5])
## 提取关联规则子集
bakeryrules <- subset(groceries.apriori, items %in% "bakery")
bakeryrules <- subset(groceries.apriori, subset = rhs %in% "bakery" & lift > 2)
inspect(bakeryrules)
## 保存规则
write.csv(groceries.apriori, file = 'groceries.apriori.df', quote = T, row.names = F) ## 失败
groceries.apriori.df <- as(groceries.apriori[1:5], 'dataframe') ## 失败
groceries.apriori.df <- as.data.frame(groceries.apriori[1:5]) ## 失败
# Action for Machine Learning with R

## Machine Learning

机器学习 (Machine Learning) 是近 20 多年兴起的一门多领域交叉学科，涉及概率论、统计学、逼近论、凸分析、算法复杂度理论等多门学科。
机器学习理论主要是设计和分析一些让计算机可以自动学习的算法。机器学习算法是一类从数据中自动分析获得规律，并利用规律对未知数据进行预测的算法。因为学习算法中涉及了大量的统计学理论，机器学习与统计推断学联系尤为密切，也被称为统计学习理论。在算法设计方面，机器学习理论关注可以实现的、行之有效的学习算法。很多相关问题的算法复杂度较高，而且很难找到固有的规律，所以部分的机器学习研究是开发容易处理的近似算法。
机器学习在数据挖掘、计算机视觉、自然语言处理、生物特征识别、搜索引擎、医学诊断、检测信用卡欺诈、证券市场分析、DNA 序列测序、语言与手写识别、战略游戏与机器人运用等领域有着十分广泛的应用。它无疑是当前数据分析领域的一个热点内容。
---

## [Machine Learning with R](https://www.packtpub.com/big-data-and-business-intelligence/machine-learning-r) 
The book was writen by Brett Lantz,it provides an introduction to machine learning using R. 
---

## Data Sets
These [data](https://github.com/stedy/Machine-Learning-with-R-datasets) was collected by stedy, here is a bref introduction for the purpose of his work.

"As far as I can tell, Packt Publishing does not make its datasets available online unless you buy the book and create a [user account](https://www.packtpub.com/books/content/support) which can be a problem if you are checking the book out from the library or borrowing the book from a friend. All of these datasets
are in the public domain but simply needed some cleaning up and recoding to match the format in the book."

## 算法分类
机器学习的算法繁多，其中很多算法是一类算法，而有些算法又是从其他算法中衍生出来的，因此我们可以按照不同的角度将其分类。本文主要通过学习方式和算法类似性这两个角度将机器学习算法进行分类。

## 学习方式
> 监督式学习：从给定的训练数据集中学习出一个函数，当新的数据到来时，可以根据这个函数预测结果。监督学习的训练集需要包括输入和输出，也可以说是特征和目标。训练集中的目标是由人标注的。常见的监督式学习算法包括回归分析和统计分类。
> 非监督式学习：与监督学习相比，训练集没有人为标注的结果。常见的非监督式学习算法有聚类。
> 半监督式学习：输入数据部分被标识，部分没有被标识，介于监督式学习与非监督式学习之间。常见的半监督式学习算法有支持向量机。
> 强化学习：在这种学习模式下，输入数据作为对模型的反馈，不像监督模型那样，输入数据仅仅是作为一个检查模型对错的方式，在强化学习下，输入数据直接反馈到模型，模型必须对此立刻作出调整。常见的强化学习算法有时间差学习。

##算法类似性
> 决策树学习：根据数据的属性采用树状结构建立决策模型。决策树模型常常用来解决分类和回归问题。常见的算法包括 CART (Classification And Regression Tree)、ID3、C4.5、随机森林 (Random Forest) 等。
> 回归算法：试图采用对误差的衡量来探索变量之间的关系的一类算法。常见的回归算法包括最小二乘法 (Least Square)、逻辑回归 (Logistic Regression)、逐步式回归 (Stepwise Regression) 等。
> 聚类算法：通常按照中心点或者分层的方式对输入数据进行归并。所有的聚类算法都试图找到数据的内在结构，以便按照最大的共同点将数据进行归类。常见的聚类算法包括 K-Means 算法以及期望最大化算法 (Expectation Maximization) 等。
> 人工神经网络：模拟生物神经网络，是一类模式匹配算法。通常用于解决分类和回归问题。人工神经网络算法包括感知器神经网络 (Perceptron Neural Network) 、反向传递 (Back Propagation) 和深度学习等。
> 集成算法：用一些相对较弱的学习模型独立地就同样的样本进行训练，然后把结果整合起来进行整体预测。集成算法的主要难点在于究竟集成哪些独立的较弱的学习模型以及如何把学习结果整合起来。这是一类非常强大的算法，同时也非常流行。常见的算法包括 Boosting、Bagging、AdaBoost、随机森林 (Random Forest) 等。

## Action

Chapter 1 k Nearest Neighbors

Chapter 2 Naive Bayes

Chapter 3 [Decision Tree](http://www.ibm.com/developerworks/cn/analytics/library/ba-1507-decisiontree-algorithm/index.html#ibm-pcon)
决策树是附加概率结果的一个树状的决策图，是直观的运用统计概率分析的图法。机器学习中决策树是一个预测模型，它表示对象属性和对象值之间的一种映射，树中的每一个节点表示对象属性的判断条件，其分支表示符合节点条件的对象。树的叶子节点表示对象所属的预测结果。

Chapter 4 
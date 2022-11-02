# Course organization
* [Tuturials](https://www.ida.liu.se/~732A99/info/tutorials/)
  * basic exercises with answers
  * Go through **before** the respective lab!
* Lecture 1b is 'Basic Statistics'
* Lecture 1c is 'Introduction to R'

## What is Machine Learning
* Machine learning explores the study and construction of **algorithms** that can **learn** from and make **predictions** on **data**
* ML has a heavier focus on **prediction**(预测), and lesser on interpretation(解释)
* A principled way to think about any problem in machine learning
  * Probabilistic model $\rightarrow$ Estimation $\rightarrow$ Prediction

## Types of learning
* Supervised learning(classification, regression)
* Unsupervised learning($\rightarrow$Data Mining)
  * Aim is to extract interesting information about
    * Relations of parameters to each other
    * Grouping of objects
* Semi-supervised: targets are known only for some observations
* Active learning: Strategies for deciding which observations to label
* Reinforcement learning
* Transfer learning: use knowledge from some domain to train better models in a similar domain
  
$y=w_0+w_1\cdot x+\varepsilon, \varepsilon N\sim(0,\sigma^2)$

## K-nearest neighbor model
* Can be classification or regression
* Basic idea
  * For given $x_*$, find K nearest observations
  * Classification: majority voting
  * Regression: compute mean
* K is called **hyperparameter**

```R
    n=dim(data)[1]
    set.seed(12345)
    id=sample(1:n,floor(n*0.7))
    train=data[id,]
    test=data[-id,]
```
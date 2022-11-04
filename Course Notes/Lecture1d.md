# Regression，classification and regularization

- [Regression，classification and regularization](#regressionclassification-and-regularization)
  - [Regression](#regression)
    - [Simple linear regression](#simple-linear-regression)
    - [Linear regression](#linear-regression)
    - [Linear model: learning](#linear-model-learning)
    - [Linear regression in R](#linear-regression-in-r)
    - [Data scaling](#data-scaling)
    - [Degrees of freedom](#degrees-of-freedom)
    - [Basis function expansion](#basis-function-expansion)
  - [Regularization](#regularization)
  - [Classification](#classification)
    - [Classifiers(分类器)](#classifiers分类器)
      - [Disanvantages of deterministic classifiers:](#disanvantages-of-deterministic-classifiers)
  - [Logistic regression](#logistic-regression)
    - [Logistic regression: learning](#logistic-regression-learning)
    - [Optimization](#optimization)

##  Regression
### Simple linear regression
* **Given**:  
Data  $\ T={(x_i,y_i),i=1,...n}$
* **Model**:  
    $y=\theta_0+\theta_1x+\epsilon$,  
    $\epsilon\sim N(0,\sigma^2)$.  
or  
    $y|x\sim N(\theta_0+\theta_1x,\sigma^2)$.  
or  
    $p(y|x,w)=N(\theta_0+\theta_1x,\sigma^2)$.  
* **Terminology**:  
$\theta_0$: **intercept(or bias)**(截距或偏差)  
$\theta_1$:  **regression coefficient**(回归系数)
### Linear regression
* **Model**:  
  $y=\theta_0+\theta_1x_1+...+\theta_px_p+\epsilon$<br>
  $y\sim N(\Theta^Tx,\sigma^2)$<br>
  where<br>
  $\theta={\theta_0,...\theta_p}$<br>
  $x={1,x_1,...x_p}$(why is "1" here?)$\rightarrow\theta_0$

Aim: learn optimal parameters<br>
$\hat{\theta}_0,...,\hat{\theta}_p$
* Prediction with linear regression for $x_*$<br>
    $\hat{y}(x_*,\hat{\Theta})=\hat{\theta}_0+\hat{\theta}_1x_{*1}+...\hat{\theta}_px_{*p}$
* Irreducible error 𝜖

### Linear model: learning
* How to learn parameters?
  * **Approach A**: Minimize the cost
    * $\hat{\theta}=\arg\min{1\over n}\sum L(\hat{y}(x_i,\theta),y_i)$
    * Usual choice: squard loss
  * Ordinary least squares
    * OPbjective: $\min {1\over n}\sum_{i=1}^n(y_i-x_i\theta)^2=min(y-X\theta)^T(y-X\theta)$
    * Optimality condition: $X^T(y-X\theta)=0$
    * Least squares estimates of the parameters
    * Predicted values
    * Linear regression belongs to the class of **linear smoothers**
    * Note: if $𝑝>𝑛$ then $𝑿^𝑻 𝑿$ is not invertible
    * Training
      1. Construct $X$ and $y$
      2. Compute $\hat{\theta}=(X^TX)^{-1}X^Ty$
    * Prediction
      * $\hat{y}(x_*)=\hat{\theta}^Tx$



  * **Approach B**: Maximize the likelihood
    * $\hat{\theta}=\arg\max p(T|\theta)=\argmax p(y|X,\theta)$
    * Exercise: Approacjh A and B are equivalent
    * $\max f(\theta)=\min -f(\theta)$
### Linear regression in R
* fit=lm(formula, data, subset, weights,…)
  * **data** is the data frame containing the predictors and response values
  * **formula** is expression for the model
  * **subset** which observations to use (training data)?
  * **weights** should weights be used?

**fit** is object of class **lm** containing various regression results
* Useful functions (many are generic, used in many other models)
  * Get details about the particular function by ”.”,  for ex. predict.lm
```R
summary(fit)
predict(fit, newdata, se.fit, interval)
coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals

mydata=read.csv2("Bilexempel.csv")
fit1=lm(Price~Year, data=mydata)
summary(fit1)
fit2=lm(Price~Year+Mileage+Equipment, data=mydata)
summary(fit2)
```
### Data scaling
* In linear regression not necessary but can improve interpretation when comparing coefficient values
* **Same transformation** on train, valid and test data
  * Never scale these separately
  * Normally done on training data as required by many ML methods
* In R: library **caret**
  * `preProcess()` to learn transformation
  * `predict()` to apply transformation
```R
set.seed(12345)
n=nrow(data)
id=sample(1:n, floor(n*0.5))
train=data[id,]
test=data[-id,]

library(caret)
scaler=preProcess(train)
trainS=predict(scaler,train)//Same transformation>>scaler
testS=predict(scaler,test)//Same transformation>>scaler

fit3=lm(Price~Year+Mileage+Equipment, data=trainS)
summary(fit3)
```
### Degrees of freedom
Definition:
$df(\hat{y}={1\over{\sigma^2}}\sum Cov(\hat{y}_i,y_i)$($\hat{y}$ predicted value of $y$)
* Larger covariance$\rightarrow$ stronger connection$\rightarrow$ model can approximate data better$\rightarrow$ model more flexible (complex)
* For linear smoothers $\hat{Y}=𝑆(𝑋)𝑌$
  * $df=trace(S)$
* For linear regression, degrees of freedom is
  * $df=trace(P)=p$(number of features)
### Basis function expansion

> High degree of polynomial leads to overfitting
## Regularization
* Used in a huge variety of models, for ex deep learning
* **Problem of overfitting**: models fit training data perfectly but are too complex$\rightarrow$ penalize complexity!
  * The more coefficients(系数) close to zero, the less complex the model is
* **L2 regularization** in linear (polynomial) regression = **Ridge regression**
  * Training data **are normally** scaled (one 𝜆 for all features!)
  
$\min{1\over n}\sum (y_i-\theta^Tx_i)^2+\lambda\sum_{j=1}^p\theta_j^2,\ \lambda>0$
## Classification
* Given data  $D=((x_i,y_i),i=1,...n)$
  * $y_i=y(X_i)=C_j\in C$
  * Class set $C={C_1,...,C_M}$

**Classification problem:**
* Decide $\hat{y}(x)$ that map **any** $x$ into some class $C_j \in C$
  * Decision boundary

### Classifiers(分类器)
* **Deterministic**(确定性): decide a rule that directly maps 𝒙 into $\hat{y}$
* **Probabilistic**(概率性): define a model for $𝑃(𝑦=𝐶_𝑗│𝒙), 𝑗=1…𝑀$

#### Disanvantages of deterministic classifiers:
* Sometimes simple mapping is not enough (risk of cancer)
* Difficult to embed loss$\rightarrow$ rerun of optimizer is often needed
* Combining several classifiers into one is more problematic
  * Algorithm A classifies as spam, Algorithm B classifies as not spam$\rightarrow$ ???
  * P(Spam|A)=0.99, P(Spam|B)=0.45$\rightarrow$ better decision can be made
## Logistic regression
* Discriminative model
* Model for binary output
  * $C={C_1=-1,C_2=1}$
  * $p(y=C_1|x)=g(x)=sigm(\theta^Tx)$
    * $sigm(a)={1\over {1+e^{-a}}}$
* Alternatively
  * $y\sim Bernoulli(sigm(a)),a=\theta^Tx$
    * $sigm(a)={1\over {1+e^{-a}}}$

What is $p(𝑦=𝐶_2|𝑥)$?

### Logistic regression: learning
* Likelihood maximization
  * $\hat{\theta}=\argmax p(y|x;\theta)$
* Equivalent to
  * $\min{1\over n}\sum ln(1+e^{-y_i\theta^Tx_i})$
* To maximize log-likelihood, optimization used
  * Newton’s method traditionally used (Iterative Reweighted Least Squares)
  * Steepest descent, Quasi-newton methods…
* Training
    1.  Construct(NF)
    2.  Compute(NF)
* Prediction(NF)

* When 𝑦 is categorical, set **`one`** parameter vector  $\theta_𝑖$ per class $𝐶_𝑖$
  * (NF)
* Alternatively
> Decision boundaries in logistic regression are linear!
* Maximum likelihood


* Similar model to Logistic :**Linear Discriminant Analysis (LDA)**:
  * Same expression for $𝑝(𝑦│𝒙,𝜽)$
  * Parameters optimized differently
  * Advantage: faster to compute
  * Disadvantage: stronger assumptions on data.
* In R, use glm() with family=”binomial” for two classes
  * Predict(glmobj, type). Choose type ”response” for probabilities
* In R, use multinom () from nnet package for more than two classes
### Optimization
* How to optimize a given log-likelihood?
  * In R, use optim(start_point, function, method)
* Example: minimizing $(𝑥_1−1)^2+(𝑥_2−2)^2\rightarrow$  ($x_1=1,x_2=2$)
```R
df=data.frame(x1=1,x2=2)
mylikelihood<-function(x){
  x1=x[1]
  x2=x[2]
  return((x1-df$x1)^2+(x2-df$x2)^2)
}

optim(c(0,0), fn=mylikelihood, method="BFGS")
```

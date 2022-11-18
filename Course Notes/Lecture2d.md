- [Parameter estimation & Optimization](#parameter-estimation--optimization)
  - [Parametric functions](#parametric-functions)
  - [Loss minimization](#loss-minimization)
    - [Loss minimization: comments](#loss-minimization-comments)
  - [Loss functions](#loss-functions)
    - [Loss functions: classification](#loss-functions-classification)
      - [Ad-hoc loss functions binary classification](#ad-hoc-loss-functions-binary-classification)
      - [Binary to multiclass](#binary-to-multiclass)
  - [Regularization](#regularization)
    - [Explicit regularization](#explicit-regularization)
      - [Explicit regularization: ridge regression](#explicit-regularization-ridge-regression)
    - [Ridge regression](#ridge-regression)
    - [LASSO](#lasso)
    - [LASSO vs Ridge](#lasso-vs-ridge)
    - [LASSO properies](#lasso-properies)
      - [Optimization methods](#optimization-methods)
      - [Gradient descent](#gradient-descent)
      - [Newton’s method](#newtons-method)
    - [Optimization methods in R](#optimization-methods-in-r)
    - [Implicit regularization](#implicit-regularization)
    - [Optimization for large data](#optimization-for-large-data)
    - [Hyperparameter optimization](#hyperparameter-optimization)
# Parameter estimation & Optimization
## Parametric functions
* General ML model 𝑌~𝐷𝑖𝑠𝑡𝑟𝑖𝑏𝑢𝑡𝑖𝑜𝑛($f_\theta (𝒙),…$)
  * Some of them: 𝑌~$𝑓_\theta$ (𝒙)+𝜖, 𝜖~𝐷𝑖𝑠𝑡𝑟𝑖𝑏𝑢𝑡𝑖𝑜𝑛(…)
  * Generalization of simple models can be done
* `Example`: logistic 𝑌~𝐵𝑒𝑟𝑛𝑜𝑖𝑙𝑙𝑖$({1\over1+e^{-\theta^Tx}})$
  * Generalization 1: (basis function expansion): 
  $$
  Y\sim Bernoilli({1\over 1+e^{-\theta^T \phi (x)}})
  $$
  * Generalization 2:
  $$
  Y\sim Bernoilli({1\over 1+e^{-f_\theta(x)}})\\
  f_\theta(x)=||x-\theta||^2
  $$
## Loss minimization
* Given training set 𝑇, we want to minimize  
$E_{new}=\int_{(x_*,y_*)E(y_*,\hat{y}(x_*,T,\theta))p(x_*,y_*)dx_*dy_*}$
* We can minimize cost function  
$$
J(\theta)={1\over n}\sum^n_{i=1}L(y_i,\hat{y}(x_i,\theta))
$$
> $E_{new}\approx J(\theta)?$ X
* Optimizing 𝐽(𝜽) does not lead to optimizing $𝐸_{𝑛𝑒𝑤}$
  * Overfitting 
### Loss minimization: comments
* Training a model with perfect accuracy unreasonable
  * Statistical noise for finite 𝑛
* Loss function can be different from error function
* Some loss functions are not good for training, for ex. misclassification rate
## Loss functions
* Assuming a distribution, `derive as minus log-likelihood:`
* $y\sim Normal(f_\theta(x),\sigma^2)\rightarrow L(y,f_\theta(x))=(y-f_\theta(x))^2$
* Heavy outliers : $y\sim Laplace(f_\theta(x),r)\rightarrow L(y,f_\theta(x))=|y-f_\theta(x)|$
* Count data $y\sim 𝑃𝑜𝑖𝑠𝑠𝑜𝑛(f_\theta (𝑥))$  
`Example: `Daily Stock prices NASDAQ
* Open
* High (within day)

1. Try to fit usual linear regression, study histogram of residuals
* If the distribution is difficult to assume / only some properties known$\rightarrow$ ad-hoc loss functions
* **Huber loss**: similar to quadratic but robust to outliers
$$
L(y,\hat{y})\begin{cases}
    {1\over2}(y,\hat{y})^2\quad if\ |y,\hat{y}|<1\\
    |y,\hat{y}|-{1\over2}\quad otherwise
\end{cases}
$$
* **E-intensive loss**
$$
L(y,\hat{y})\begin{cases}
    0\quad if\ |y,\hat{y}|<\epsilon\\
    |y,\hat{y}|-\epsilon\quad otherwise
\end{cases}
$$
### Loss functions: classification
* **Cross-entropy** corresponds to minus log-likelihood:
$$
J(y,\hat{p}(y))=-\sum^n_{i=1}\sum^M_{m=1}I(y_i=C_m)log\hat{p}(y_i=C_m)
$$
* Ad-hoc loss functions binary classification 𝐶={−1,1}
  * Assume model returns $𝑓(𝒙): \hat{y}=𝑠𝑖𝑔𝑛(𝑓(𝒙))$
  * `Example`: $logistic\quad f(x)={1\over{1+e^{-\theta^Tx}}}-0.5$
    * Probability of Classify to '1'
* **`Note`**: mistake when $yf(x)=-1$
#### Ad-hoc loss functions binary classification
* **Exponential loss**
$$
L(y\cdot f(x))=exp(-y\cdot f(x))
$$
* **Hinge loss**
$$
L(y\cdot f(x))=\begin{cases}
    1-y\cdot f(x)\quad for\ y\cdot f(x)≤1\\
    0\qquad \qquad  otherwise
\end{cases}
$$
#### Binary to multiclass
* One versus one: class $𝐶_𝑖$ vs class $𝐶_𝑗+$ majority voting from all classifiers
* One versus rest: class $𝐶_𝑖$ vs not $𝐶_𝑖+$ highest probability class
* Comparison: OVO needs less data to train one model but more models.


## Regularization
* $E_{new}\approx J(\theta)?$ – no
* Similar for (moderately) simple models, not similar for too complex model (overfitting).
* [**Explicit regularization**](#explicit-regularization): penalize complexity by changing cost function
* [**Implicit regularization**](#implicit-regularization): **early stopping**
  * If cost function optimized iteratively, don’t let it decrease too much
### Explicit regularization
* Penalize cost function
$$
\min_\theta J(\theta)+\lambda R(\theta)\\
\lambda > 0
$$
* **L1 regularization**:$R(\theta)=\lambda ||\theta||_1$
* **L2 regularization**:$R(\theta)=\lambda ||\theta||_2$
* **`Example`: Ridge regression**
$$
\min_\theta {1\over n}\sum^n_{i=1}(y_i-\theta^Tx_i)^2+\lambda \sum^p_{j=1}\theta_j^2,\quad \lambda>0
$$
#### Explicit regularization: ridge regression
* Equivalent form
$$
\hat{\theta}^{ridge}=\argmin \sum_{i=1}^N(y_i-\theta_0-\theta_1x_{1j}-\dots-\theta_px_{pj})^2\\
subject\quad to \quad\sum_{j=1}^p\theta^2_j≤s
$$
* Solution
$$
\theta^{ridge}=(X^TX+\lambda I)^{-1}X^Ty
$$
### Ridge regression
Properties
* Extreme cases: 
  * 𝜆=0 usual linear regression (no shrinkage(缩水))
  * 𝜆=+∞ fitting a constant (𝜽=0 except of $\theta_0$)
* Degrees of freedom decrease when 𝜆  increases
  * $\lambda=0\rightarrow d.f.=p$
* $p>n$ is doable
  * Compare with linear regression
* How to estimate 𝜆?
  * cross-validation 
* R code: use package glmnet with alpha=0 (Ridge regression)
* Seeing how Ridge converges
```R
data=read.csv("machine.csv", header=F)

library(caret)
library(glmnet)
scaler=preProcess(data)
data1=predict(scaler, data)
covariates=data1[,3:8]
response=data1[, 9]

model0=glmnet(as.matrix(covariates), response, alpha=0,family="gaussian")
plot(model0, xvar="lambda", label=TRUE)
```
* Choosing the best model by cross-validation:
```R
model=cv.glmnet(as.matrix(covariates), response, alpha=0,family="gaussian")
model$lambda.min
plot(model)
coef(model, s="lambda.min")
```
* How good is this model in prediction?
```R
covariates=train[,1:6]
response=train[, 7]
model=cv.glmnet(as.matrix(covariates), response, alpha=1,family="gaussian", lambda=seq(0,1,0.001))
y=test[,7]
ynew=predict(model, newx=as.matrix(test[, 1:6]), type="response")

#Coefficient of determination
sum((ynew-mean(y))^2)/sum((y-mean(y))^2)

sum((ynew-y)^2)
```
> Note that data are so small so numbers change much for other train/test
### LASSO
* Add $l_1$ regularization term
$$
\hat{\theta}^{lassp}=\argmin {{1\over n}\sum_{i=1}^N(y_i-\theta_0-\theta_1x_{1j}-\dots-\theta_px_{pj})^2+\lambda\sum_{j=1}^p|\theta_j|}\\

$$
* $\lambda>0$ is **penalty(惩罚) factor**
* Equivalent formulation
$$
\hat{\theta}^{lassp}=\argmin \sum_{i=1}^N(y_i-\theta_0-\theta_1x_{1j}-\dots-\theta_px_{pj})^2\\
subject\quad to \quad\sum_{j=1}^p|\theta_j|≤s
$$
### LASSO vs Ridge
* LASSO yields sparse solutions!
* In R, use glmnet with **alpha=1**
* Only 5 variables selected by LASSO
* Why Lasso leads to sparse solutions?
  * Feasible area for Ridge is a circle (2D)
  * Feasible area for LASSO is a polygon (2D)
### LASSO properies
* Lasso is widely used when 𝒑≫𝒏 
  * Linear regression breaks down when 𝑝>𝑛
  * Application: DNA sequence analysis, Text Prediction
* No explicit formula for $\hat{\theta}^{𝒍𝒂𝒔𝒔𝒐}$
  * Optimization algorithms used
#### Optimization methods
* Numerical optimization often needed
$$
\min_\theta J(\theta)\\
\min_\lambda E_{hold-out}(\lambda)
$$
* If not convex objective, more than one local optimum
* **Gradient descent method**
$$\hat{\theta}=\argmin_\theta J(\theta)$$
* Basic idea:
  * Start from some point $\theta_0$
  * Move to the next point along descent direction -$\nabla_\theta J(\theta)$
#### Gradient descent
* Example: logistic regression
#### Newton’s method
* Assume 𝐽(𝜽) is ”locally” quadratic
* Newton’s method: move along the best direction
$$
\theta^{t+1}=\theta^{(t)}-\eta[\nabla^2_\theta J(\theta^{(t)})]^{-1}[\nabla_\theta J(\theta^{(t)})]
$$
* Properties
  * No convergence guarantees
  * Advantage: if 𝐽(𝜽) is quadratic and 𝜂=1 $\rightarrow$ convergence in one iteration
  * `Disadvantage 1`: Hessian must be invertable
  * `Disadvantage 2`: Hessian is computationally heavy
* Solution: quasi-Newton methods (ex. BFGS)
  * Choose some $𝐻^{(0)}$
  * Approximate the inverse Hessian

### Optimization methods in R
* In R, use optim(par, fn, gr, method,…)
  * par: initial parameter vector
  * fn: function to optimize
  * gr: gradient function
method 
> `Example`: trace plot for $𝑦=(𝑥_1−2)^4+(𝑥_2−4)^4$
```R
#Workaround: optim does not return iterations

Fs=list()
Params=list()
k=0

myf<- function(x){ 
  f=(x[1]-2)^4+(x[2]-4)^4
  .GlobalEnv$k= .GlobalEnv$k+1
  .GlobalEnv$Fs[[k]]=f
  .GlobalEnv$Params[[k]]=x
  return(f)
}
myGrad <-function(x) c(4*(x[1]-2)^3, 4*(x[2]-4)^3)

res<-optim(c(0,0), fn=myf, gr=myGrad, method="BFGS")

plot(log(as.numeric(Fs)), type="l", main="Function iterations")
```
### Implicit regularization
* Early stopping
  * For complex models, accurate model optimization may lead to overfitting

  * Start from some parameter set (probably not optimal, large $𝐸_{𝑡𝑟𝑎𝑖𝑛}$ and $𝐸_{𝑛𝑒𝑤}$)
  * Trace the validation error (and training error? ) for each 𝑡
  * Choose model with the smallest validation error
### Optimization for large data
* Stochastic gradient descent

* Idea: use gradient descent + approximation to expected value
  * For random sample of size 𝑛_𝑏 from sample of size 𝑛
$$
\bar{x}={1\over 𝑛} \sum_{𝑖=1}^𝑛{𝑥_𝑖≈{1\over 𝑛_b}\sum_{𝑖=1}^{𝑛_𝑏}𝑥_𝑖}\\
\nabla_\theta 𝐽(\theta)≈{1\over 𝑛_b}\sum_{(𝒙_𝑖,𝑦_𝑖)\in 𝑠𝑎𝑚𝑝𝑙𝑒}{\nabla_\theta 𝐿(𝒙_𝑖, 𝑦_𝑖, \theta)}
$$
1. One epoch:
   1. Permute data and divide into batches of size $𝑛_𝑏$
   2. In each optimization iteration, use one batch
2. Repeat step 1
### Hyperparameter optimization
* $E_{hold-out}$costly to compute$\rightarrow$usual optimization very hard
  * Note: for each 𝜆 first we need to optimize 𝜃…+ gradients of $E_{hold-out}$
* Grid search (can also be costly)
  * Alternative: Bayesian optimization

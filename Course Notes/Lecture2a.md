- [Model selection](#model-selection)
  - [Model selection](#model-selection-1)
    - [An estimator](#an-estimator)
    - [Error functions](#error-functions)
    - [Error vs loss function](#error-vs-loss-function)
    - [Hold-out method](#hold-out-method)
    - [Hold-out method: remarks](#hold-out-method-remarks)
  - [Model evaluation](#model-evaluation)
# Model selection
## Model selection
### An estimator
* $\hat{\theta} =\delta(𝑇)$ (some function of your training data) – an estimator
* Optimal parameter values?$\rightarrow$there can be many ways to compute them (MLE, shrinkage…)
  * There is no easy way to compare estimators in frequentist tradition
> Example: Linear regression
> * Estimator 1: $\theta=(𝑋^𝑇 𝑋)^{-1} X^T 𝑌$ (maximum likelihood)
> * Estimator 2: 𝜽=(0,…,0,1)
> * Which one is better?
>   * A comparison strategy is needed!

* ML can lead to overfitting
* How can we find appropriate parameter values?
* How can we compare between different models? 
### Error functions
* Loss functions 𝐿(𝑦,𝑦 ̂) used to evaluate the quality of training
* Error functions $𝐸(𝑦, \hat{𝑦})$ used to measure the quality of prediction
  * Misclassification error
  $$𝐸(y,\hat{𝑦} )=
  \begin{cases}
    0, \quad y=\hat{y}\\
    1, \quad y\neq \hat{y}
  \end{cases}
  $$
  * Squared error $𝐸(𝑦, \hat{𝑦} )=(𝑦−\hat{𝑦} )^2$
  * Formulas can be same, different purpose
### Error vs loss function
* Should error function be same as loss function?
* Normal practice: Choose the loss related to minus loglikelihood
> * Example: Predicting the risk of cancer:  
>  $$E(y=H,\hat{y}=C)=1\\
>  E(y=C,\hat{y}=H)=1000\\
>  loss matrix = (0 1000 1 0)
>  $$
* One can show: ${{𝑝(𝑦=𝐻│𝑥)}\over{𝑝(𝑦=𝐶|𝑥)}}>1000→𝑐𝑙𝑎𝑠𝑠𝑖𝑓𝑦 𝑎𝑠 𝐻$

* Given a model, choose the optimal parameter values
  * Decision theory
* If we know the true distribution $𝑝(𝑦,𝒙)$ then we choose the optimal model by minimizing the expected risk:
$$
\min_{\hat{y}}\bar{E}_{new}=\min_\theta \int_{(x_*,y_*)}E(y_*,\hat{y}(x_*,T,\theta))p(x_*,y_*)dx_*dy_*dT
$$
* Problem: data generating process is unknown$\rightarrow$can not compute expected risk!
* Approximation 1: Instead of considering all possible 𝑇, take only one 𝑇$\rightarrow$expected new data error
$$
E_{new}=\int_{(x_*,y_*)}E(y_*,\hat{y}(x_*,T,\theta))p(x_*,y_*)dx_*dy_*
$$
* Fix 𝑇 as a particular training set
* Approximation 2:  
  $$
  \int_{(x_*,y_*)}E(y_*,\hat{y}(x_*,T,\theta))p(x_*,y_*)dx_*dy_*
  \approx {1\over{|V|}}\sum_{(x_*,y_*)\in V}E(y_*,\hat{y}(x_*,T,\theta))
  $$



### Hold-out method
* Divide into training, validation and test sets
* Choose proportions in some way
* Given: training, validation, test sets  and models to select between
* Training set is to used for fitting models to the dataset by using given loss function
* Validation set is used to choose the best model (lowest risk)
* Test set is used to test a performance on a new data
### Hold-out method: remarks
* Data needs to be shuffled before split
* Method is suitable for large data otherwise training affected
* Proportions: increasing % of training data generally leads to better performance but the quality of ”Approximation 2” decreases



## Model evaluation

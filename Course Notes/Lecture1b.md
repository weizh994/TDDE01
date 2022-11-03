# Basics of Statistics
## Probability
* One can think of events as sets
  * Set operations are defined: $A \cup B,A \cap B,\bar{A}$ \ $B$
* $P(A \cup B)=P(A)+P(B) if {A\cap B} =\emptyset$
* `Independence` $P(A,B)\equiv P(A\cap B)= P(A)P(B)$
* Conditional probability $P(A|B)={{P(A,B)} \over {P(B)}}$
## Bayes theorem
* We have some knowledge about event B
  * Prior probability $P(B)$ fo $B$
* We get new information $A$
  * $P(A)$
  * $P(A|B)$ probability of A can occur given B has occured
* New(update) knowledge about B
  * Posterior probability $P(B|A)$
## $P(B|A)={{P(A|B)P(B)}\over{P(A)}}$

## Random variables
* ℝ $\rightarrow$ Continuous random variables
* ℕ $\rightarrow$ Discrete random variables
### Examples:
* X={amount of times the word "crisis" can be found in financial documents}
  * $P(X=3)$
* X={Time to download a specific file to a specific computer}
  * $P(X=0.36 min)$
## Distributions(分布)
* Discrete
  * Probability mass functuion $P(x)$ for all feasible $x$
* Coninuous
  * Probability densityh function $p(x)$
    * $p(x\in[a,b])={\int_a^b}p(x)dx$
    * $p(x)\geq0,{\int_{-\infty}^{+\infty}}p(x)dx=1$
  * Cumulative distribution (累积分布) function $F(x)={\int_0^x}p(t)dt$ 
## Expected value and variance (期望与方差)
* Expected value(期望) = mean value
  * $E(X)={\sum_{i=1}^n}X_iP(X_i)$
  * $E(X)=\int Xp(X)dX$
* Variance(方差)
  * $Var(X)=E(X-E(X))^2=E(X^2)-E(X)^2$
    * $E(X^2)={\sum_{i=1}^n}{X_i^2}P(X_i)$

$X\sim \exp (\lambda)$.   
$p(x)={1\over \lambda} e^{-x\over \lambda},x>0$.   
$E(x)= {\int _0^{+ \infty}}x{1\over \lambda}^{-x\over \lambda}dx=\lambda$.
## Probabilities
* Laws of probabilities
  * Sum rule(compute marginal 边缘 probability)
    * $p(X)=\sum_Yp(X,Y)$
    * $p(X)=\int p(X,Y)dY$
  * Product rule
    * $p(X,Y)=p(X|Y)p(Y)$  

For random variables:  
### Bayes Theorem
$p(Y|X)={{p(X|Y)p(Y)}\over{p(X)}}$  
$p(Y|X)\propto(X|Y)p(Y)$

$p(Y|X)={{p(X|Y)p(Y)}\over{\int{p(X|Y)p(Y)dY}}}$

## Some conventional distributions (常见分布)
### Beroulli distribution(伯努力分布)
* Events: Sucess(X=1) and Failure (X=0)
* $P(X=1)=p, P(X=0)=1-p$
* $E(X)=p$
* $Var(X)=p(1-p)$   

Examples: Tossing coin, vinning a lottery,..
### Binomial distribution(二项式分布)
### Poisson distribution(伯松分布)
* Customers of a bank n (in theory, endless population)
* Probability that a specific person will make a call to the bank between 13.00 and 14.00 a certain day is **_p_**
  * **_p_** can be very small if population is large (rare event)
  * Still, some people will make calls between 13.00 and 14.00 that day, and their amount may be quite big
  * A known quantity **_λ=np_** is mean amount of persons that call between 13.00 and 14.00
  * **X**={amount of persons that have called between 13.00 and 14.00}
* $P(X=r)=\lim_{n\rightarrow{+\infty}}{{n!}\over{(n-r)!r!}}p^r(1-p)^{n-r}$  
* It can be shown that $P(X=r)={{\lambda^re^{-\lambda}}\over{r!}}$
* $E(X)=\lambda$
* $Var(X)=\lambda$

### Normal distribution
* $f(x)={1\over{\sqrt{2\pi}\sigma}}e^{-{{(x-\mu)}\over{2\sigma^2}}},\sigma>0$
* $E(X)=\mu$
* $Var(X)=\sigma^2$

## Basic ML ingridients
### Fitting a model
* Frequenits principle: `Maximum likelihood` principle
  * Compute likelihood $p(T|w)$
  * Maximize the likelihood and find the optimal $w^*$


## Bayesian probabilities
* ### Bayesian principle
  * Compute $p(w|T)$ and then decide yourself what to do whith this (for ex. MAP, mean, median)
* Use bauyes theorem
* $p(T)$ is **`marginal likelihood`**


## Measuring uncertainty
* Confidence interval(frequentist)
* Credible interval(Bayes)
* Prediction interval(models)

* Example: Prediction interval for $Y\sim N(2x+4,1)\ at\ x=5$
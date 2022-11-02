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
## Distributions(分布)
* Discrete
  * Probability mass functuion $P(x)$ for all feasible $x$
* Coninuous
  * Probability densityh function $p(x)$
    * $p(x\in[a,b])=\int_a^bp(x)dx$
    * $p(x)\geq0,\int_{-\infty}^{+\infin}p(x)dx=1$
  * Cumulative distribution (累积分布) function $F(x)=\int_0^xp(t)dt$ 
## Expected value and variance
* Expected value(期望) = mean value
  * $E(X)=\sum_{i=1}^nX_iP(X_i)$
  * $E(X)=\int Xp(X)dX$
* Variance(方差)
  * $Var(X)=E(X-E(X))^2=E(X^2)-E(X)^2$
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
### Binomial distribution(二项式分布)
### Poisson distribution(伯松分布)
### Normal distribution
* $f(x)={1\over{\sqrt{2\pi}\sigma}}e^{-{{(x-\mu)}\over{2\sigma^2}}},\sigma>0$
* $E(X)=\mu$
* $Var(X)=\sigma^2$
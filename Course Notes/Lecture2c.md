- [Dimensionality reduction](#dimensionality-reduction)
  - [Latent variables](#latent-variables)
  - [Principal Component Analysis (PCA)](#principal-component-analysis-pca)
  - [PCA: equivalent formulation](#pca-equivalent-formulation)
  - [PCA: computations](#pca-computations)
  - [PCA in R](#pca-in-r)
  - [Autoencoders (nonlinear PCA)](#autoencoders-nonlinear-pca)
  - [Other linear representation learning methods](#other-linear-representation-learning-methods)
  - [Probabilistic PCA](#probabilistic-pca)
  - [Independent component analysis (ICA)](#independent-component-analysis-ica)
# Dimensionality reduction
## Latent variables
* Sometimes data depends on the variables we can not measure (or hard to measure)
  *  Answers on the test depend on Intelligence
  * Brain activity in the brain is measured by sensors
  * Stock prices depend on market confidence
* Latent factor discovered$\rightarrow$data storage may decrease a lot
* Latent factors
  * Center
  * Scaling
* Original vs compressed
  * 100x100x5=50000
  * 100x100+2*5+2*5=10020
## Principal Component Analysis (PCA)
* PCA is a feature reduction / representation learning technique, aims to learn latent features from $𝑥: \tilde{𝑧} =𝑓(𝑥)$
* Used to approximate high dimensional data with a few  informative features –> much less data to store
> Idea:  Introduce a new coordinate system  (PC1, PC2, …) where 
* The first principal component (PC1) is the direction that maximizes the variance of the projected data

* The second principal component (PC2) is the direction that maximizes the variance of the projected data after the variation along PC1 has been removed

* The third principal component (PC3) is the direction that maximizes the variance of the projected data after the variation along PC1 and PC2 has been removed
….

* In the new coordinate system, coordinates corresponding to the last principal components are very small $\rightarrow$ can take away these columns


* Assume features have mean zero
* `Aim`: maximize variance of projected data
  * Sample covariance matrix $S={1\over n}X^TX$
* **Mathematical objective**  
$$
\max_{u^Tu=1}u^TSu
$$
* Optimal solution found by eigenvalue decomposition  𝑆𝑢=𝜆𝑢 with maximum 𝜆
> Data  
$T=||x^1 \dots x^p||, x^j=(x_{1j},\dots,x_{nj})$
> 1. Centred data  
> $X=||x^1 -\bar{x}^1\ x^2-\bar{x}^2 \dots x^p - \bar{x}^p$||,
> 2. Covariance matrix
          $𝑺={1\over n} 𝑿^𝑻𝑿$
> 3. Search for eigenvectors and eigenvalues of **S**
>   *  Equivalent: SVD of 𝑿
> 4. Coordinates of any data point 
> $x=(x_1…x_p)$ in the new coordinate system:
$𝑧=(𝑧_1,…𝑧_𝑛 ),z_𝑖=𝑥^𝑇 𝑢_𝑖$  
> Matrix form:  $𝑍=𝑋 𝑈$
> 5. Discard principle components after some q:
$𝑍=𝑋 𝑈_𝑞$
> 6. New data will have dimensions n x q instead of n x p  
> Getting approximate original data:
> $$
\tilde{X}=ZU^T_q +||\bar{X}^1\ \bar{X}^2\ \dots \bar{X}^p||
> $$
* Reducing into 2 dim can enable studying structures
  * Example: gene expression data (20000 genes, 2500 cells)

## PCA: equivalent formulation
* Aim: minimize the distance between the original and projected data
$$
\min_{U_M}\sum^N_{i=1}||x_n-\tilde{x}_n||^2
$$
## PCA: computations
* PCA makes a linear compression of features
$$
\min_{U_q}\sum^N_{i=1}||x_n-\tilde{x}_n||^2
$$
* Digits: two eigenvectors extracted
* Interptretation of eigenvectiors
## PCA in R
* Prcomp(), biplot(), screeplot()
```R
mydata=read.csv2("tecator.csv")
data1=mydata
data1$Fat=c()
res=prcomp(data1)
lambda=res$sdev^2
#eigenvalues
lambda
#proportion of variation
sprintf("%2.3f",lambda/sum(lambda)*100)
screeplot(res)
```
> Only 1 component captures the 99% of variation!
* Principal component loadings (U)
```R
U=res$rotation
head(U)
```
* Data in (PC1, PC2) – scores (Z)
```R
plot(res$x[,1], res$x[,2], ylim=c(-5,15))
```
> Do we need the second dimension?-Dependent what we want
* Trace plots
```R
U= res$rotation 
plot(U[,1], main="Traceplot, PC1")
plot(U[,2],main="Traceplot, PC2")
```
> Which components contribute to PC1-2?
## Autoencoders (nonlinear PCA)
* Why linear transformations? Take nonlinear instead!
* 𝑓() and 𝑔() are typically Neural Networks
$$
\min_{U,R}\sum^N_{i=1}||x_n-\tilde{x}_n||^2
$$
## Other linear representation learning methods
* Probabilistic PCA
  * Similar to PCA but has more opportunities
    * Can be used to handle missing values directly
    * Can be easily embedded in Bayesian ML models
    * Can be used to generate new data
* Independent component analysis (ICA)
  * Sometimes shows better emprical results compared to PCA
## Probabilistic PCA
* $𝑧_𝑖$-latent variables, $𝑥_𝑖$- observed variables
$$
z\sim N(0,I)\\
x|z\sim N(x|Wz+\mu, \sigma^2I)
$$
* Alternatively
$$
z\sim N(0,I),x=\mu+Wz+\epsilon,\epsilon \sim N(0,\sigma^2I)
$$
* Interpretation: Observed data (X) is obtained by rotation, scaling and translation of standard normal distribution (Z) and adding some noise.
## Independent component analysis (ICA)
* Probabilistic PCA does not capture latent factors uniquely
  * Rotation invariance

* Let’s choose distribution which is not rotation invariant$\rightarrow$will get unique latent factors

* Choose non-Gaussian $p(𝑧_𝑖 )$

* Assuming latent features are `independent`
$$
p(z)=\prod^M_{i=1}p(z_i)\\
p(z_i)={2\over \pi(e^{z_i}+e^{-z_i})}
$$
# NonparametricKernel Methods
## Histogram, Moving Window, and Kernel Classification
### Histogram Classification
* Consider binary (y∈{0,1}) classification with input space Rp
* The best classifier under the 0-1 loss function is $\hat{y}(x∗)=\argmax_y p(y|x∗)$.
* Since x∗may not appear in the training data${xi,yi}^n_{i=1}$available, then
  * divide the input space into p-dimensional cubes of side h, and
  * classify according to majority vote in the cubeC(x∗,h)that contains x∗.
* In other words
$$
\hat{y}_C(x_*)= 
\begin{cases}
    0\quad if \sum^n_{i=1}1_{y_i=1,x_i\in C(x_*,h)}≤\sum^n_{i=1}1_{y_i=0,x_i\in C(x_*,h)}\\
    1\quad otherwise
\end{cases}

$$
### Moving Window Classification
* The predictions of the histogram rule are less accurate at the corners of the cube,because the corners may be far from the points in the cube.  Then,
  * consider the points within a certain distance to the point to classify, and
  * classify the point according to majority vote.
* In other words
$$
\hat{y}_S(x_*)=
\begin{cases}
    0\quad if \sum^n_{i=1}1_{y_i=1,x_i\in S(x_*,h)}≤\sum^n_{i=1}1_{y_i=0,x_i\in S(x_*,h)}\\
    1\quad otherwise
\end{cases}
$$
where $S(x_*,h)$ is a p-dimensional closed ball of radiushcentered atxxx∗, orequivalently
### Kernel Classification
* The moving window rule gives equal weight to all the points in the ball, whichmay be counterintuitive.  Then,
$$
\hat{y}_S(x_*)=
\begin{cases}
    0\quad if \sum^n_{i=1}1_{y_i=1}K({{x_*-x_i}\over h})≤\sum^n_{i=1}K({{x_*-x_i}\over h})\\
    1\quad otherwise
\end{cases}
$$
## Histogram, Moving Window, and Kernel Regression
* Consider regressing an unidimensional continuous random variable on ap-dimensional continuous random variable.


## Kernel Trick
* The kernel function$k({{x−x′}\over h})$only depends on the difference between the datapointsxxxandxxx′and, thus, it is invariant to data point translations and, thus, itcan be generalized as $k(x,x′)$.  For instance,
  * Polynomial kernel:
  * Gaussian kernel:
* If the matrix
$$

$$
is symmetric and positive semi-definite for all training datasets${xi}^n_{i=1}$, then $k(x,x′)=\phi(x)^T\phi(x′)\ where\ \phi(⋅)$**is a mapping from the input space to thefeature space.**



* Consider again moving window classification or regression.
* Note that $x∈S(x∗,h)$if and only if $\lVert x−x∗\rVert≤h$.



## Kernel Ridge Regression
* Ridge regression = linear regression + L2regularization to avoid overfitting.
$$
\hat{\theta}=\argmin_\theta{1\over n}\lVert X\theta-y \rVert^2_2+\lambda\lVert \theta \rVert^2_2
$$
* As linear regression, ridge regression has a closed-form solution.
$$
\hat{\theta}=(X^TX+n\lambda I_{p+1})^{-1}X^Ty
$$
* Kernel ridge regression = ridge regression in the feature space defined by themapping$\phi(⋅)$rather than in the input space.
$$
\hat{\theta}=\argmin_\theta{1\over n}\sum^n_{i=1}\underbrace{(\theta^T \phi(x_i)-y_i)^2}_{\hat{y}(x_i)}+\lambda\lVert \theta \rVert^2_2=(\Phi(X)^T \Phi(X)+n\lambda I)^{-1}\Phi(X)^Ty
$$

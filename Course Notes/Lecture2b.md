- [Decision trees](#decision-trees)
  - [Classification trees](#classification-trees)
    - [Class proportions](#class-proportions)
    - [Learning classification trees: CART](#learning-classification-trees-cart)
    - [CART: comments](#cart-comments)
    - [Optimal trees](#optimal-trees)
    - [Decision trees: comments](#decision-trees-comments)
    - [Decision trees: issues](#decision-trees-issues)
  - [Decision trees in R](#decision-trees-in-r)
# Decision trees
* Regression trees: Target is a continuous variable
* Classification trees: Target is a class(qualitative) variable


* A tree $=<r_i,s_{r_i},R_j,i=1...S,j=1...L >$
  * $x_{r_i}\leq s_{r_i}$ splitting rules (conditions), 𝑆- their amount
  * $𝑅_𝑗$-terminal nodes, 𝐿- their amount
  * labels $\mu_𝑗$ in each terminal node
* Learning by MLE:
  * Step 1: Finding optimal tree
  * Step 2: Finding optimal labels in terminal nodes
  * `Problem: NP-hard task!`


* Normal model leads to regression trees
  * Objective: MSE
* Multinomial model leads to classification trees
  * Objective: cross-entropy (deviance)

## Classification trees
* Target is categorical
* Classification probability $\pi_{lm}=𝑝(𝑦=𝑚│𝑥∈𝑅_𝑙 )$ is estimated for every class in a node
* estimate $\pi_{lm}$  for class 𝑚 and node $𝑅_𝑙$

### Class proportions
$$
\hat{\pi}_{lm}={1\over{n_l}}\sum_{i:x_i\in R_l}I(y_i=m)
$$
* For any node (or leaf), a label can be assigned
$$
\hat{y}_l=\argmax_m\pi_{lm}
$$
* Impurity measure $Q(𝑅_𝑙 )$
  * $𝑅_𝑙$ is a tree node (region)
  * Node can be split unless it is pure

* **Misclassification rate** $Q(R_l)=1-\max_m\hat{\pi}_{lm}$
* **Gini index** $Q(R_l)=\sum_{m=1}^M\hat{\pi}_{lm}(1-\hat{\pi}_{lm})$
* **Cross-entropy** $Q(R_l)=-\sum_{m=1}^M\hat{\pi}_{lm}\ln\hat{\pi}_{lm}$
* Note: In many sources, `deviance`(偏差) is $Q(𝑅_𝑙 )  𝑛_𝑙$

### Learning classification trees: CART
* Step 1: Finding optimal tree: grow the tree in order to minimize global objective
1. Let $C_0$ be a hypercube containing all observations
2. Let  queue $C=\{C_0\}$
3. Pick up some $C_i$ from $C$ and find a variable $𝑥_𝑗$ and value s that split $C_j$ into two hypercubes  
$$
R_1=\{x|x_k<s\}and R_2=\{x|x_j\geq s\}
$$
and minimizes  
$$
\min_{j,s}[n_1Q(R_1)+n_2Q(R_2)]

$$
4. Remove $C_j$ from $C$ and add $R_1$ and $R_2$
5. Repeat 3-4 as many times as needed (until some stopping criterion is fulfilled or until each cube has only 1 observation)
> Greedy algorithm (optimal tree is not found)
### CART: comments
* The largest tree will interpolate the data $\rightarrow$ large trees = `overfitting` the data
* Too small trees=`underfitting` (important structure may not be captured)
### Optimal trees
* Postpruning  
Weakest link pruning:
1. Merge two leaves that have smallest                              
$n(parent)*Q(parent)-n(leave1)Q(leave1)-n(leave2)Q(leave2)$
2. For the current tree T, compute 
$$
I(T)=\sum_{R_l\in leaves}n(R_l)Q(R_l)+\alpha|T|\\
|T|=\#leaves
$$
3. Repeat 1-2 until the tree with one leave is obtained
4. Select the tree with smallest $I(T)$
> How to find the optimal 𝛼? Cross-validation.
### Decision trees: comments
* Similar algorithms work for regression trees
  * Compute $\hat{y_l}={1\over{n(R_l)}}\sum_{i:x_i\in R_l}(y_i-\hat{y_l})^2$
  * replace$n⋅𝑄(𝑅)\ by\ 𝑆𝑆𝐸(𝑅)=\sum_(𝑖:𝑥_𝑖∈𝑅_𝑙)(𝑦_𝑖−𝑦 ̂_𝑙 )^2$
* Belongs to the class of interpretable ML models
* Easy to handle all types of features in one model
* Automatic variable selection
* Relatively robust to outliers
* Handle large datasets

* Trees have high variance: a small change in response$\rightarrow$ totally different tree
* Greedy algorithms $\rightarrow$ fit may be not so good
* Lack of smoothness
### Decision trees: issues
* Large trees may be needed to model an easy system:

## Decision trees in R
* tree package
  - Alternative: rpart
```R
tree(formula, data, weights, control, split = c("deviance", "gini"), …)
print(), summary(), plot(), text()
```
`Example`: breast cancer as a function av biological measurements
```R
library(tree)
n=dim(biopsy)[1]
fit=tree(class~., data=biopsy)
plot(fit)
text(fit, pretty=0)
fit
summary(fit)
```
* Adjust the splitting in the tree with control parameter (leaf size for ex)
* Misclassification results
```R
Yfit=predict(fit, newdata=biopsy, type="class")
table(biopsy$class,Yfit)
```
* Selecting optimal tree by penalizing
  * Cv.tree()
```R
set.seed(12345)
ind=sample(1:n, floor(0.5*n))
train=biopsy[ind,]
valid=biopsy[-ind,]

fit=tree(class~., data=train)
set.seed(12345)
cv.res=cv.tree(fit)
plot(cv.res$size, cv.res$dev, type="b", col="red")

```
* Selecting optimal tree by train/validation
```R
fit=tree(class~., data=train)

trainScore=rep(0,9)
testScore=rep(0,9)

for(i in 2:9) {
  prunedTree=prune.tree(fit,best=i)
  pred=predict(prunedTree, newdata=valid, type="tree")
  trainScore[i]=deviance(prunedTree)
  testScore[i]=deviance(pred)
}
plot(2:9, trainScore[2:9], type="b", col="red", ylim=c(0,250))
points(2:9, testScore[2:9], type="b", col="blue")
```
* Final tree: 5 leaves
```R
finalTree=prune.tree(fit, best=5)
Yfit=predict(finalTree, newdata=valid, type="class")
table(valid$class,Yfit)
```
setwd("//Users/wilson/WorkSpace/tdde01/lab2/")
data=read.csv("communities.csv",header = TRUE)

library(caret)
scaler=preProcess(data[-101])
dataX=predict(scaler,data[-101])
#Covariance matrix
dataS=t(as.matrix(dataX))%*%as.matrix(dataX)/nrow(dataX)
PCA1=eigen(dataS)


#Task2

res=prcomp(dataX)
lambda=res$sdev^2
#eigenvalues
#proportion of variation
sprintf("%2.3f",lambda/sum(lambda)*100)
screeplot(res)
U=res$rotation
head(U)
colnames(res2$loadings)[which.max(res2$loadings[,1])]


#Task3
n=dim(data)[1]
set.seed(12345) 
id=sample(1:n, floor(n*0.5)) 
train=data[id,] 
test=data[-id,]
scaler=preProcess(data)
trainS=predict(scaler,train)
testS=predict(scaler,test)
model=lm(ViolentCrimesPerPop~.,trainS)



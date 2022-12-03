setwd("//Users/wilson/WorkSpace/tdde01/lab2/")
data=read.csv("communities.csv",header = TRUE)
library(ggplot2)
library(caret)
scaler=preProcess(data[-101])
dataX=predict(scaler,data[-101])
#Covariance matrix
dataS=t(as.matrix(dataX))%*%as.matrix(dataX)/nrow(dataX)
PCA1=eigen(dataS)

for(i in 1:100){
  if(sum(PCA1$values[1:i])>=95){
    break
  }
}
print(i)#the number of components
print(PCA1$values[1])
print(PCA1$values[2])
#Task2

PCA2=princomp(dataX)
#PC1
plot(PCA2$loadings[,1],main="Traceplot, PC1")

index=order(abs(PCA2$loadings[,1]),decreasing=TRUE)[1:5]
print(PCA2$loadings[index,1])#5 features contribute mostly (by the absolute value)
ggplot()
#TODO ggplot



#Task3
n=dim(data)[1]
set.seed(12345) 
id=sample(1:n, floor(n*0.5)) 
train=data[id,] 
test=data[-id,]
scaler=preProcess(data[-101])
trainS=predict(scaler,train[-101])
testS=predict(scaler,test[-101])
model=lm(train$ViolentCrimesPerPop~.,trainS)
predict(model,trainS)
pred.train <- predict(model, trainS)
pred.test <- predict(model, testS)
err.train <- mean((train$ViolentCrimesPerPop - pred.train) ^ 2)
err.test <- mean((test$ViolentCrimesPerPop - pred.test) ^ 2)
#TODO if scale is correct

#Task4
trainZ=data.frame(0,trainS)
testZ=data.frame(0,testS)
TestE=list()
TrainE=list()
k=0
mseTrain= function(w){
  
  MSE_train=mean((train$ViolentCrimesPerPop - t(w)%*%t(trainZ)) ^ 2)
  MSE_test=mean((test$ViolentCrimesPerPop - t(w)%*%t(trainZ)) ^ 2)
  .GlobalEnv$k= .GlobalEnv$k+1
  .GlobalEnv$TrainE[[k]]=MSE_train
  .GlobalEnv$TestE[[k]]=MSE_test
  return(MSE_train)
}
res=optim(c(0), fn=mseTrain,  method="BFGS")

plot(as.numeric(TrainE), type="l", col="blue", ylim=c(0.05,0.2), ylab="Error")
points(as.numeric(TestE), type="l", col="red")

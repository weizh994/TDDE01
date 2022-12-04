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
plot(abs(PCA2$loadings[,1]),main="Traceplot, PC1")

index=order(abs(PCA2$loadings[,1]),decreasing=TRUE)[1:5]
print(PCA2$loadings[index,1])#5 features contribute mostly (by the absolute value)
scores=data.frame(PC1=PCA2$scores[,1],PC2=PCA2$scores[,2],ViolentCrimesPerPop=data$ViolentCrimesPerPop)
ggplot(scores, aes(x=PC1,y=PC2,color=ViolentCrimesPerPop) ) +
  geom_point()



#Task3
n=dim(data)[1]
set.seed(12345) 
id=sample(1:n, floor(n*0.5)) 
train=data[id,] 
test=data[-id,]
scaler=preProcess(data)
trainS=predict(scaler,train)
testS=predict(scaler,test)
model=lm(train$ViolentCrimesPerPop~.,trainS)
predict(model,trainS)
pred.train <- predict(model, trainS)
pred.test <- predict(model, testS)
err.train <- mean((train$ViolentCrimesPerPop - pred.train) ^ 2)
err.test <- mean((test$ViolentCrimesPerPop - pred.test) ^ 2)

#Task4

TestE=list()
TrainE=list()
k=0
mseTrain= function(w){
  MSE_train=mean((train$ViolentCrimesPerPop - t(w)%*%t(train[-101])) ^ 2)
  MSE_test=mean((test$ViolentCrimesPerPop - t(w)%*%t(test[-101])) ^ 2)
  .GlobalEnv$k= .GlobalEnv$k+1
  .GlobalEnv$TrainE[[k]]=MSE_train
  .GlobalEnv$TestE[[k]]=MSE_test
  return(MSE_train)
}
res=optim(matrix(0,nrow = 100, ncol = 1), fn=mseTrain,  method="BFGS")

plot(as.numeric(TrainE), type="l", col="blue",xlab = "Iteration" ,ylab="Error",ylim = range(0,0.1),xlim =  range(500,5000))
points(as.numeric(TestE), type="l", col="red")
abline(h=TestE[which.min(TestE)],lty=2)
abline(v=which.min(TestE),lty=2)


print(TrainE[which.min(TestE)])
print(TestE[which.min(TestE)])


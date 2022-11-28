setwd("//Users/wilson/WorkSpace/tdde01/lab2/")
library(caret)
install.packages("glmnet")
library(glmnet)
library(ggplot2)
# Divide data randomly into train and test (50/50)
data=read.csv("tecator.csv",header = TRUE)
data[,1]=c()
n=dim(data)[1]
set.seed(12345)
id=sample(1:n,floor(n*0.5))
train=data[id,]
test=data[-id,]

# Task 1
# Train model
fit=lm(Fat~.-Protein -Moisture,train)
fit.info=summary(fit)
coef(fit)
# Get predictions on training and test data
pred.train <- predict(fit, train)
pred.test <- predict(fit, test)
# Calculate MSE via sapply and via matrix
MSE.train <- mean((train$Fat-pred.train)^2)
MSE.test <- mean((test$Fat - pred.test)^2)
#TODO:Chect if this correct

# Task2

#Task3
X<- as.matrix(train[,1:100])
Y<- as.matrix(train[,101])
lasso_model<-glmnet(X,Y,alpha=1,) 

plot(lasso_model, xvar="lambda", label=TRUE)
#ggplot(lasso_model)
#TODO bete->coef

#Task4
ridge_model=glmnet(X, Y, alpha=0,family="gaussian")
plot(ridge_model, xvar="lambda", label=TRUE)

#Task5
# TODO cv.glmnet

lasso_cvmodel<-cv.glmnet(X,Y,alpha=1,) 
best_lambda <- lasso_cvmodel$lambda.min

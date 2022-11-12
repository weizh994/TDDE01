setwd("/Users/wilson/WorkSpace/tdde01/lab1")
## install kknn
install.packages("kknn")
library(kknn)

## Divide into train, valid and test sets
optdigits=as.data.frame(read.csv("optdigits.csv"))
n=dim.data.frame(optdigits)[1]
set.seed(12345) 
id=sample(1:n, floor(n*0.5)) 
train=optdigits[id,] 
id1=setdiff(1:n, id)
set.seed(12345) 
id2=sample(id1, floor(n*0.25)) 
valid=optdigits[id2,]
id3=setdiff(id1,id2)
test=optdigits[id3,] 

y_train=train[,65]
##
model = kknn(as.factor(train[,65])~., train=train, test=train,k=30, kernel="rectangular")

##install.packages("caret")
library(caret)
##print(dim(as.matrix(pred_train)))
print(dim((train[,65])))
print(dim((model$fitted.values)))
cm_train=confusionMatrix(data=model$fitted.values,reference = as.factor( train[,65]))


model1=kknn(as.factor(train[,65])~., train=train, test=test,k=30, kernel="rectangular")
cm_test=confusionMatrix(data=model1$fitted.values,reference = as.factor( test[,65]))
print(cm_test)

model2=kknn(as.factor(train[,65])~., train=train, test=valid,k=30, kernel="rectangular")
cm_valid=confusionMatrix(data=model2$fitted.values,reference = as.factor( valid[,65]))
print(cm_valid)
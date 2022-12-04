setwd("//Users/wilson/WorkSpace/tdde01/lab2/")
#Task1
data=read.csv2("bank-full.csv",header = TRUE,stringsAsFactors = TRUE,)
data$duration=c()
n=dim(data)[1]
set.seed(12345) 
id=sample(1:n, floor(n*0.4)) 
train=data[id,] 

id1=setdiff(1:n, id)
set.seed(12345) 
id2=sample(id1, floor(n*0.3)) 
valid=data[id2,]

id3=setdiff(id1,id2)
test=data[id3,] 

#Task2
install.packages("tree")
library(tree)
tree0<-tree(as.factor(y)~.,train)
tree1<-tree(as.factor(y)~.,train, control = tree.control(nrow(train), minsize = 7000))
tree2<-tree(as.factor(y)~.,train,control = tree.control(nrow(train),mindev=0.0005))
plot(tree0)
text(tree0)
plot(tree1)
text(tree1)
plot(tree2)
text(tree2)
tree0
summary(tree0)
tree1
summary(tree1)
tree2
summary(tree2)

Vtree0=predict(tree0, newdata=valid, type="class")
table(valid$y,Vtree0)
Vtree1=predict(tree1, newdata=valid, type="class")
table(valid$y,Vtree1)
Vtree2=predict(tree2, newdata=valid, type="class")
table(valid$y,Vtree2)

#Task3
trainScore=rep(0,50)
validScore=rep(0,50)

for(i in 2:50) {
  prunedTree=prune.tree(tree2,best=i)
  pred=predict(prunedTree, newdata=valid, type="tree")
  trainScore[i]=deviance(prunedTree)
  validScore[i]=deviance(pred)
}
plot(2:50, trainScore[2:50], type="b", col="red",ylim=range(min(validScore[2:50]),max(trainScore[2:50])))
points(2:50, validScore[2:50], type="b", col="blue")

opt=which.min(validScore[2:50])
finalTree=prune.tree(tree2, best=opt)
Yfit=predict(finalTree, newdata=valid, type="class")
table(valid$y,Yfit)

#Task4
Ttree=predict(finalTree, newdata=test, type="class")
Pred=ifelse(Ttree=="no", "Pred_No", "Pred_Yes")
MC_test=table(test$y,Pred)
print(MC_test)
accuracy=(MC_test[1,1]+MC_test[2,2])/sum(MC_test)
Precision=MC_test[2,2]/(MC_test[2,2]+MC_test[1,2])
Recall = MC_test[2,2]/(MC_test[2,2]+MC_test[2,1])
F1_Score = 2 * (Precision * Recall) / (Precision + Recall)
print(F1_Score)

#Task5


#Task6
reg_model=glm(as.factor(y)~.,train,family = "binomial")
Prob=predict(reg_model,test, type="response")
ProbT = predict(finalTree,test,type="vector")
Pred=list()
PredT=list()
TPR=list()
TPRT=list()
FPR=list()
FPRT=list()
r=0.05
k=1
while(r<=0.95){
  .GlobalEnv$Pred[[k]]=ifelse(Prob>r, "Pred_Yes", "Pred_No")
  .GlobalEnv$PredT[[k]]=ifelse(ProbT[,2]>r, "Pred_Yes", "Pred_No")
  MC.table=table(test$y,.GlobalEnv$Pred[[k]])
  MCT.table=table(test$y,.GlobalEnv$PredT[[k]])
  .GlobalEnv$TPR[[k]]=MC.table[2,2]/(MC.table[2,2]+MC.table[2,1])
  .GlobalEnv$FPR[[k]]=MC.table[1,1]/(MC.table[1,2]+MC.table[1,1])
  .GlobalEnv$TPRT[[k]]=MCT.table[2,2]/(MCT.table[2,2]+MCT.table[2,1])
  .GlobalEnv$FPRT[[k]]=MCT.table[1,1]/(MCT.table[1,2]+MCT.table[1,1])
  .GlobalEnv$r=.GlobalEnv$r+0.05
  .GlobalEnv$k= .GlobalEnv$k+1
}
plot(FPR,TPR,type="l",col="blue")
points(FPRT,TPRT,type="l",col="red")
setwd("/Users/wilson/WorkSpace/tdde01/lab1")
data=read.csv("pima-indians-diabetes.csv")
colnames(data)[ncol(data)-1]="Age"
colnames(data)[ncol(data)]="Diabetes"
## task1
plot(data[data$Diabetes==0,ncol(data)-1],data[data$Diabetes==0,2],col="blue")
points(data[data$Diabetes==1,ncol(data)-1],data[data$Diabetes==1,2],col="red")

## task2
colnames(data)[2]="Plasma"
data2=data.frame(data$Plasma,data$Age,data$Diabetes)
m2=glm(as.factor(data2$data.Diabetes)~.,data2,family = "binomial")
Prob=predict(m2, type="response")
r=0.5
Pred=ifelse(Prob>=r, "Diabetes", "No Diabetes")
table(data2$data.Diabetes, Pred)

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
r1=0.5
Pred=ifelse(Prob>=r1, "Diabetes", "No Diabetes")
Pred_table=table(data2$data.Diabetes, Pred)
mc_error1=(Pred_table[1,1]+Pred_table[2,2])/sum(Pred_table)
data2_2=data.frame(data$Plasma,data$Age,Prob)
plot(data2_2[data2_2$Prob>=r1,2],data2_2[data2_2$Prob>=r1,1],col="red",xlim = range(min(data2_2$data.Age),max(data2_2$data.Age)),ylim = range(min(data2_2$data.Plasma),max(data2_2$data.Plasma)))
points(data2_2[data2_2$Prob<r1,2],data2_2[data2_2$Prob<r1,1],col="blue")
data2_3=data.frame(1,data$Plasma,data$Age)
z2=t(as.matrix(m2$coefficients))%*%t(data2_3)
plot(z2,exp(z2)/(1+exp(z2)),xlim = range(-8,8))

slope <- -m2$coefficients[3]/m2$coefficients[2]
intercept <- -m2$coefficients[1]/m2$coefficients[2]
abline(intercept,slope)
## task3
## a) g(x)=1-g(x)




## task4
r2=0.2
Pred2=ifelse(Prob>=r2, "Diabetes", "No Diabetes")
Pred_table2=table(data2$data.Diabetes, Pred2)
mc_error2=(Pred_table2[1,1]+Pred_table2[2,2])/sum(Pred_table2)
plot(data2_2[data2_2$Prob>=r2,2],data2_2[data2_2$Prob>=r2,1],col="red",xlim = range(min(data2_2$data.Age),max(data2_2$data.Age)),ylim = range(min(data2_2$data.Plasma),max(data2_2$data.Plasma)))
points(data2_2[data2_2$Prob<r2,2],data2_2[data2_2$Prob<r2,1],col="blue")
r3=0.8
Pred3=ifelse(Prob>=r3, "Diabetes", "No Diabetes")
Pred_table3=table(data2$data.Diabetes, Pred3)
mc_error3=(Pred_table3[1,1]+Pred_table3[2,2])/sum(Pred_table3)
plot(data2_2[data2_2$Prob>=r3,2],data2_2[data2_2$Prob>=r3,1],col="red",xlim = range(min(data2_2$data.Age),max(data2_2$data.Age)),ylim = range(min(data2_2$data.Plasma),max(data2_2$data.Plasma)))
points(data2_2[data2_2$Prob<r3,2],data2_2[data2_2$Prob<r3,1],col="blue")




## task5
x1=data$Plasma
x2=data$Age
z1=x1^4
z2=x1^3*x2
z3=x1^2*x2^2
z4=x1*x2^3
z5=x2^4
y=data$Diabetes
data5=data.frame(x1,x2,z1,z2,z3,z4,z5,y)
m5=glm(as.factor(data5$y)~.,data5,family = "binomial")
Prob5=predict(m5, type="response")
Pred5=ifelse(Prob5>=r1, "Diabetes", "No Diabetes")
Pred_table5=table(data5$y, Pred5)
mc_error5=(Pred_table5[1,1]+Pred_table5[2,2])/sum(Pred_table5)
data5_2=data.frame(data$Plasma,data$Age,Prob5)
plot(data5_2[data5_2$Prob>=r1,2],data5_2[data5_2$Prob>=r1,1],col="red",xlim = range(min(data5_2$data.Age),max(data5_2$data.Age)),ylim = range(min(data5_2$data.Plasma),max(data5_2$data.Plasma)))
points(data5_2[data5_2$Prob<r1,2],data5_2[data5_2$Prob<r1,1],col="blue")
data5_3=data.frame(1,x1,x2,z1,z2,z3,z4,z5)
z5=t(as.matrix(m5$coefficients))%*%t(as.matrix(data5_3))
#plot(z5,exp(z5)/(1+exp(z5)),xlim = range(-8,8))
slope <- -m5$coefficients[3]/m5$coefficients[2]
intercept <- -m5$coefficients[1]/m5$coefficients[2]
abline(intercept,slope)

## install kknn
install.packages("kknn")
library("kknn")

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

##

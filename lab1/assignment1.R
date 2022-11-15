 setwd("/Users/wilson/WorkSpace/tdde01/lab1")

# install.packages("kknn")
library(kknn)

## Divide into train, valid and test sets

## 1)
data <- read.csv("optdigits.csv")
n <- nrow(data)
set.seed(12345)

train_ids <- sample(1:n, floor(n * 0.5))
train <- data[train_ids, ]
id1 <- setdiff(1:n, train_ids)
id2 <- sample(id1, floor(n * 0.25))
valid <- data[id2, ]
id3 <- setdiff(id1, id2)
test <- data[id3, ]

## 2)
# Fit a kknn model to our training data and test it on the training data
model_train <- kknn(as.factor(train[, 65]) ~ ., train = train, test = train, k = 30, kernel = "rectangular")

# Confusion matrix for predictions on training data
cm_train <- table(train[, 65], model_train$fitted.values)
print(cm_train)
miss_train <- nrow(train) - sum(diag(cm_train))
miss_rate_train <- miss_train / nrow(train)

# Fit a kknn model to our training data and test it on the test data
model_test <- kknn(as.factor(train[, 65]) ~ ., train = train, test = test, k = 30, kernel = "rectangular")

# Confusion matrix for predictions on test data
cm_test <- table(test[, 65], model_test$fitted.values)
print(cm_test)
miss_test <- nrow(test) - sum(diag(cm_test))
miss_rate_test <- miss_test / nrow(test)

## 3)
# All the true eights
temp <- which(as.numeric(train[,65]) == 8)
eights_probs <- model_train$prob[temp, 9]
eights_indices <- temp[order(eights_probs, decreasing = T)]

eights_count = length(eights_indices)    

# Two lowest confidence
lowest1 <- matrix(as.numeric(train[eights_indices[eights_count], -65]), 8, 8, byrow = T)
lowest2 <- matrix(as.numeric(train[eights_indices[eights_count-1], -65]), 8, 8, byrow = T)
lowest3 <- matrix(as.numeric(train[eights_indices[eights_count-2], -65]), 8, 8, byrow = T)

heatmap(lowest1, Rowv = NA, Colv = NA)
heatmap(lowest2, Rowv = NA, Colv = NA)
heatmap(lowest3, Rowv = NA, Colv = NA)

# Two highest confidence
highest1 <- matrix(as.numeric(train[eights_indices[1], -65]), 8, 8, byrow = T)
highest2 <- matrix(as.numeric(train[eights_indices[2], -65]), 8, 8, byrow = T)

heatmap(highest1, Rowv = NA, Colv = NA)
heatmap(highest2, Rowv = NA, Colv = NA)

## 4)
train_err <- list()
valid_err <- list()
for (k in 1:30) {
  # Training 
  model_train_k <- kknn(as.factor(train[, 65]) ~ ., train = train, test = train, k = k, kernel = "rectangular")
  cm_train_k <- table(train[, 65], model_train_k$fitted.values)
  train_err[k] <- nrow(train) - sum(diag(cm_train_k)) / nrow(train)
  
  # Validation
  model_valid_r <- kknn(as.factor(train[, 65]) ~ ., train = train, test = valid, k = k, kernel = "rectangular")
  cm_valid_k <- table(train[, 65], model_valid_r$fitted.values)
  valid_err[k] <- nrow(train) - sum(diag(cm_valid_k)) / nrow(train)
}










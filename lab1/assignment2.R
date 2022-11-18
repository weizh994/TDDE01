# Don't forget to setwd
set.seed(12345)


## Task 1
# Read in data
data = read.csv("parkinsons.csv")

# Create mirrored column Y from motor_UPDRS for easier referencing
data$Y <- data$motor_UPDRS

# Only use the features explictly noted in task
data <- data[,7:ncol(data)]

# Scale the data
library(caret)
scaler <- preProcess(data)
data <- predict(scaler, data)

# Split the data in training and test
N = nrow(data)
ids.train = sample(1:N, floor(N * .6))
data.train = data[ids.train,]
N.train = length(ids.train)

data.test = data[-ids.train,]
N.test = nrow(data.test)


## Task 2
# Train model and explicitly remove intercept
model <- lm(data.train$Y ~ . - 1, data.train)
model.info <- summary(model)

# Get predictions on training and test data
pred.train <- predict(model, data.train)
pred.test <- predict(model, data.test)

# Calculate MSE via sapply and via matrix
err.train <- mean(sapply(1:N.train, FUN = function(i) { (data.train$Y[i] - pred.train[i]) ^ 2 }))
err.test <- mean((data.test$Y - pred.test) ^ 2)
# TODO: Comment on important variables


## Task 3
## Subtask a.
loglikelihood <- function(theta, sigma) {
  N = nrow(data.train)
  
  term1 <- -(N / 2) * log(2 * pi)
  term2 <- (N / 2) * log(sigma ^ 2)
  term3 <- (1 / (2 * sigma ^ 2)) * sum((data.train$Y - as.matrix(data.train[,-1]) %*% as.matrix(theta)) ^ 2)
  
  term1 - term2 - term3
}

## Subtask b.
ridge <- function(theta, params) {
  -loglikelihood(theta, params[[1]]) + params[[2]] * sum(theta ^ 2)
}

## Subtask c.
ridgeopt <- function(lambda) {
  theta <- seq(from=1, to=ncol(data.train) - 1)
  sigma <- 0.5
  res <- optim(theta, ridge, gr = NULL, c(sigma, lambda), method = "BFGS")
  res$par
}

## Subtask d.
DF <- function(data, lambda) {
  
}


## Task 4
err.train = c()
err.test = c()
for (lambda in c(1, 100, 1000)) {
  theta <- ridgeopt(lambda)
  print(sprintf("Parameter vector theta for lambda=%d:", lambda))
  print(theta)
  
  diff.train <- data.train$Y - as.matrix(data.train[,-1]) %*% theta
  err.train <- c(err.train, mean(diff.train ^ 2))
  
  diff.test <- data.test$Y - as.matrix(data.test[,-1]) %*% theta
  err.test <- c(err.test, mean(diff.test ^ 2))
}

plot(c(1, 100, 1000), err.train)

plot(c(1, 100, 1000), err.test)

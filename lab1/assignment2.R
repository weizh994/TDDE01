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

# Calculate MSE via sum and via matrix
err.train <- mean(sapply(1:N.train, FUN = function(i) { (data.train$Y[i] - pred.train[i]) ^ 2 }))
err.test <- mean((data.test$Y - pred.test) ^ 2)
# TODO: Comment on important variables


## Task 3
## Subtask a.
loglikelihood <- function(data, theta, sigma) {
  N = nrow(data)
  
  term1 <- -(N / 2) * log(2 * pi)
  term2 <- -(N / 2) * log(dispersion ^ 2)
  # TODO: We would need the mean in term3 according to https://www.statlect.com/glossary/log-likelihood
  term3 <- -(1 / 2 * dispersion ^ 2) * sum(1:N)
}

## Subtask b.
ridge <- function(data, theta, sigma, lambda) {
  -loglikelihood(data, theta, sigma) + lambda * sum(theta ^ 2)
}

## Subtask c.
ridgeopt <- function(data, lambda) {
  optim()
}

## Subtask d.
DF <- function(data, lambda) {
  
}
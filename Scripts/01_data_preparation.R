library(ISLR2)
library(glmnet)
library(leaps)
library(MASS)
library(stats)
library(tidyverse)
library(caret)
library(dplyr)
library(purrr)
library(naniar)

# Load the Hitters dataset
data("Hitters")  

# Inspect the dataset
str(Hitters)       # structure of the dataset
summary(Hitters)   # summary statistics
head(Hitters)      # first rows
dim(Hitters)       # number of rows and columns

# Clean the data
cleaned_hitters <- na.omit(Hitters)
cat("Original dimensions:", dim(Hitters), "\n")
cat("Cleaned dimensions:", dim(cleaned_hitters), "\n")

# Response variable (log-transformed Salary)
y <- log(cleaned_hitters$Salary)

# Features: numeric + categorical (convert factors to dummies)
X <- model.matrix(y ~ . , data = cleaned_hitters)[, -1]  # drop intercept

# Combine into a single organized dataset (target first)
organized_data <- cbind(y, X)

# Function to split and scale data
split_and_scale_data <- function(data, train_prop = 0.6, valid_prop = 0.2) {
  N <- nrow(data)
  
  # Random indices for splits
  train_indices <- sample(1:N, size = floor(train_prop * N))
  remaining_indices <- setdiff(1:N, train_indices)
  valid_indices <- sample(remaining_indices, size = floor(valid_prop * N))
  test_indices <- setdiff(remaining_indices, valid_indices)
  
  # Create datasets
  train_data <- data[train_indices, ]
  valid_data <- data[valid_indices, ]
  test_data  <- data[test_indices, ]
  
  # Separate target and features
  y_train <- train_data[, 1]
  y_valid <- valid_data[, 1]
  y_test  <- test_data[, 1]
  
  X_train <- as.matrix(train_data[, -1])
  X_valid <- as.matrix(valid_data[, -1])
  X_test  <- as.matrix(test_data[, -1])
  
  # Scale features based on training set
  X_train_scaled <- scale(X_train)
  X_valid_scaled <- scale(X_valid, center = attr(X_train_scaled, "scaled:center"),
                          scale  = attr(X_train_scaled, "scaled:scale"))
  X_test_scaled  <- scale(X_test,  center = attr(X_train_scaled, "scaled:center"),
                          scale  = attr(X_train_scaled, "scaled:scale"))
  
  # Center the target based on training mean
  y_mean <- mean(y_train)
  y_train_centered <- y_train - y_mean
  y_valid_centered <- y_valid - y_mean
  y_test_centered  <- y_test - y_mean
  
  return(list(
    X_train = X_train_scaled, X_valid = X_valid_scaled, X_test = X_test_scaled,
    y_train = y_train_centered, y_valid = y_valid_centered, y_test = y_test_centered
  ))
}

# Apply the function
data_splits <- split_and_scale_data(organized_data, train_prop = 0.6, valid_prop = 0.2)

# Extract matrices for modeling
X_train <- data_splits$X_train
y_train <- data_splits$y_train
X_valid <- data_splits$X_valid
y_valid <- data_splits$y_valid
X_test  <- data_splits$X_test
y_test  <- data_splits$y_test

# Check dimensions
cat("Train: ", dim(X_train), length(y_train), "\n")
cat("Valid: ", dim(X_valid), length(y_valid), "\n")
cat("Test:  ", dim(X_test), length(y_test), "\n")
# Least Squares

# Convert training predictors to a data frame and add target
train_df <- as.data.frame(X_train)
train_df$y <- y_train

# Fit linear regression on training data
ls_model <- lm(y ~ ., data = train_df)

# Show model summary: coefficients, standard errors, t-values, and p-values
summary(ls_model)

# Predict on training data
y_train_pred <- predict(ls_model, newdata = train_df)

# Compute training Mean Squared Error
train_mse <- mean((y_train - y_train_pred)^2)
cat("Training MSE:", train_mse, "\n")
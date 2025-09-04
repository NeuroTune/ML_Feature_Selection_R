# Least Squares

train_df <- as.data.frame(X_train)
train_df$y <- y_train

# Fit linear regression on training data
ls_model <- lm(y ~ ., data = train_df)
summary(ls_model)

# Predict on training data
y_train_pred <- predict(ls_model, newdata = train_df)

# Mean Squared Error
train_mse <- mean((y_train - y_train_pred)^2)
cat("Training MSE:", train_mse, "\n")
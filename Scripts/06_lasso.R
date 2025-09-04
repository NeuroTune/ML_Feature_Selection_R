library(glmnet)

# Prepare matrices
x <- as.matrix(X_train)
y <- y_train
var_names <- colnames(x)

# Fit Lasso with cross-validation
lasso_cv <- cv.glmnet(x, y, alpha = 1)
best_lambda <- lasso_cv$lambda.min

# Fit full Lasso path 
fit_lasso <- glmnet(x, y, alpha = 1)

plot(fit_lasso, xvar = "lambda", label = FALSE, main = "Lasso Coefficient Paths")
cols <- 1:length(var_names)  
legend("topright", legend = var_names, col = cols, lty = 1, cex = 0.5)


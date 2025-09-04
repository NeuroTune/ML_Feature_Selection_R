library(leaps)

# Best Subsets Regression
fitbsub <- regsubsets(x = X_train, y = y_train)
res_sum <- summary(fitbsub)

# Identify the best model indices for each criterion
best_adjR2 <- which.max(res_sum$adjr2)
best_Cp    <- which.min(res_sum$cp)
best_BIC   <- which.min(res_sum$bic)

# Helper function - extract predictors from the best model
get_features <- function(id, object) {
  models <- summary(object)$which[id, -1]   
  predictors <- names(which(models == TRUE))
  paste(predictors, collapse = " + ")
}

summary(fitbsub)
plot(fitbsub, scale = "adjr2")
plot(fitbsub, scale = "Cp")
plot(fitbsub, scale = "bic")

# Print best models
cat("Best model (Adj.R²):", get_features(best_adjR2, fitbsub), "\n")
cat("Best model (Cp):", get_features(best_Cp, fitbsub), "\n")
cat("Best model (BIC):", get_features(best_BIC, fitbsub), "\n")
cat("Best model (Adj.R²):", get_features(best_adjR2, fitbsub), "\n")
cat("Best model (Cp):", get_features(best_Cp, fitbsub), "\n")
cat("Best model (BIC):", get_features(best_BIC, fitbsub), "\n")


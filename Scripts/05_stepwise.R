library(MASS)  # stepAIC
train_df <- as.data.frame(X_train)   # matrix to data frame
train_df$LogSalary <- y_train        # target added

# Forward stepwise selection
fit0 <- lm(LogSalary ~ 1, data = train_df)  # start with intercept only
fitf <- stepAIC(fit0,
                scope = LogSalary ~ AtBat + Hits + HmRun + Runs + RBI + Walks + Years + 
                        CAtBat + CHits + CHmRun + CRuns + CRBI + CWalks + PutOuts + Assists + Errors,
                direction = "forward", k = log(nrow(train_df)))  # k = log(n) uses BIC

# Backward stepwise selection
fit_full <- lm(LogSalary ~ . , data = train_df)
fitb <- stepAIC(
  fit_full,
  direction = "backward",
  k = log(nrow(train_df))  # BIC
)

# Summaries
summary(fitf)
summary(fitb)
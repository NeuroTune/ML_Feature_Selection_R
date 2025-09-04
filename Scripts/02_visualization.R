
# Salary distributions
hist(cleaned_hitters$Salary, main = "Salary Histogram", xlab = "Salary")
hist(y, main = "LogSalary Histogram", xlab = "Log(Salary)")

# Identify numeric and categorical variables 
numeric_cols <- names(cleaned_hitters)[sapply(cleaned_hitters, is.numeric)]
midpoint <- ceiling(length(numeric_cols) / 2)
numerical_group_1 <- c(numeric_cols[1:midpoint], "Salary")
numerical_group_2 <- c(numeric_cols[(midpoint + 1):length(numeric_cols)], "Salary")

# Create data frames for each group
numerical_p_1 <- cleaned_hitters[, numerical_group_1]
numerical_p_2 <- cleaned_hitters[, numerical_group_2]

# Scatterplot 
pairs(numerical_p_1, main = "Pairs Plot: Numerical Group 1 with Salary")

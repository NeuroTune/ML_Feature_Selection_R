# Machine_Learning_Feature_Selection_in_R
In this tutorial, we explore various linear modeling and feature selection techniques using a baseball dataset. The goal is to identify the most important predictors of player salaries and understand how different methods approach feature selection and regularization.

We will cover:  

1. **Data Preparation** – Clean, Transform, Split 
2. **Exploratory Data Analysis** - Visualizing the Target Variable and Pairwise Relationships
3. **Linear Regression** – 
4. **Best Subsets**
5. **Stepwise Selection** – Forward & Backward  
10. **Regularization Methods** – Lasso and Elastic Net

Additionally, we will **visualize regularization paths** to see how coefficients change with tuning parameters, and evaluate model performance on training, validation, and test sets.  

This tutorial combines **theory, coding, and interpretation** so you can both implement these methods in R and understand their practical implications for prediction and feature selection.

## Setup Instructions

### 1. Install R (if not installed)
- Download from [CRAN](https://cran.r-project.org/)  

### 2. Install Required Packages

```r 
install.packages(c(
  "ISLR2",
  "glmnet",
  "leaps",
  "MASS",
  "stats",
  "tidyverse",
  "caret",
  "dplyr",
  "purrr",
  "naniar"
))

````

### 3. Load the Libraries and Hitters dataset

- Option 1: Load data from ISLR2 package
  
- Option 2: Load data from local data file 

```r
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

data("Hitters")  #option 1

Hitters <- read.csv("Data/hitters_data.csv") #option 2

str(Hitters)       # structure
summary(Hitters)   # summary stats
head(Hitters)      # first rows
dim(Hitters)       # dimensions
```

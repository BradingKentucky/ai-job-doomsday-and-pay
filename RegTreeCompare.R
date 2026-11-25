library(rpart)
library(rpart.plot)

model_data <- na.omit(majors[
  c("median_starting_salary", "n_occupations", "ai_exposure")
])

# Split data into training and test sets
set.seed(123)  # use same seed if wanna repeat the test
train_rows <- sample(
  seq_len(nrow(model_data)),
  size = floor(0.8 * nrow(model_data))
)

train <- model_data[train_rows, ]
test  <- model_data[-train_rows, ]

# Baseline
baseline_mean <- mean(train$median_starting_salary)

baseline_time <- system.time({
  baseline_predictions <- rep(baseline_mean, nrow(test))
})["elapsed"]

# regression tree
tree_time <- system.time({
  tree <- rpart(
    median_starting_salary ~ n_occupations + ai_exposure,
    data = train,
    method = "anova"
  )
  
  # Select CP with the lowest cross-validated error
  best_cp <- tree$cptable[
    which.min(tree$cptable[, "xerror"]),
    "CP"
  ]
  
  pruned_tree <- prune(tree, cp = best_cp)
  tree_predictions <- predict(pruned_tree, newdata = test)
})["elapsed"]

# Metrics
metrics <- function(actual, predicted) {
  c(
    MAE = mean(abs(actual - predicted)),
    RMSE = sqrt(mean((actual - predicted)^2)),
    R_squared = 1 - sum((actual - predicted)^2) /
      sum((actual - mean(actual))^2)
  )
}

results <- rbind(
  Baseline_mean = metrics(test$median_starting_salary,
                          baseline_predictions),
  Pruned_tree = metrics(test$median_starting_salary,
                        tree_predictions)
)

results
c(Baseline_seconds = baseline_time, Tree_seconds = tree_time)


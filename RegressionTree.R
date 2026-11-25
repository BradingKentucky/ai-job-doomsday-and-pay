install.packages("rpart")       # Gets us Linear Regresion Tree
install.packages("rpart.plot")  # makes plot look nice

library(rpart)
# are they even correlated?
model <- lm(
  median_starting_salary ~ ai_exposure + n_occupations,
  data = majors
)

summary(model)


# Makes the tree
tree <- rpart(
  majors$median_starting_salary ~ majors$n_occupations + majors$ai_exposure,
  data = majors,
  method = "anova"
)

print(tree)

# Plot it
library(rpart.plot)
rpart.plot(tree)

# see if splits are good or not
printcp(tree)

# prune the tree for one with least branches
best_cp <- tree$cptable[
  which.min(tree$cptable[, "xerror"]),
  "CP"
]

pruned_tree <- prune(tree, cp = best_cp)
rpart.plot(pruned_tree)


# Predict for new observations with OG tree
predictions <- predict(tree, newdata = majors)

#compare with actual results

actual <- majors$median_starting_salary

# Mean absolute error: average absolute difference, in salary units
mean(abs(actual - predictions), na.rm = TRUE)

# Root mean squared error: shows errors more clearly
sqrt(mean((actual - predictions)^2, na.rm = TRUE))



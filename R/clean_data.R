# Source: https://github.com/rfordatascience/tidytuesday/tree/main/data/2026/2026-10-20

# Open the .Rproj file before running this script.
# Load data
majors <- read.csv("data/raw/ai_salary_majors.csv",
                   colClasses = c(cip4 = "character"), na.strings = c("", "NA"))

# Remove extra spaces and check duplicates
text_columns <- vapply(majors, is.character, logical(1))
majors[text_columns] <- lapply(majors[text_columns], trimws)
duplicate_rows <- sum(duplicated(majors))
majors <- unique(majors)
stopifnot(!anyDuplicated(majors$cip4), all(grepl("^[0-9]{4}$", majors$cip4)))

# Check missing values; keep unavailable salaries as NA
missing_values <- colSums(is.na(majors))

# Check outliers using the 1.5-IQR rule
is_outlier <- function(x) {
  q <- quantile(x, c(0.25, 0.75), na.rm = TRUE)
  spread <- IQR(x, na.rm = TRUE)
  !is.na(x) & (x < q[1] - 1.5 * spread | x > q[2] + 1.5 * spread)
}
starting_salary_outliers <- majors[is_outlier(majors$median_starting_salary),
                                   c("cip4", "field_of_study", "median_starting_salary")]
four_year_salary_outliers <- majors[is_outlier(majors$median_salary_4yr),
                                    c("cip4", "field_of_study", "median_salary_4yr")]
ai_exposure_outliers <- majors[is_outlier(majors$ai_exposure),
                               c("cip4", "field_of_study", "ai_exposure")]

# Save data and show results
write.csv(majors, "data/processed/ai_salary_majors_clean.csv",
          row.names = FALSE, na = "")
print(missing_values)
print(starting_salary_outliers)
print(c(majors = nrow(majors), variables = ncol(majors), duplicates = duplicate_rows,
        starting_salary_outliers = nrow(starting_salary_outliers),
        four_year_salary_outliers = nrow(four_year_salary_outliers),
        ai_exposure_outliers = nrow(ai_exposure_outliers)))

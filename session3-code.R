# Session-3: Exploratory Data Analysis I

# Load required libraries
library(tidyverse)

# Read Bangladesh individual data
bd_indiv <- haven::read_dta("data/bd_individual.dta")

# Transform variables to factors
bd_indiv <- bd_indiv |> 
  mutate(division = as_factor(v024),
         residence = as_factor(v025))

# Create age categories
bd_indiv <- bd_indiv |> 
  mutate(age_cat = case_when(
    v012 < 20 ~ "0-19",
    v012 < 25 ~ "20-24",
    v012 < 30 ~ "25-29",
    v012 < 35 ~ "30-34",
    v012 < 40 ~ "35-39",
    v012 < 45 ~ "40-44",
    v012 < 50 ~ "45-49"
  ))

# Show first few observations
bd_indiv |> 
  select(1:6) |> 
  slice(1:6)

# Frequency distribution of age categories
bd_indiv |> 
  count(age_cat) |> 
  mutate(prop = n / sum(n))

# Convert additional categorical variables to factors
bd_indiv <- bd_indiv |> 
  mutate(v106 = as_factor(v106),
         v024 = as_factor(v024),
         v025 = as_factor(v025))

# Frequency distribution of education level
bd_indiv |>
  count(v106) |> 
  mutate(prop = 100 * n / sum(n))

# Two-way contingency table
bd_indiv |>
  count(v106, v025) |> 
  pivot_wider(names_from = v025, values_from = n)

# Measures of location
mean(bd_indiv$v012)
median(bd_indiv$v012)
summary(bd_indiv$v012)

# Using tidyverse for summary statistics
bd_indiv |> 
  summarise(mean = mean(v012),
            median = median(v012))

# Mode calculation
bd_indiv |>
  count(v012) |>
  arrange(desc(n)) |>
  slice(1:3)

# Mode for categorical variable
bd_indiv |> 
  count(division) |> 
  arrange(desc(n))

# Example data for spread measures
bwt <- c(3265, 3260, 3245, 3484, 4146, 3323, 3649, 3200, 
         3031, 2069, 2581, 2841, 3609, 2838, 3541, 2759, 
         3248, 3314, 3101, 2834)
sbwt <- sort(bwt)

# Measures of spread
bd_indiv |> 
  summarise(
    var = var(v012),
    sd = sd(v012),
    range = max(v012) - min(v012)
  )

# Quantiles
bd_indiv |> 
  summarise(
    Q1 = quantile(v012, .25),
    Q2 = quantile(v012, .50),
    Q3 = quantile(v012, .75),
    IQR = Q3 - Q1
  )

# Coefficient of variation example
bd_indiv |> 
  summarise(
    CV = sd(v012) / mean(v012)
  )

# Bonus: {gtsummary} package for summary tables
bd_indiv |>
  select(v012, v106, v024, v025) |>
  gtsummary::tbl_summary()

# Explore {gtsummary}, you will be surprised!
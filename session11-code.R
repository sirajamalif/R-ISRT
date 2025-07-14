#### Question 1 ####

# Load libraries
library(tidyverse) # For data manipulation and visualization
library(haven) # For reading SPSS files

## Read the data file
mothers <- read_sav("data/mothers.sav")

View(mothers) # View the dataset
str(mothers) # Display structure of the dataset
glimpse(mothers) # Display a concise summary of the dataset
summary(mothers) # Display summary statistics of the dataset


## 1 (a). Use the respondent currently working (v714) to address the question that the
# percentage of working mother in Bangladesh is more than 20%.

# Create a table for variable v714
mothers |>
  count(v714)

# Perform a one-sample proportion test
prop.test(x = 271, n = 271 + 2434, p = 0.2, alternative = "greater")

## 1 (b)

# Display the structure of variable v190
mothers$v457

# Create a frequency table for v457
mothers |>
  count(v457)

# Recode into anemic
mothers <- mothers |>
  mutate(anemic = case_when(v457 == 4 ~ 0, 
                            .default = 1))

# (i). Test whether the distribution of anemic (anemic) children is same
#.                             in all regions (v101)

str(mothers$v101)

mothers |>
  count(anemic, v101) |>
  pivot_wider(names_from = v101, values_from = n)

chisq.test(mothers$anemic, mothers$v101)

# (ii). Test whether the distribution of anemic (anemic) children is same in all
# groups of socioeconomic status (wealth index) (v190).

# Display the structure of variable v190
str(mothers$v190)

# Create a contingency table for anemic and v190
mothers |>
  count(anemic, v190) |>
  pivot_wider(names_from = v190, values_from = n)

# Perform chi-square test for independence between anemic and v190
chisq.test(tab_anemic_v190)

# (iii). Test whether being an anemic (anemic) child and the type of place of residence (v102) is independent
# Display the structure of variable v102
str(mothers$v102)

# Create a contingency table for anemic and v102
mothers |>
  count(anemic, v102) |>
  pivot_wider(names_from = v102, values_from = n)

# Perform chi-square test for independence between anemic and v102
chisq.test(mothers$anemic, mothers$v102)

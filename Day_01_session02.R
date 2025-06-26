# Building a data Frame

serial <- 1:10
sex <- c("F", "M", "M", "F", "F", "F", "M", "M", "F", "M")
weight <- c(56.4,80.0,65.7,69.0,67.4,80.3,65.0,60.0,60.5,50.5)
height <- c(165,170,171,166,162,158,168,160,162,155)

# Convert the categorical variables to facotr type
sex = factor(sex,levels=c("M","F"))
# Then combine them using dataframe
mydat <- data.frame(serial,sex,weight,height)
str(mydat)

#Binding Columns
years.edu <- c(16,15,18,10,13,15,17,10,15,16)
mydat2 <- cbind(mydat, years.edu) # you can do the same using $ sign
names(mydat2)

#Binding Row
mydat <- rbind(mydat, c(11,"F",62.0,165,15))
tail(mydat)

# Tibble
library(tibble)
dt1 = as_tibble(mydat2)
dt1

# Read data
mydata <- read.csv("E:/Excel/iris.csv") # forward slash
head(mydata)  # not similar to pandas syntax

# dplyr
library(dplyr)

install.packages("palmerpenguins")

penguins <- palmerpenguins::penguins

# to perform any operation, 1st thing in the bracket should be the object created

# 1. Filter rows where species is exactly "Chinstrap"
filter(penguins, species == "Chinstrap")

# 2. Filter rows where species is "Chinstrap" AND island is "Biscoe"
filter(penguins, species == "Adelie", island == "Biscoe")

# 3. Filter rows where species is "Adelie" OR "Chinstrap"
filter(penguins, species == "Adelie" | species == "Chinstrap")

# 4. Filter rows where flipper length is greater than 200 mm
filter(penguins, flipper_length_mm > 200)

# 5. Filter rows where species is either "Adelie" or "Chinstrap" (using %in%)
filter(penguins, species %in% c("Adelie", "Chinstrap")) # Using the shortcut technique

# 6. Filter rows where bill length is not missing (remove NAs)
filter(penguins, !is.na(bill_length_mm))

# 7. Filter Gentoo penguins with body mass greater than 5000g
filter(penguins, species == "Gentoo" & body_mass_g > 5000)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# 1. Sort rows by body mass in ascending order
arrange(penguins, body_mass_g)

# 2. Sort rows by body mass in descending order
arrange(penguins, desc(body_mass_g))

# 3. Sort by species, then by body mass within each species
arrange(penguins, species, body_mass_g)

# 4. Sort by island (A → Z) and descending bill length
arrange(penguins, island, desc(bill_length_mm))

# 5. Sort rows, placing missing bill length values last
arrange(penguins, is.na(bill_length_mm), bill_length_mm)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------


# 1. Select specific columns by name
select(penguins, species, island, body_mass_g)

# 2. Drop a column using minus (-)
select(penguins, -year)     # Drop the 'year' column

# 3. Select columns by range (from species to bill_depth_mm)
select(penguins, species:bill_depth_mm)

# 4. Select columns that start with "bill"
select(penguins, starts_with("bill"))

# 5. Select columns that contain the word "length"
select(penguins, contains("length"))

# 6. Rename column while selecting (new_name = old_name)
select(penguins, species_type = species, mass = body_mass_g) # can also use rename()

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Combining multiple verbs using the pipe
penguins %>%
  select(species, island, body_mass_g) %>%     # Keep only selected columns
  filter(island == "Dream") %>%                # Filter only penguins from Dream island
  arrange(desc(body_mass_g))                   # Sort by body mass (largest first)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# 1. Store data frame with new column 'bill_ratio'
penguins_ratio <- mutate(penguins, bill_ratio = bill_length_mm / bill_depth_mm)
penguins_ratio

# 2. Store data frame with new column 'body_kg'
penguins_kg <- mutate(penguins, body_kg = body_mass_g / 1000)

# 3. Store data frame with 'body_kg' and 'is_heavy' columns
penguins_heavy <- mutate(penguins,
                         body_kg = body_mass_g / 1000,
                         is_heavy = body_mass_g > 5000)

# 4. Store data frame with new column 'size' using ifelse()
penguins_size_ifelse <- mutate(penguins,
                               size = ifelse(body_mass_g > 4500, "Big", "Small"))
penguins_size_ifelse

# 5. Store data frame with modified 'body_mass_g' (each value increased by 100)
penguins_mass_adjusted <- mutate(penguins,
                                 body_mass_g = body_mass_g + 100)

# 6. Store data frame with new 'size' category using case_when()
penguins_size_case <- mutate(penguins,
                             size = case_when(
                               body_mass_g < 3000 ~ "Light",
                               body_mass_g >= 3000 & body_mass_g < 5000 ~ "Medium",
                               body_mass_g >= 5000 ~ "Heavy"
                             ))

# Re-code with Mutate

# 1. Recode species names to shorter labels
penguins_species_short <- mutate(penguins,
                                 species = recode(species,
                                                  "Adelie" = "AD",
                                                  "Chinstrap" = "CH",
                                                  "Gentoo" = "GE"))
penguins_species_short 
# 📝 "Adelie" becomes "AD", "Chinstrap" → "CH", "Gentoo" → "GE"

# 2. Recode island names for readability
penguins_island_named <- mutate(penguins,
                                island = recode(island,
                                                "Torgersen" = "Torg",
                                                "Dream" = "Drm",
                                                "Biscoe" = "Bsc"))
# 📝 Shortens long island names to abbreviations

# 3. Recode sex column to use full words instead of abbreviations
penguins_sex_full <- mutate(penguins,
                            sex = recode(sex,
                                         "male" = "Male Penguin",
                                         "female" = "Female Penguin"))
# 📝 Expands "male"/"female" to full descriptive labels

# 4. Recode body mass categories using case labels
penguins_mass_label <- mutate(penguins,
                              mass_label = recode_factor(
                                cut(body_mass_g,
                                    breaks = c(0, 3500, 4500, Inf),
                                    labels = c("Light", "Medium", "Heavy")),
                                "Light" = "L",
                                "Medium" = "M",
                                "Heavy" = "H"))
# 📝 Assigns L/M/H labels based on body mass ranges

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------


penguins_mass_grouped <- mutate(penguins,
                                mass_group = case_when(
                                  body_mass_g < 3000 ~ "Light",
                                  body_mass_g >= 3000 & body_mass_g < 4500 ~ "Medium",
                                  body_mass_g >= 4500 ~ "Heavy"
                                )
)
# 📝 Categorizes penguins into Light, Medium, or Heavy based on body mass

penguins_region <- mutate(penguins,
                          region = case_when(
                            island == "Torgersen" ~ "North",
                            island == "Biscoe" ~ "West",
                            island == "Dream" ~ "East",
                            TRUE ~ "Unknown"
                          )
)
# 📝 Maps island names to broader regional labels

penguins_size_label <- mutate(penguins,
                              size_label = case_when(
                                species == "Gentoo" & body_mass_g > 5000 ~ "Big Gentoo",
                                species == "Adelie" & body_mass_g < 3500 ~ "Small Adelie",
                                TRUE ~ "Average Penguin"
                              )
)
# 📝 Combines conditions across species and mass to assign custom labels

penguins_sex_fixed <- mutate(penguins,
                             sex_label = case_when(
                               is.na(sex) ~ "Not recorded",
                               sex == "male" ~ "Male Penguin",
                               sex == "female" ~ "Female Penguin"
                             )
)
# 📝 Handles missing sex values and assigns human-readable labels

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# 1. Calculate overall average body mass (ignoring NAs)
penguins_avg_mass <- summarise(penguins,
                               avg_mass = mean(body_mass_g, na.rm = TRUE))
# 2. Calculate average, maximum, and total number of rows
penguins_summary <- summarise(penguins,
                              avg_mass = mean(body_mass_g, na.rm = TRUE),
                              max_mass = max(body_mass_g, na.rm = TRUE),
                              count = n())
# 3. Use summarise with `.by` argument (no need for group_by)
penguins_by_with_dotby <- summarise(penguins,
                                    avg_mass = mean(body_mass_g, na.rm = TRUE),
                                    count = n(),
                                    .by = species)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# 1. Count how many penguins belong to each species
penguin_species_count <- count(penguins, species)
# 📝 Gives number of rows per species

# 2. Count how many penguins for each combination of species and island
penguin_species_island_count <- count(penguins, species, island)
# 📝 Gives counts by species and island pairs

# 3. Count and sort in descending order of frequency
penguin_sorted_count <- count(penguins, island, sort = TRUE)
# 📝 Sorts by count, most frequent island first

# 4. Rename count column using `name` argument
penguin_custom_named <- count(penguins, species, name = "total")
# 📝 Names the count column as 'total' instead of 'n'

# 5. Count unique combinations of sex and species, removing NA rows
penguin_sex_species_count <- penguins %>%
  filter(!is.na(sex)) %>%
  count(sex, species)
# 📝 Counts how many male/female penguins per species (ignoring NAs)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# 1. Use slice() to select rows 1 to 5
penguins_slice_rows <- slice(penguins, 1:5)
# 📝 Select rows 1 to 5

# 2. Use slice_head() to get the first 3 rows
penguins_head <- slice_head(penguins, n = 3)
# 📝 Select the first 3 rows

# 3. Use slice_tail() to get the last 3 rows
penguins_tail <- slice_tail(penguins, n = 3)
# 📝 Select the last 3 rows

# 4. Use slice_min() to get 5 rows with the smallest body_mass_g
penguins_lightest <- slice_min(penguins, body_mass_g, n = 5, with_ties = FALSE)
# 📝 Select 5 lightest penguins (lowest body mass)

# 5. Use slice_max() to get 5 rows with the largest body_mass_g
penguins_heaviest <- slice_max(penguins, body_mass_g, n = 5, with_ties = FALSE)
# 📝 Select 5 heaviest penguins (highest body mass)

# 6. Use slice_sample() to get 5 random rows
penguins_random <- slice_sample(penguins, n = 5)
# 📝 Randomly select 5 rows from the dataset

# 7. Use slice_sample() to get 10% random sample
penguins_random_10pct <- slice_sample(penguins, prop = 0.1)
# 📝 Randomly select 10% of the rows

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Exercise 2.1:

penguins_2.1_1 <- filter(penguins, species == "Gentoo", bill_depth_mm >= 15.5)

penguins_2.1_2 <- filter(penguins, sex == "male", island %in% c("Dream", "Biscoe"))

penguins_2.1_3 <- filter(penguins, species == "Gentoo" | body_mass_g > 4500)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Exercise 2.2:

penguins_2.2_1 <- select(penguins, body_mass_g)

penguins_2.2_2 <- select(penguins, bill_length_mm:body_mass_g, year)

penguins_2.2_3 <- select(penguins, -island)

penguins_2.2_4 <- select(penguins, species, ends_with("mm"))

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Exercise 2.3:

penguins_2.3_1 <- penguins %>%
  filter(sex == "female", island == "Dream") %>%
  select(species, starts_with("bill"))

penguins_2.3_2 <- mutate(penguins,
                         flipper_m = flipper_length_mm / 1000)

penguins_2.3_3 <- penguins %>%
  filter(species == "Chinstrap") %>%
  group_by(island) %>%
  summarise(
    flip_max = max(flipper_length_mm, na.rm = TRUE),
    flip_min = min(flipper_length_mm, na.rm = TRUE)
  )

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Tidying the data using tidyr
library(tidyr)

# Sample data: Wide format
df_wide <- data.frame(
  name = c("A", "B"),
  math = c(80, 90),
  science = c(85, 88)
)

# Convert to long format
df_long <- pivot_longer(df_wide, 
                        cols = c(math, science),
                        names_to = "subject",
                        values_to = "score")

# Use the long data from previous example
df_wide_again <- pivot_wider(df_long,
                             names_from = subject,
                             values_from = score)

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# Exercise 2.4:

# Loading the billboard dataset
billboard <- tidyr::billboard

# Using pivot_longer to tidy the dataset
billboard_long <- pivot_longer(billboard,
                               cols = starts_with("wk"),
                               names_to = "week",
                               values_to = "rank",
                               values_drop_na = TRUE)
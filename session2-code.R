# Session-2: Data Manipulation

# Load required libraries
library(tidyverse)
library(palmerpenguins)

# Building data frames
serial <- 1:10
sex <- c("F", "M", "M", "F", "F", "F", "M", "M", "F", "M")
weight <- c(56.4, 80.0, 65.7, 69.0, 67.4, 80.3, 65.0, 60.0, 60.5, 50.5)
height <- c(165, 170, 171, 166, 162, 158, 168, 160, 162, 155)

# Convert to factor
sex = factor(sex, levels = c("M","F"))

# Create data frame
mydat <- data.frame(serial, sex, weight, height)
str(mydat)

# Adding columns
years.edu <- c(16, 15, 18, 10, 13, 15, 17, 10, 15, 16)

# Way 1
mydat2 <- cbind(mydat, years.edu)
names(mydat2)

# Way 2
mydat$years.edu <- c(16, 15, 18, 10, 13, 15, 17, 10, 15, 16)
names(mydat)

# Adding rows
mydat <- rbind(mydat, c(11, "F", 62.0, 165, 15))
tail(mydat)

# Saving data
save(list = "mydat", file = "mydat.Rdata")

# Tibbles
dt1 = as_tibble(mydat)
dt1

# Importing data examples
library(tidyverse)
data1 <- read_csv("data/prawnGR.csv")
data2 <- read_excel("data/whaledata.xls")
data3 <- read.table("data/children.txt", header = TRUE)
data4 <- read_sav("data/hw_dat.sav")
data5 <- haven::read_dta("data/hw_dat.dta")
data6 <- haven::read_sas("data/airline.sas7bdat")
load("data/TemoraBR.RData")

# Exporting data examples
save(mtcars, TemoraBR, file = "two_data_sets.RData")
readr::write_csv(mydat, path= "data/mydat.csv")

# Load penguins data
# install.packages("palmerpenguins") # install the package once if not installed
penguins <- palmerpenguins::penguins

# Filter examples
penguins |> 
  filter(species == "Chinstrap")

penguins |>
  filter(species == "Chinstrap", bill_length_mm > 52)

penguins |>
  filter(species == "Chinstrap" | species == "Gentoo") 

penguins |>
  filter(species %in% c("Chinstrap", "Gentoo")) 

# Arrange examples
penguins |> 
  arrange(bill_length_mm)

penguins |>
  arrange(desc(bill_length_mm))

penguins |> 
  arrange(desc(bill_length_mm), 
          desc(bill_depth_mm))

# Select examples
penguins |>
  select(year, island, species)

names(penguins)

penguins |>
  select(species:body_mass_g)

penguins |>
  select(species:bill_depth_mm, -island)

penguins |>
  select(starts_with("bill"))

# Rename example
penguins |>
  rename(location = island)

# Pipe example
penguins |>
  filter(species == "Adelie" & sex == "female") |>
  arrange(desc(bill_length_mm))

# Mutate examples
penguins |>
  mutate(body_mass_kg = body_mass_g / 1000)

penguins |> 
  mutate(body_mass_kg = body_mass_g / 1000,
         .before = 1)

# Recode with mutate
penguins |>
  mutate(flip_size = case_when(
    flipper_length_mm > 210 ~ "large",
    flipper_length_mm <= 210 ~ "short"
  ))

penguins |>
  mutate(
    mass_c = case_when(
      body_mass_g > 4500 ~ "large",
      body_mass_g > 3000 & body_mass_g <= 4500 ~ "medium",
      .default = "small"),
    .before = 1
  )

# Summarise examples
penguins |>
  summarise(
    mean_mass = mean(body_mass_g, na.rm = T),
    sd_mass = sd(body_mass_g, na.rm = T)
  )

penguins |>
  summarise(
    mean_mass = mean(body_mass_g, na.rm = T),
    sd_mass = sd(body_mass_g, na.rm = T),
    .by = species
  )

# Tidyr examples
marks <- readxl::read_excel("data/marks.xlsx")
head(marks)

# Pivot longer example (commented out as file may not exist)
marks_long <- marks |>
  pivot_longer(!name, names_to = "year", values_to = "GPA")
marks_long

# Pivot wider example (commented out)
marks_wide <- marks_long |>
  pivot_wider(names_from = "year", values_from = "GPA")
marks_wide



# Answer to Exercise 2.4
billboard = tidyr::billboard
billboard |> 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank"
  )

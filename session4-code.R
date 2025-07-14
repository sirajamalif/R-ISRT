# Session-4: Exploratory Data Analysis II

# Load required libraries
library(tidyverse)

# Show first few observations of mtcars
as_tibble(mtcars) %>% 
  print(n = 3, width = 50)

# Base R plotting examples
plot(x = mtcars$wt, y = mtcars$mpg)

plot(mtcars$mpg ~ mtcars$wt,
     col = "blue", pch = 20, xlab = "mpg", 
     ylab = "weight")

hist(mtcars$mpg)

boxplot(mpg ~ cyl, data = mtcars)

tab1 <- table(mtcars$cyl)
tab1

barplot(table(mtcars$cyl))

# ggplot2 examples
# Scatter plot
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg))

# Scatter plot with color
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg), col = "blue")

# Scatter plot with color mapped to gear
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg, col = gear))

# Scatter plot with color mapped to factor(gear)
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg, col = factor(gear)))

# Scatter plot with shape mapped to gear
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg, shape = factor(gear)))

# Scatter plot with size mapped to gear
ggplot(data = mtcars) +
  geom_point(aes(x = wt, y = mpg, size = gear))

# Scatter plot with smooth line
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() +
  geom_smooth()

# Scatter plot with smooth lines by gear
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(gear))) + 
  geom_point() +
  geom_smooth()

# Histogram examples
ggplot(data = mtcars) +
  geom_histogram(aes(x = mpg))

ggplot(data = mtcars) +
  geom_histogram(aes(x = mpg, y = after_stat(density)))

ggplot(data = mtcars) +
  geom_histogram(
    aes(x = mpg, y = after_stat(density)), bins = 5)

ggplot(data = mtcars, aes(y = after_stat(density))) +
  geom_histogram(aes(x = mpg), bins = 5) +
  geom_density(aes(x = mpg), col = "red")

# Boxplot examples
ggplot(data = mtcars) +
  geom_boxplot(aes(x = factor(gear), y = mpg))

ggplot(data = mtcars) +
  geom_boxplot(aes(x = factor(gear), y = mpg)) +
  coord_flip()

# Faceting examples
ggplot(mtcars) +
  geom_point(aes(wt, mpg)) + 
  facet_wrap(~ gear)

ggplot(mtcars) +
  geom_point(aes(wt, mpg)) + 
  facet_grid(am ~ vs)

# Prepare mtcars data for bar charts
mtcars_n <- mtcars %>%
  as_tibble() %>%
  mutate(gear_f = factor(gear),
         cyl_f = factor(cyl),
         am_f = factor(am, labels = c("automatic", "manual")),
         vs_f = factor(vs, labels = c("V-shaped", "Straight")))

# Bar chart examples
ggplot(mtcars_n) + 
  geom_bar(aes(x = cyl_f))

mtcars_n %>% 
  group_by(cyl_f) %>%
  count(gear_f) %>%
  mutate(p = n / sum(n))

ggplot(mtcars_n) + 
  geom_bar(aes(x = cyl_f, fill = gear_f))

ggplot(mtcars_n) + 
  geom_bar(aes(x = cyl_f, fill = gear_f), position = "fill")

ggplot(mtcars_n) + 
  geom_bar(aes(x = cyl_f, fill = gear_f), position = "dodge")

# Theme and label examples
p1 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  labs(x = "weight", y = "miles per gallon", 
       title = "Fuel economy declines as weight increases")

p1

p1 + theme(plot.title = element_text(size = rel(2)))

ggplot(mtcars_n) +
  geom_point(aes(disp, mpg, color = am_f, shape = vs_f))  +
  labs(color = "Transmission", shape = "Engine",
       x = "displacement", y = "mile per gallon")

# Theme examples
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  theme_gray()

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  theme_bw()


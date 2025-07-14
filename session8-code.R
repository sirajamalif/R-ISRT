# Session 8: Basic Machine Learning Techniques (Correlation and Simple Linear Regression)

# Load required libraries
library(tidyverse)
library(gapminder)
library(palmerpenguins)
library(gt)
library(knitr)
library(kableExtra)
######

as_tibble(mtcars) %>% 
  print(n = 3, width = 50)

# Scatter plot for mtcars data
library(tidyverse)
ggplot(mtcars, aes(x = mpg, y = wt)) +
  geom_point(size = 1, col = "red")

# Scatter plot for gapminder data
library(gapminder)
p2 <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) # just initializes
p2 <- p2 + scale_x_log10() # taking log transformation
p2 + geom_point() + xlab("Per Capita GDP") + ylab("Log Life Expectency")

# Correlation examples
cor(mtcars$mpg, mtcars$wt)
cor(gapminder$gdpPercap, log(gapminder$lifeExp))


# Correlation test
cor.test(mtcars$mpg, mtcars$wt)

# Correlation matrix
Quant_mtcars <- mtcars[c("mpg", "cyl", "disp", "wt")]
round(cor(Quant_mtcars), digit = 3) # with 3 decimal points

# Scatter plot matrix
pairs(~ mpg + cyl + disp + wt,
  data = mtcars,
  main = "Simple Scatterplot Matrix"
)

# Advertising data analysis
library(tidyverse) # data manipulation and visualization
library(modelr) # provides easy pipeline modeling
library(broom) # tidy up model outputs

advertising <- read_csv("data/advertising.csv")
advertising

str(advertising)

#correlation exist between continuous and categorical variable with 2 levels
t.test(advertising$sales~advertising$region)

#correlation exist between continuous and categorical variable with more than 2 levels
#m1<-aov(advertising$sales~advertising$region)
#summary(m1)


# Linear model
model1 <- lm(sales ~ TV, data = advertising)
broom::tidy(model1)

#or 
summary(model1)

#broom::tidy(model1)[2]
#broom::tidy(model1)[1,2]

names(model1)

#model1$fitted.values

# Predictions and residuals
predict(model1)[1]
resid(model1)[1]
predict(model1, data.frame(TV = 100))

# Linearity assessment
ggplot(advertising, aes(TV, sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  ylab("Sales")

plot(model1)

# Residual analysis with ggplot2
model1_results <- augment(model1, advertising)

# Residuals vs Fitted
ggplot(model1_results, aes(.fitted, .resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = FALSE, col = "red") +
  ggtitle("Residuals vs Fitted")

# QQ Plot
qqnorm(model1_results$.resid)
qqline(model1_results$.resid)

# Standardized residuals plots
p1 <- ggplot(model1_results, aes(.fitted, .std.resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = FALSE) +
  ggtitle("Standardized Residuals vs Fitted")
p2 <- ggplot(model1_results, aes(.fitted, sqrt(.std.resid))) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = FALSE) +
  ggtitle("Scale-Location")
gridExtra::grid.arrange(p1, p2, nrow = 1)

#Residuals vs leverage
ggplot(model1_results, aes(.hat, .std.resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = FALSE, col = "red") +
  ggtitle("Residuals vs Leverage")

# Model summary
tidy(model1)
confint(model1)

#qt(0.975, df=198)


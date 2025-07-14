library(tidyverse) # data manipulation
library(modelr) # pipeline modeling functions
library(broom) # tidy up model outputs


advertising <- read_csv("data/advertising.csv")


advertising


# To run simple linear regression model
model1 <- lm(sales ~ TV, data = advertising)

# To run multiple linear regression model
model2 <- lm(sales ~ TV + radio + newspaper,
  data = advertising
)


tidy(model2)



confint(model2)


list(model1 = broom::glance(model1)[1:5])
list(model2 = broom::glance(model2)[1:5])


# add model diagnostics to our training data
model1_results <- augment(model1, advertising)

model1_results <- model1_results %>%
  mutate(Model = "Model 1")

model2_results <- augment(model2, advertising) %>%
  mutate(Model = "Model 2") %>%
  rbind(model1_results)

ggplot(model2_results, aes(.fitted, .resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~Model) +
  ggtitle("Residuals vs Fitted")


par(mfrow = c(1, 2))
# Left: model 1
qqnorm(model1_results$.resid, main = "Model1: Normal Q-Q plot")
qqline(model1_results$.resid)
# Right: model 2
qqnorm(model2_results$.resid, main = "Model2: Normal Q-Q plot")
qqline(model2_results$.resid)



advertising <- advertising |>
  mutate(region = as.factor(region))

mod <- lm(sales ~ region, data = advertising)
tidy(mod)


# option A
model3 <- lm(sales ~ TV + radio + TV * radio,
  data = advertising
)
# option B
model3 <- lm(sales ~ TV * radio, data = advertising)


model3 <- lm(sales ~ TV * radio, data = advertising)
tidy(model3)

######################### Tree############

# Packages
library(rsample) # data splitting
library(dplyr) # data wrangling
library(rpart) # performing regression trees
library(rpart.plot) # plotting regression trees

# Load data (remove row numbers included as X1 variable)
advertising <- read_csv("data/advertising.csv")

# To generate two datasets-training (60% subjects)
# and test (40% subjects):

set.seed(123)
sample <- sample(c(TRUE, FALSE), nrow(advertising), replace = T, prob = c(0.6, 0.4))
train <- advertising[sample, ]
test <- advertising[!sample, ]

m1 <- rpart(
  formula = sales ~ ., data = train,
  method = "anova"
)
m1

rpart.plot(m1)

plotcp(m1)

m1$cptable

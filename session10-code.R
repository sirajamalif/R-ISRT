library(tidyverse) # data manipulation and visualization
library(modelr) # provides easy pipeline modeling functions
library(broom) # helps to tidy up model outputs
library(ISLR) # helps to run machine learning methods
library(caret) # helps to know who are the important 					# variables

# Load data
(default <- as_tibble(ISLR::Default))
head(default) # to see the first 6 observations



# To generate two datasets-training (60% subjects)
# and test (40% subjects):

set.seed(123)
sample <- sample(c(TRUE, FALSE), nrow(default), replace = T, prob = c(0.6, 0.4))
train <- default[sample, ]
test <- default[!sample, ]


model1 <- glm(default ~ balance, family = "binomial", data = train)


default %>%
  mutate(prob = ifelse(default == "Yes", 1, 0)) %>%
  ggplot(aes(balance, prob)) +
  geom_point(alpha = .15) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  ggtitle("Logistic regression model fit") +
  xlab("Balance") +
  ylab("Probability of Default")



summary(model1)

exp(coef(model1))

confint(model1)

predict(model1, data.frame(balance = c(1000, 2000)), type = "response")

model2 <- glm(default ~ student, family = "binomial", data = train)
tidy(model2)

predict(model2, data.frame(student = factor(c("Yes", "No"))), type = "response")


model3 <- glm(default ~ balance + income + student,
  family = "binomial",
  data = train
)

tidy(model3)


caret::varImp(model3)



new.df <- tibble(balance = 1500, income = 40, student = c("Yes", "No"))
predict(model3, new.df, type = "response")


anova(model1, model3, test = "Chisq")


model1_data <- augment(model1) %>% mutate(index = 1:n())

ggplot(model1_data, aes(index, .std.resid, color = default)) +
  geom_point(alpha = .5) +
  geom_ref_line(h = 3)


model1_data %>% filter(abs(.std.resid) > 3)

plot(model1, which = 4, id.n = 5)

model1_data %>% top_n(5, .cooksd)


test.predicted.m1 <- predict(model1, newdata = test, type = "response")
test.predicted.m2 <- predict(model2, newdata = test, type = "response")
test.predicted.m3 <- predict(model3, newdata = test, type = "response")


list(
  model1 = table(test$default, test.predicted.m1 > 0.5) %>% prop.table() %>% round(3),
  model2 = table(test$default, test.predicted.m2 > 0.5) %>% prop.table() %>% round(3),
  model3 = table(test$default, test.predicted.m3 > 0.5) %>% prop.table() %>% round(3)
)


test %>%
  mutate(
    m1.pred = ifelse(test.predicted.m1 > 0.5, "Yes", "No"),
    m2.pred = ifelse(test.predicted.m2 > 0.5, "Yes", "No"),
    m3.pred = ifelse(test.predicted.m3 > 0.5, "Yes", "No")
  ) %>%
  summarise(
    m1.error = mean(default != m1.pred),
    m2.error = mean(default != m2.pred),
    m3.error = mean(default != m3.pred)
  )


table(test$default, test.predicted.m1 > 0.5)


library(ROCR)

par(mfrow = c(1, 2))

prediction(test.predicted.m1, test$default) %>%
  performance(measure = "tpr", x.measure = "fpr") %>%
  plot()

prediction(test.predicted.m2, test$default) %>%
  performance(measure = "tpr", x.measure = "fpr") %>%
  plot()


prediction(test.predicted.m1, test$default) %>%
  performance(measure = "auc") %>%
  .@y.values


prediction(test.predicted.m2, test$default) %>%
  performance(measure = "auc") %>%
  .@y.values

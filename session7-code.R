# Session 7: Statistical Inference II

# Load required libraries
library(tidyverse)
library(MASS)

# Load birthwt data
data(birthwt)

# One-sample t-test
t.test(birthwt$bwt, mu = 2500, alternative = "two.sided")

# Alternative one-sample t-tests
t.test(birthwt$bwt, mu = 2500, alternative = "less")
t.test(birthwt$bwt, mu = 2500, alternative = "greater")

# Two independent samples t-test
# First test for equal variances
var.test(bwt ~ smoke, data = birthwt, alternative = "two.sided")

# Perform t-test assuming equal variances
t.test(bwt ~ smoke, alternative = "greater",
       var.equal = TRUE, data = birthwt)

# One-way ANOVA
# First test for equal variances
bartlett.test(bwt ~ factor(race), data = birthwt)

# Perform ANOVA
result <- aov(bwt ~ factor(race), data = birthwt)
summary(result)

# Paired-samples t-test
# Load diet data
diet <- read_dta("data/diet.dta")
d <- diet$sc_before - diet$sc_after

# Visual check for normality
boxplot(d)

# Perform paired t-test
t.test(diet$sc_before, diet$sc_after, alternative = "greater",
       mu = 0, paired = TRUE)

# Test for a single proportion
table(birthwt$low)
prop.test(59, 189, p = 0.4, alternative = "two.sided")

# Chi-square test of independence
x <- chisq.test(birthwt$low, birthwt$smoke)
x
x$expected

# Chi-square goodness of fit test
table(birthwt$race)
ofreq <- c(96, 26, 67)
chisq.test(x = ofreq, p = c(0.33, 0.33, 0.33),
           rescale.p = TRUE)
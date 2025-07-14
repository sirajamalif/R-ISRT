# Session-1: Introduction to R

# Basic commands
print("Hello World!")

# Arithmetic operations
6+3
(59 + 73 + 2) / 3
10^(3+1)

# Creating objects/variables
my_obj <- 52
my_obj2 <- "R is fun"
my_obj2 <- 1024
my_obj3 <- my_obj + my_obj2
my_obj3

# Error examples (commented out)
char_obj <- "hello"
char_obj2 <- "world!"
char_obj3 <- char_obj + char_obj2
# 
my_obj <- 52
my_obj4 <- my_obj + no_obj

# Using brackets
((3 + 12)/3 + 8)
{10 + 2}+ 5
# [2 + 7]/3  # This would cause an error

# Mathematical functions
sqrt(25)
log(27)
logb(27, base = 3.5)
abs(-9)
x <- sqrt(2.5)
exp((x*2)^(1/3))

# Useful functions
round(3.567, digits=2)
floor(3.567)
ceiling(3.567)
pi

# Spacing examples
(1+2)     ^     3
( 1+  2)    ^ 3
# 3   .14  # This would cause an error

# Commenting example
# Calculating BMI
weight <- 70 # This is in kg
height <- 1.7 # This is in meter
bmi <- weight / height ^ 2
bmi

# Data types examples
x <- 8.1456
typeof(x)

y <- 4
typeof(y)

i1 <- 7L
typeof(i1)

as.integer(3.1416)

# Logical examples
10 < 6
logic1 <- TRUE
typeof(logic1)

# Character example
mychar <- "R makes data easy"
mychar
typeof(mychar)
is.character(mychar)

# Vectors
x <- c(10, 5, 3, 6)
x
y <- c("boy", "girl", "girl")
y

# Vector functions
my_vec <- c(2, 3, 1, 6, 4, 3, 3, 7)
mean(my_vec)
sd(my_vec)
length(my_vec)

# Sequence generation
index <- 1:12
index
index2 = 10:-2
index2

seq(from = 1, to = 5, by = 0.5)
seq(from = 1, to = 5, length.out = 8)

# Repeating vectors
rep(1:4, 4)
rep("boy", times = 3)
rep(1:4, 1:4)
rep(c("boy", "girl"), c(3, 2))

# Combining vectors
x <- c(10, 15)
c(1:5, x, 100, x)

# Vector arithmetic
x+3
x/3

x <- c(10, 15, 20)
y <- c(1, 2, 3)
x*y

# More vector functions
x <- c(10, 8, 9, 16, 9, 8, 16)
sort(x)
order(x)
table(x)
unique(x)

# Vector indexing
age <- c(11, 9, 8, 10, 5)
age
age[3]
age[c(2, 3, 5)]
age[-c(1, 3)]

# Modifying vectors
age[3] <- 66
age[1:3] <- c(23, 34, 56)

# Logical indexing
age[age >= 8]
age[age >= 8 & age <= 10]

# Matrices
mat1 <- matrix(data = 1:12, nrow = 3, ncol = 4)
mat1

# Alternative matrix creation
rbind(1:3, 11:13, 33:35)
cbind(letters[1:2], c("k", "m"), letters[18:19])

# Matrix with names
my_mat <- matrix(1:16, nrow = 4, byrow = TRUE)
rownames(my_mat) <- c("A", "B", "C", "D")
colnames(my_mat) <- c("a", "b", "c", "d")
my_mat

# Matrix subsetting
mat <- matrix(1:9, nrow = 3)
mat
mat[1, 3]
mat[1:2, 3]
mat[ , 2:3]
mat[-1, ]

# Modifying matrices
mat[1,3] <- 55
mat[,1] <- c(101:103)

# Lists
x1 <- 1:5
x2 <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
li1 = list(x1, x2)
li1

# Adding to lists
li1$text <- "Hello"
li1

# Factors
fac = factor(x = c(1, 2, 1, 1, 2, 1, 2), levels = c(1, 2),
             labels = c("Male", "Female"))
fac

x = c("Male", "Female", "Male", "Male", "Female", "Male", "Female")
fac1 = factor(x, levels = c("Male", "Female"))
fac1
fac2 = factor(x)
fac2

# Data frames
name <- c("Fahim", "Abir", "Monica")
sex <- factor(c("Male", "Male", "Female"), 
              levels = c("Male", "Female"))
country <- c("BD", "IN", "PK")
age <- c(22, 25, 35)

df <- data.frame(name, sex, country, age)
df

# More complex data frame
number <- 1:8
diet <- c("Poor", "Poor", "Good", "Good", "Poor",
          "Good", "Poor", "Good")
sex <- c("M", "F", "M", "F", "F", "F", "M", "M")
weight <- c(156, 180, 167, 190, 177, 183, 154, 160)
morph <- c("Winged", "Winged", "Wingless", "Intermediate", 
           "Winged", "Intermediate", "Winged", "Wingless")

# Converting to factors
diet = factor(diet, levels = c("Poor", "Good"))
sex = factor(sex, levels=c("M","F"), labels=c("Male","Female"))
morph = factor(morph)

mydat = data.frame(number, diet, sex, weight, morph)
str(mydat)


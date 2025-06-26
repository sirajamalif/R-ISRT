print("Hello World!")

3+4
5/9
3**2

x = 5
y = 4
z = x*y
print(z)

numbers = c(1,2,3,4,4,5)
print(numbers)
numbers[5]

sum(numbers)
mean(numbers)
length(numbers)

# Conditional Statements in R
x <- 11
if (x==11){
  print("True")
} else{
  print("False")
}

# Loops in R
for (i in 1:5){
  print(i)
}

while (x>0){
  print(x)
  x=x-1
}

# Common Mathematical Functions in R

sqrt(25)
abs(-5)
log(10) # Natural Log base-e
log10(50) # Log base 10
exp(1) # e^1
round(3.1415169,2)
ceiling(3.2)
floor(3.8)

mean(c(1,2,3,4,5))
median(c(1,2,3,4,5))
sd(c(1,2,3,4,5))
var(c(1,2,3,4,5))
sum(c(1,2,3,4,5))
min(c(1,2,3,4,5))
max(c(1,2,3,4,5))
range(c(1,10,2))
length(c(2,3,4,5))

sin(pi/2)
cos(0)
tan(pi/4)
asin(1) # inverse sin
acos(1)
atan(1)

# Exercise 1.1

5**2
(8+22)*3
(8/2.5)/3

# Exercise 1.2

x1 <- 71
x2 <- 101+36
x3 <- x1 * x2
x4 <- (x3-1)**(1/4)
typeof(x4)

# Generating sequence of numbers
5:-4
seq(from=1,to=5,by=0.5)
seq(from=1,to=5,length.out=8)

# Repeating Vectors

rep(1:4,4)

# Exercise 1.3

seq(from=1,to=10,by=1)
c(1,2,3,4,5,6,7,8,9,10)

seq(from=2.1,to=8.1,by=2)
c(2.1,4.1,6.1,8.1)

c(0,5,10,15)
seq(from=0,to=15,by=5)
seq(from=0,to=15,length.out=4)

rep(1:4, each = 2) # repeats each number 2 times
rep(1:4,1:4)
seq(from = -0.5, to = 1, by = 0.25)

# Combining Vectors

x <- c(10,15)
c(1:5, x,100,x)
x+3
x/3

# Arithmetic Operations can be done among 2 vectors

x <- c(10,15,20)
y <- c(1,2,3)
x*y

# Some Vector functions

x <- c(11, 2, 31, 4, 5,1,2,3) 

length(x)       # number of elements in the vector
sum(x)          # sum of all elements
mean(x)         # average value
min(x)          # smallest value
max(x)          # largest value
sort(x)         # sort in ascending order
rev(x)          # reverse the vector
unique(x)       # remove duplicates (if any)
any(x > 3)      # check if any element is greater than 3
all(x > 0)      # check if all elements are greater than 0
which(x == 3)   # returns index/position of value 3
x[x > 2]        # filter elements greater than 2
append(x, 6)    # add 6 to the end of vector
c(x, 6, 7)      # concatenate more elements to x
rep(1:2, times=3)    # repeat 1,2 three times → 1 2 1 2 1 2
seq(1, 10, by=2)     # generate sequence: 1 3 5 7 9

x <- c("apple", "banana", "apple", "orange", "banana", "apple")
table(x)   # count how many times each fruit appears

df <- data.frame(name = c("Anna", "John", "Paul"),
                 age = c(22, 19, 20))

df[order(df$age), ]   # sort rows by age ascending

# Summary statistics on vectors

x <- c(10, 20, 30, 40, 50)
summary(x)

# Indexing vectors with []

x <- c(1, 2, 3, 4)
x[2]          # returns the 2nd element → 2
x[1:3]        # first 3 elements → 1 2 3
x[c(2, 4)]    # 2nd and 4th elements → 2 4
x[-1]         # all except the 1st → 2 3 4
x[x > 2]      # elements greater than 2 → 3 4

x <- c(1, 2, 3, 4)
x[2] <- 99    # Replace 2nd element with 99
x
x[c(1, 3)] <- c(111, 333)   # Replace 1st and 3rd elements
x

x <- c(10, 20, 30, 40, 50)
x[x > 25] <- 999    # Replace all values greater than 25 with 999
x
x <- c(1, 2, 3, 2, 4)
x[x == 2] <- 99    # Replace all 2s with 99
x
x <- c(1,2,3,4,5,6,7,8,9)
x[x %% 2 == 0] <- 0   # Replace all even numbers with 0
x

# Matrix

m <- matrix(1:12, nrow = 3, ncol = 4)
print(m)

m <- matrix(1:6, nrow = 2, byrow = TRUE) # Creating Row-wise matrix
m

m <- matrix(1:12, nrow = 3, ncol = 4)
m[1, 2]    # Element in 1st row, 2nd column
m[ ,2]     # Entire 2nd column
m[1, ]     # Entire 1st row

m <- matrix(1:12, nrow = 3, ncol = 4)
m * 2          # Multiply each element by 2
m + m          # Element-wise addition
m %*% t(m)     # Matrix multiplication

m <- matrix(1:12, nrow = 3, ncol = 4)
rownames(m) <- c("Row1", "Row2","Row3")
colnames(m) <- c("A", "B", "C","D")
print(m)

m <- matrix(1:12, nrow = 3, ncol = 4)
dim(m)       # Returns c(nrow, ncol)
nrow(m)      # Number of rows
ncol(m)      # Number of columns

t(m)           # Transpose
diag(m)  # Extracts diagonal elements 
ncol(m)  # Returns the number of the columns
nrow(m)  # Returns the number of the rows
colSums(m) # Returns the sum of columns
rowSums(m) # Returns the sum of columns
solve(A,b) # Solve the system Ax=b
solve(x)  # Calculate the inverse
chol(x)  # Choleski decomposition

cbind(a, b)   # Combine vectors or matrices side by side (column-wise)
rbind(a, b)   # Combine vectors or matrices one below the other (row-wise)


# Exercise 1.4

x1 <- seq(from=1,to=7,by=2)
x1
x2 <- seq(from=2,to=8,by=2)
x2
x2-x1
x3 <- x1*x2
x3
x4 <- sqrt(x3)
x4

A <- matrix(c(
  2, 0, 7, 7,
  9, 4, 5, 8,
  0, 1, 5, 7,
  0, 4, 1, 4
), nrow = 4, byrow = FALSE)  
b <- c(-1, 6, 0, 9)
t(A) %*% b 
solve(A)  # Inverse matrix of A
solve(A,b)


# Factors

colors <- factor(c("red", "green", "blue", "red", "green"))
levels(colors)    # Shows: "blue" "green" "red" (alphabetical order by default)
colors <- factor(colors, levels = c("red", "green", "blue"))
summary(colors)
as.numeric(colors)   # Converts factor to internal numeric codes
as.character(colors)


# Data Frame


# Step 1: Create a data frame with categorical values
df_original <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "Diana"),
  Gender = c("Female", "Male", "Male", "Female"),
  Department = c("HR", "IT", "IT", "HR")
)

# View original data
print("Original Data Frame:")
print(df_original)

# Step 2: Convert categorical columns to factors
gender_factor <- factor(df_original$Gender)
dept_factor <- factor(df_original$Department)

# Step 3: Create a new data frame with the factorized values
df_factorized <- data.frame(
  Name = factor(df_original$Name),
  Gender = gender_factor,
  Department = dept_factor
)

# View new data frame with factors
print("Factorized Data Frame:")
print(df_factorized)


# Basic Line plot
x <- c(1,2,3,4)
y <- c(5,7,8,9)
plot(x,y,type="b")



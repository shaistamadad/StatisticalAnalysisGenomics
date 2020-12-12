
args <- commandArgs(trailingOnly = TRUE)
solution <- read.table(args[1])
key <- read.table("key1.txt")
error = sum((solution-key)**2)/nrow(key)

if (error > 1e-6) {
  message("Solution is wrong")
  cor <- cor(key, solution)
  message("The correlation to the correct value is ", format(cor, digits = 3))
  message("The mse error to the correct value is ", format(error, digits = 6) , ", and it should be smaller than 1e-6")
  } else{
  message("Solution is correct.")
}

args <- commandArgs(trailingOnly = TRUE)
inputy= args[1]
inputx= args[2]
output= args[5]

#Read in the values 

library(readr)
y_value <- read_table2(inputy, 
                       col_names = FALSE)
x_value <- read_table2(inputx)
#print(x_value)

# add a column of ones to the x values for matrix multiplication with theta to get B0 parameter 
Intercept= rep(1, nrow(x_value))
x_value= as.matrix(x_value)
x_value= cbind(Intercept, x_value)
#print(x_value)

## Cost function to get RSS 

ComputeCost<- function(x,y,theta){
  Yhat= (x %*% theta)
  cost= sum((y- Yhat)**2/nrow(x))
  return(cost)
}

## Function to get gradient 

ComputeGradient= function(x,y,theta){
  yhat= (x %*% theta)
  grad= matrix(0, nrow = nrow(theta), ncol = 1)
  for (i in 1:nrow(theta)){
    grad[i] =  -2* (sum((y-yhat) * x[,i]))
  }
  return(grad)
}

# Note: division of gradient values with nrow(y_value) done in the while loop below

## Gradient descent method 

deltaJ= 100
alpha= as.numeric(args[3])
#print(alpha)
epsilon= as.numeric(args[4])
#print(epsilon)
theta = matrix(c(0), nrow = ncol(x_value), ncol = 1)
#print(theta)
cost = ComputeCost(x_value,y_value,theta)
#print(cost)
while (deltaJ > epsilon ){
  grad= ComputeGradient(x_value,y_value,theta)
  grad2= grad/nrow(y_value) 
  theta = theta - (alpha * grad2)
  prevCost= cost 
  cost = ComputeCost(x_value,y_value,theta)
  deltaJ = abs(cost- prevCost)
}

newtheta= (theta)
#print(newtheta)  to compare with theta values from the lm model 

yhatnew= (x_value %*% theta)

#print(yhatnew)

write.table(x = yhatnew, file = output, sep = ",", col.names  = FALSE, row.names = FALSE)


RSS= sum((y_value- yhatnew)^2)
#print( RSS) to compare with test RSS value 


## For multivariate regression, the script runs in less than a minute when epsilon is e-5.
##when a= e-3, e = 1e-5, the RSS is 1738.891
##when a= e-3, e= 1e-8, RSS is 1687.026 and it takes 5 minutes. 
##when a= e-3, and e= 1e-10, RSS 1686.924 is  and it takes 8-10 minutes. 
## y output for e= -10 is uploaded in tests folder 

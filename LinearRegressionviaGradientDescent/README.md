# A1: Multiple Linear Regression with Gradient Descent
### Assigned : 9/21 at 5PM EST
### Due : 10/01 at 5PM EST

Task : Create an R script to perform linear regression on an input data matrix. 

Your script should run iterations of the gradient algorithm as discussed in class, using an input parameter alpha for the learning rate. The iterations should continue until the RSS converges, i.e. the change in RSS between consecutive iterations is less than a given epsilon.

Place your script in your GitHub repository, and name it **NetID_A1.R**

# Inputs to your script:

1. File containing a single column : observed values of dependent variable (Y). The file will have no header. 

2. File containing a data matrix. The number of columns is the number of predictors in the multiple regression. Each row corresponds to a distinct set of observations, in the same order as the previous input file. The file has a header, with the column names representing each variable name. 

3. A learning rate alpha for the gradient descent.

4. A tolerance value epsilon. 

5. The name of the output file which will contain the fitted y-values (no header).

Example call :
```shell
Rscript yh1234_A1.R ./tests/y_example1.txt ./tests/x_example1.txt 1e-3 1e-10 ./tests/output_example1.txt
```
```shell
Rscript yh1234_A1.R ./tests/y_example2.txt ./tests/x_example2.txt 1e-3 1e-10 ./tests/output_example2.txt
```
# Outputs :

A list of fitted y-values, with no header. See output_example1.txt for an example

# Validation for example1 :
```shell
cd tests
Rscript verify_output.R output_example1.txt
```

# Resources : 

1. Intro to Machine Learning lectures : from Andrew Ng
https://www.coursera.org/learn/machine-learning

2. Passing R arguments to a script
https://www.r-bloggers.com/passing-arguments-to-an-r-script-from-command-lines/

3. R help functions:
?read.table ?readLines ?commandArgs ?writeLines ?write


# Grading :

Completeness (30 points)
  - Assignment repository is created.
  - Script is correctly named and uploaded to GitHub by the due date
  - Script runs and produces an output file without error

Correctness (50 points)
  - Partial derivatives are correctly calculated
  - Gradient descent is properly implemented
  - Produces the correct output on two test examples

Style (20 points)
  - Variables are clearly named, code is commented.
  - Granted automatically if the output is perfect

Submissions received after **5PM** will be penalized by 15 points, with an additional 15 point penalty for each delayed day.

# A2: Logistic Regression and Model Selection
## Assigned : 10/19 at 5PM EST
## Due : 10/29 at 5PM EST


Task : Choose a model to classify RNA-seq libraries into two cell types. 

(1) Your script should run the forward selection algorithm as described in class, going up to 50 iterations. This will result in a series of models that you will select from. (2) To guide the selection, you will perform five-fold cross validation on each model, and calculate the mean error. You will also calculate a likelihood for each model. (3) Finally, you will list the variables in order of their incorporation into the Forward selection process (a rough proxy for their importance).

Place your script in your GitHub repository, and name it **NetID_A2.R**

## Inputs to your script:

1. File containing a gene expression matrix from single cell RNA-seq, where the samples are columns and the rows are genes. The sample columns are labeled by the correct cell type for the cell and a cell index (`CELLTYPE_IDX`). For example, in example1 you have to classify CD14 monocytes vs CD16 monocytes and the corresponding column names are `CD14MONO_X` and `CD16MONO_X`.  In the example files there are 100 cells (50 per class) and 400+ predictors. 

2. The name of the output file that you will generate 

Example call :
```
Rscript rs5163_A2.R tests/example1_input.txt tests/output_example1.txt
```

## Outputs to your script:

1. A single file, consisting of 50 rows (and a header). Each row will have the following columns:

1. “Iteration” : The iteration step in the forward selection procedure (will be 1...50)
2. “Predictor” : The NAME of the predictor that you have added to the forward selection procedure.
3. “CV” : The 5-fold cross-validation error 
4. “Log-Likelihood” : The statistical log-likelihood associated with each model

## Checking your script

In the `tests` directory, there is an R script named `verify_output.R`. You can run this to check a few key things about your results with the example 1 dataset. The expected workflow for this would be to run your code on the example input datasets, writing the results to the `tests` directory. Then you would run this `verify_output.R` script. For example, from the main level directory, run:

```
Rscript NETID_A2.R tests/example1_input.txt tests/output_example1.txt
Rscript NETID_A2.R tests/example2_input.txt tests/output_example2.txt
Rscript tests/verify_output.R
```

Note: The `verify_output.R` script is expecting the output files named as above (`output_example1.txt`) 

## Resources : 

1. Course textbook : Chapter 5,6,8

2. A tutorial on logistic regression
https://ww2.coastal.edu/kingw/statistics/R-tutorials/logistic.html

3. R help functions:
?glm ?predict ?commandArgs ?writeLines ?write

## Grading :

Completeness (30 points)
  - GitHub repository is created
  - Script is correctly named and uploaded to GitHub by the due date
  - Script runs and produces an output file without error

Correctness (50 points)
  - Forward selection is implemented correctly
  - CV is implemented correctly
  - Likelihood calculation is implemented correctly
  - Produces the correct output 

Style (20 points)
  - Variables are clearly named, code is commented.
  - Granted automatically if the output is perfect

Submissions received after 2PM will be penalized by 15 points, with an additional 15 point penalty for each delayed day.

Submissions that do not return an output will receive an immediate penalty of 25 points with an opportunity to revise.

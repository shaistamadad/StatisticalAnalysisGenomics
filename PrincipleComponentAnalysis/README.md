# A4: Unsupervised learning : Dimensional Reduction
## Assigned : 11/30 at 5PM EST
## Due : 12/10 at 5PM EST

#### Task : Implement an iterative form of PCA on a provided dataset

Your script should run PCA using the iterative optimization algorithm discussed in class. The input dataset is a gene expression matrix consisting of has 140 data points to be clustered (each an individual RNA-seq experiment), and seven genes (you may recognize this as a subset of the data matrix from A3). Therefore, you have seven-dimensional data. Your assignment is to reduce the dimensionality of this dataset using PCA.

The assignment is divided into three parts, designed in a step-wise way.

### Part 1

Project the seven-dimensional dataset onto a provided seven-dimensional vector, and calculate variance of the projected dataset 

Place your script in your GitHub repository, and name it `NetID_A4_part1.R`

#### Inputs to your script:

1. File containing a gene expression matrix, where the samples (140) are rows and the columns (7) are genes. 

2. File containing a seven-dimensional vector (written as 7 lines).
 
3. Name of your output file. 

Example call :

`Rscript rs5163_A4_part1.R input_forPCA.txt random_vector.txt output_part1.txt`

#### Outputs to your script:

1. A single number, containing the total variance of the dataset after it has been projected onto the vector.

### Part 2. Calculate the first principal component 

Using the `optim` function, calculate the first principal component of the dataset. The first PC will be the vector that maximizes the variance after projection. You can use the `random_vector.txt` as an initial seed to the optim procedure.

Do NOT use the `prcomp`, `princomp`, `svd`, `eigen`, or other workaround functions in R to calculate the first PC. You will receive no credit for parts 2 and 3 if you use these functions in calculating your answer. 

The inputs will be the same as in part 1. The `random_vector.txt` will be used only as an initial seed (i.e., will be the first value of par that is sent to the `optim` function). The outputs will contain two files:   
__File 1__, one variance number, the variance explained by the first principal component, the same as in part 1, i.e. a single number containing the variance of the dataset after it has been projected onto the first PC.  
__File 2__, a matrix containing the frist PC vector. The length of the vector should be equal to 1. The column names should be PC1 and the row names should be genes name.

Example call :
`Rscript rs5163_A4_part2.R input_forPCA.txt random_vector.txt output_part2_variance.txt  output_part2_PC.txt`

### Part 3. Iteratively calculate the second and third PCs

You should now calculate the second and third PC using the iterative approach discussed in class and in your textbook. Briefly, after calculating PC1 and performing the projection, you will subtract the projected dataset from the original data, and rerun the optimization procedure to calculate PC2. Repeat this iteration one more time to calculate PC3.
		
Example call :
`Rscript rs5163_A4_part3.R input_forPCA.txt random_vector.txt output_part3_variance.txt  output_part3_PC.txt`

The inputs will be the same as parts 1 and 2. The outputs will now contain two files.  
__File 1__, three variance numbers, corresponding to the total variance explained by PC1, PC2, and PC3. The first number should be the same as the output for Part 2.  
__File 2__, a matrix containing three PC vectors. The column names should be PC1, PC2, PC3, and the row names should be genes name. The length of these vectors should be equal to 1.

## Allowed packages:

For this assignment, you may only use functions found in a base installation of R (excluding `prcomp`, `princomp`, `svd`, `eigen`, or any other function for running PCA). You may also use any package found in the [tidyverse](https://tidyverse.tidyverse.org/). Calling `library(X)` for any other package will cause your script to fail and result in a point deduction. 

## Checking your script

Please be sure your script can be run and creates and output as follows. The output files should be uploaded to your repo. To check your scripts for correctness, please check your solution against the answer returned by the `prcomp` function as discussed in recitation.


### Resources : 

1. Course textbook : Chapter 10.2

2. https://en.wikibooks.org/wiki/Linear_Algebra/Orthogonal_Projection_Onto_a_Line

3. Optim example for linear regression (provided with assignment)

### Grading:

Completeness (20 points)
  - Scripts are correctly named and uploaded to GitHub by the due date
  - Scripts run and produce output files without error

Correctness (65 points)
  - vector projection and variance calculations are correct (part 1 - 30 pts)
  - first PC computed correctly (part 2 - 25 pts)
  - PCs 2 and 3 computed correctly (part 3 - 10 pts)

Style (15 points)
  - Variables are clearly named, code is commented.
  - Granted automatically if the output is perfect
  
  
Submissions received after 5PM will be penalized by 15 points, with an additional 15 point penalty for each delayed day.

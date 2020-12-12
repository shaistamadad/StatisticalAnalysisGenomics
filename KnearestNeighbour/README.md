# A3: Unsupervised learning - Clustering
## Assigned : 11/09 at 5PM EST
## Due : 11/23 at 5PM EST

Task : Implement k-means clustering on a provided dataset

In this assignment, you will write code that implements the k-means clustering algorithm as described in class (for a reference, see Chapter 10.3.1 of your book). We will provide example input datasets that are derived from real single-cell data. The data for example 1 consists of protein measurements (ADTs from CITE-seq) for 10 proteins for 50 cells. The data for example 2 consists of RNA-seq measurements for 547 genes for 140 cells. You will need to cluster the data points (cells). You do not need to place the genes in to clusters, only the data points. This assignment is divided into three parts (and we are expecting three separate R scripts to be submitted):

### Part 1. Run K-means until convergence 

For part 1, you will implement the k-means algorithm under a couple of assumptions. 

1. A random cluster initialization will be provided.
2. The number of clusters is set at `k = 7`. 

Place your script in your GitHub repository, and name it `NetID_A3_part1.R`

#### Inputs to your script:

1. File containing the input data to be clustered (i.e. a gene expression matrix, where the samples are columns and the rows are genes). 

2. File containing the initial randomized cluster IDs (ranging from 1 to 7), for each sample. The file contains 140 values, in the same order as the columns of the gene expression matrix.

3. The name of your output file. 

Example call :
```
Rscript rs5163_A3_part1.R tests/input_data_example1.txt tests/initial_seeding_example1.txt tests/output_example1_part1.txt
Rscript rs5163_A3_part1.R tests/input_data_example2.txt tests/initial_seeding_example2.txt tests/output_example2_part1.txt
```

#### Outputs to your script:

1. A single file (specified via argument 3), consisting of **N+1** values (where N is the number of data points). The first **N** rows should be the final cluster IDs at the end of the k-means procedure for the data points - exactly like the `intial_seeding_exampleX.txt` file. The last (**N+1th**) value should be the value of the objective function for k-means. To ensure consistency, we will define the objective function here as being the average euclidean distance between all points and their associated cluster centers.

*Note that for Part 1, you do not actually need to use this objective function in the procedure, but we are asking you to calculate it anyway.*

### Part 2. Implement random starts 

For part 2, your script should run the k-means procedure with 25 random starts (you must generate these, they will not be provided), and output the clustering resulting for the random start that returns the lowest objective function. 

The inputs and outputs are the same as Part 1, except that you will not need the initial seeding file since you will be running on 25 random starts. You can still assume a set `k = 7`.

Your output file should still have **N+1** values: the cluster IDs and objective function value for the best clustering of the 25 random starts.

Example call :
```
Rscript rs5163_A3_part2.R tests/input_data_example1.txt tests/output_example1_part2.txt
Rscript rs5163_A3_part2.R tests/input_data_example2.txt tests/output_example2_part2.txt
```


### Part 3. Implement global k-means clustering 

For part 3, your script should implement the global k-means algorithm as discussed in class. Note that there is no stochasticity in this procedure, so you won’t need to use a random initialization or random starts. 

To save on computational time, for this task, you should assume a reduced k (`k=4`).

The output should be the same as in parts 1 and 2 : a file with **N+1** lines (**N** cluster IDs, and the objective function value, for the result of the global k-means procedure).

Example call :
```
Rscript rs5163_A3_part3.R tests/input_data_example1.txt tests/output_example1_part3.txt
Rscript rs5163_A3_part3.R tests/input_data_example2.txt tests/output_example2_part3.txt
```

## Resources : 

1. Course textbook : Chapter 10

2. The ‘dist’ function in R for calculating Euclidean distances, although it may be easier to implement this yourself

## Allowed packages:

For this assignment, you may only use functions found in a base installation of R (excluding the `kmeans` function of course). You may also use any package found in the [tidyverse](https://tidyverse.tidyverse.org/). Calling `library(X)` for any other package will cause your script to fail and result in a point deduction. 

## Checking your script

In the `tests` directory, there is an R script named `verify_output.R`. You can run this to check your results with the example 1 dataset. The expected workflow for this would be to run your code on the example input datasets, writing the results to the `tests` directory. Then you would run this `verify_output.R` script. For example, from the main level directory, run:

```
Rscript NETID_A3_part1.R tests/input_data_example1.txt tests/initial_seeding_example1.txt tests/output_example1_part1.txt
Rscript NETID_A3_part2.R tests/input_data_example1.txt tests/output_example1_part2.txt
Rscript NETID_A3_part3.R tests/input_data_example1.txt tests/output_example1_part3.txt
Rscript tests/verify_output.R
```

### Grading:

Completeness (30 points)
  - Scripts are correctly named and uploaded to GitHub by the due date
  - Scripts run and produce output files without error

Correctness (50 points)
  - k-means procedure implemented correctly, object function computed correctly (30)
  - multiple random starts handled properly (10)
  - global k-means correctly implemeted (10)

Style (20 points)
  - Variables are clearly named, code is commented.
  - Granted automatically if the output is perfect

Submissions received after 5PM will be penalized by 15 points, with an additional 15 point penalty for each delayed day.

Submissions that do not return an output for part 1 and part 2 will receive an immediate penalty with an opportunity to revise.

cat("Checking example 1 part 1: \n")
key <- read.table("tests/key1_part1.txt")


solution.file <- grep(pattern = "output_example1_part1.txt", list.files("tests/"), value = TRUE)
solution <- read.table(file = paste0("tests/", solution.file))

if(!nrow(x = solution) == 51) {
  stop("Generated solution file contains ", nrow(x = solution), " rows. Expecting 51.")
}

if (! all.equal(target = key[1:50, 1], current = solution[1:50, 1])) {
  stop("Cluster assignments don't match key.")
} else {
  message("Cluster assignments match the key")
}

if (! all.equal(target = key[51, 1], current = solution[51, 1], tolerance = 1e-4)) {
  stop("Objective function value doesn't match key.")
} else {
  message("Objective function value matches the key")
}


if (!any(grepl(pattern = "output_example1_part2.txt", x = list.files(path = "tests/")))) {
  stop("Output file for example 1, part 2 doesn't exists. Please check that your script runs without errors and properly accepts and parses the output file name parameter.")
}

cat("\n")
cat("Checking example 1 part 2:")
solution.file <- grep(pattern = "output_example1_part2.txt", list.files("tests/"), value = TRUE)
solution <- read.table(file = paste0("tests/", solution.file))

if(!nrow(x = solution) == 51) {
  stop("Generated solution file contains ", nrow(x = solution), " rows. Expecting 51.")
} else {
  message("Correct format of the output2. We don't compare the cluster results for part2")
}



cat("\n")
cat("Checking example 1 part 3: \n")
if (!any(grepl(pattern = "output_example1_part3.txt", x = list.files(path = "tests/")))) {
  stop("Output file for example 1, part 3 doesn't exists. Please check that your script runs without errors and properly accepts and parses the output file name parameter.")
}
key <- read.table("tests/key1_part3.txt")
solution.file <- grep(pattern = "output_example1_part3.txt", list.files("tests/"), value = TRUE)
solution <- read.table(file = paste0("tests/", solution.file))

if(!nrow(x = solution) == 51) {
  stop("Generated solution file contains ", nrow(x = solution), " rows. Expecting 51.")
}

if (! all.equal(target = key[1:50, 1], current = solution[1:50, 1])) {
  stop("Cluster assignments don't match key.")
} else {
  message("Cluster assignments match the key")
}



if (! all.equal(target = key[51, 1], current = solution[51, 1], tolerance = 1e-4)) {
  stop("Objective function value doesn't match key.")
}  else {
  message("Objective function value matches the key")
}


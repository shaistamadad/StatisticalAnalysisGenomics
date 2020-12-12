key <- read.table("tests/key1.txt", header = TRUE)
if (!any(grepl(pattern = "output_example1.txt", x = list.files(path = "tests/")))) {
  stop("Output file for example 1 doesn't exists. Please check that your script runs without errors and properly accepts and parses the output file name parameter.")
}

solution.file <- grep(pattern = "output_example1.txt", list.files("tests/"), value = TRUE)
solution <- read.table(file = paste0("tests/", solution.file), header = TRUE)

if(! all(colnames(x = solution) == colnames(x = key))) {
  stop("Please make sure to label the columns as follows: Iteration, Predictor, CV, Log-Likelihood")
}

if(!nrow(x = solution) == 50) {
  stop("Pleae provide 50 iterations of forward selection (only ", nrow(x = solution), " given).")
}

if (! isTRUE(all.equal(target = key[, 1], current = solution[, 1]))) {
  stop("Please list the iteration number in the first column")
}

if (! isTRUE(all.equal(target = key[, 2], current = solution[, 2]))) {
	stop("Predictor names and/or order doesn't match the key")
} else {
  print("Predictor names and order both matche the key")
}

if (! isTRUE(all.equal(target = key[, 4], current = solution[, 4], tolerance = 1e-3))) {
  likelihood.cor <- cor(key[, 4], solution[, 4])
  stop("Predictor Log.Likelihood doesn't match the key, and their correlation is ", likelihood.cor)
}  else {
  print("Predictor Log.Likelihood matches the key")
}



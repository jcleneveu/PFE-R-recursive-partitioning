# Include configuration and utils
source(file="config.R")
source(file="utils.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Installing party (warning: gcc-fortran is needed)
install.packages('party')
library('party')

# We perform our ctree analyse to remove the weakest dataset
columns <- analyse_ctree(columns, referencial, CSVdata)
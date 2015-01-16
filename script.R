# Include configuration and utils
source(file="config.R")
source(file="utils.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Installing party (warning: gcc-fortran is needed)
install.packages('party')
library('party')

# We loop to remove less significant dataset from columns
# until we reach max_nb_parameters
while(length(columns) > max_nb_parameters) {
  columns <- analyse_ctree(columns, referencial, CSVdata)  
}

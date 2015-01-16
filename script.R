# Include configuration and utils
source(file="config.R")
source(file="utils.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Installing and loading party (warning: gcc-fortran is needed)
install.packages('party')
library('party')

# We loop to remove less significant dataset from columns
# until we reach max_nb_parameters
while(length(columns) > max_nb_parameters) {
  columns <- analyse_ctree(columns, referencial, CSVdata)  
}

# We get the result ctree from final dataset and print/plot it
result <- do_ctree(columns, referencial, CSVdata)
print(result)
plot(result)
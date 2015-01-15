# Include configuration and utils
source(file="config.R")
source(file="utils.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Installing party (warning: gcc-fortran is needed)
install.packages('party')
library('party')

# Building query
query <- build_query(columns)

# Executing query and getting data analysis
formula <- paste(referencial, query, sep = " ~ ")
fit.ctree <- ctree(eval(parse(text=formula)), data=CSVdata)

# Plot and print data
fit.ctree
plot(fit.ctree)

# Anaylse of criterions to determine less significant criterion
last_significant <- analyseCriterions(columns, fit.ctree@tree)

# We remove the last significant data based on criterion
if(last_significant$value < criterion_threshold && length(columns) > min_nb_parameters) {
  columns <- columns[-which(columns == last_significant$name)]
}
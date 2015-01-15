# Include configuration
source(file="config.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Installing party (warning: gcc-fortran is needed)
# install.packages('party')
library('party')

# Building query
query <- ""
for(c in 1:length(columns)) {
    query <- paste(query, columns[c], sep = " + ")
}
query <- substring(query, 4)

# Executing query and getting data analysis
formula <- paste(referencial, query, sep = " ~ ")
fit.ctree <- ctree(eval(parse(text=formula)), data=CSVdata)

# Plot and print data
fit.ctree
plot(fit.ctree)
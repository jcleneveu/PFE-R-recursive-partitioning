# This file is used to configure the data analysis program

# Path settings
CSVfile <- "data.csv"

# Columns in your file to analyse
columns <- c("Google.Trends", "Users.Number", "Volume.Transaction", "Miners.Gain", "Youtube.Searches")
referencial <- "Rate"

# Threshold parameters
criterion_threshold = 0.8
min_nb_parameters = 3
max_nb_parameters = 3

#columns <- c("c1", "c2", "c3")
#referencial <- "c0"
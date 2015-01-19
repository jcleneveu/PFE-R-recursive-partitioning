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

# Prediction parameters (only used by prediction.R)
parameters <- list(Google.Trends=1,
                   Users.Number=1,
                   Volume.Transaction=1,
                   Miners.Gain=1,
                   Youtube.Searches=1)
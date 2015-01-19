# This file is used to configure the data analysis program

# Path settings
CSVfile <- "data.csv"

# Columns in your file to analyse
columns <- c("Google.Trends",
             "Users.Number",
             "Volume.Transaction",
             "Miners.Gain",
             "Youtube.Searches",
             "Bitcoin.News",
             "USA.Unemployment",
             "Gold.Price")
referencial <- "Rate"

# Threshold parameters
criterion_threshold = 0.8
min_nb_parameters = 3
max_nb_parameters = 3

# Prediction parameters (only used by prediction.R)
parameters <- list(Google.Trends=15,
                   Users.Number=29,
                   Volume.Transaction=26,
                   Miners.Gain=11,
                   Youtube.Searches=15,
                   Bitcoin.News=6,
                   USA.Unemployment=7.5,
                   Gold.Price=1385.25)
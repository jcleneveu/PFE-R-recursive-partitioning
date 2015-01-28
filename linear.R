# Include configuration and utils
source(file="config.R")
source(file="utils.R")

# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)

# Computing mean ratio between rate & datasets
data <- getRatioMatrix(CSVdata, columns)
mean <- getMeanList(data, columns)

# Reading 2nd CSV input file
CSVdata<- read.csv(CSVfile2, sep = ";", header = TRUE)

# Gettings approximation error (in %)
approx <- getApproximation(columns, CSVdata, mean)

# ploting
plot(CSVdata$Rate,type="l",col="red",ann = FALSE)
lines(CSVdata[columns[1]] * mean[1],col="green")       # [1] "Google.Trends" 
lines(CSVdata[columns[2]] * mean[2],col="blue")        # [2] "Users.Number"
lines(CSVdata[columns[3]] * mean[3],col="pink")        # [3] "Volume.Transaction"
lines(CSVdata[columns[4]] * mean[4],col="yellow")      # [4] "Miners.Gain"
lines(CSVdata[columns[5]] * mean[5],col="orange")      # [5] "Youtube.Searches"
lines(CSVdata[columns[6]] * mean[6],col="dimgrey")     # [6] "Bitcoin.News"
lines(CSVdata[columns[7]] * mean[7],col="darkorchid")  # [7] "USA.Unemployment"
lines(CSVdata[columns[8]] * mean[8],col="gray0")       # [8] "Gold.Price" 

print(approx)
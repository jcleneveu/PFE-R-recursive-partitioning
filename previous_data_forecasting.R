# Include ctree main program
source(file="script.R")

#########################################
####### PREVIOUS DATA FORECASTING #######
#########################################

#Forecasting en fonction des donnees precedentes
library(forecast)
sensor <- ts(CSVdata$Rate) 
fit <- auto.arima(sensor)
#Possible de faire une prediction sur plus de 20 points (second paramatre)
fcast <- forecast(fit,20)
fcast
CSVdata$Date <- as.Date(CSVdata$Date, "%d/%m/%Y")
plot(fcast,col="violet", ann = FALSE)
title("Forecasting")
grid()

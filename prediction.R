# Include ctree main program
source(file="script.R")

# Prediction from data and tree
prediction <- Predict(result, newdata=parameters)
print(prediction)

################################################
##Forecasting en fonction des données précédentes
#library(forecast)
#sensor <- ts(CSVdata$Rate) 
#fit <- auto.arima(sensor)
##Possible de faire une prédiction sur plus de 20 points (second paramètre)
#fcast <- forecast(fit,20)
#fcast
#plot(fcast)
#grid()
################################################

# Include ctree main program
source(file="script.R")

#############################
####### PREDICTION  #########
#############################

#First iteration, we instatiate the vector true_value 
true_value <- CSVdata$Rate[1]

# Prediction parameters (only used by prediction.R)
parameters <- list(Google.Trends=CSVdata$Google.Trends[1],
                   Users.Number=CSVdata$Users.Number[1],
                   Volume.Transaction=CSVdata$Volume.Transaction[1],
                   Miners.Gain=CSVdata$Miners.Gain[1],
                   Youtube.Searches=CSVdata$Youtube.Searches[1],
                   Bitcoin.News=CSVdata$Bitcoin.News[1],
                   USA.Unemployment=CSVdata$USA.Unemployment[1],
                   Gold.Price=CSVdata$Gold.Price[1])

#Prediction
prediction <- Predict(result, newdata=parameters)
#Create the vector measure with the first prediction
measure <- c(prediction)
#Calculate the error of the first values and put it in a new vector
erreur <- c(abs((prediction-true_value)/true_value)*100)

#Do the loop with the rest of the data
for ( i in 2:nrow(CSVdata)) { 
  
  true_value <- CSVdata$Rate[i]
  
  # Prediction parameters (only used by prediction.R)
  parameters <- list(Google.Trends=CSVdata$Google.Trends[i],
                     Users.Number=CSVdata$Users.Number[i],
                     Volume.Transaction=CSVdata$Volume.Transaction[i],
                     Miners.Gain=CSVdata$Miners.Gain[i],
                     Youtube.Searches=CSVdata$Youtube.Searches[i],
                     Bitcoin.News=CSVdata$Bitcoin.News[i],
                     USA.Unemployment=CSVdata$USA.Unemployment[i],
                     Gold.Price=CSVdata$Gold.Price[i])
  
  # Prediction from data and tree
  prediction <- Predict(result, newdata=parameters)
  
  #Add it to our vector measure
  measure <- append(measure, prediction, length(measure))
  
  #Add the error to the error vector
  erreur <- append(erreur,abs((prediction-true_value)/true_value)*100,length(erreur))
  
}

#############################
####### RESULTS  ############
#############################

sprintf("Minimum error : %f, Index : %d, Date %s", min(erreur), which.min(erreur), CSVdata$Date[which.min(erreur)])
sprintf("Maximum error : %f, Index : %d, Date %s", max(erreur), which.max(erreur), CSVdata$Date[which.max(erreur)])
sprintf("Average error : %f", mean(erreur))

df <- data.frame(CSVdata$Date,erreur)
print(df)

#Print the error graph
df$CSVdata.Date <- as.Date(df$CSVdata.Date, "%m/%d/%Y")
plot(erreur ~ df$CSVdata.Date, df, xaxt = "n",col="orange", ann = FALSE)
axis(1, df$CSVdata.Date, format(df$CSVdata.Date, "%m/%d/%Y"))
title('Error / Date')
title(ylab = "Error") ## draw the axis labels
title(xlab = "Date") ## push this one down a bit in larger margin


#Plots representing Real rate / predictions
plot(CSVdata$Rate,type="l",col="red",ann = FALSE)
lines(measure,col="green")
title('Real rate (Red) and Prediction (Green) / Date')
title(ylab = "Rate") ## draw the axis labels
title(xlab = "Date") ## push this one down a bit in larger margin

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


# Include ctree main program
source(file="prediction.R")

#########################################
####### APPROXIMATION ###################
#########################################

#Calculate and plot the approximation
CSVdata$Date <- as.Date(CSVdata$Date, "%d/%m/%Y")
approxCSV <- approx(measure)
approxCSVConstant <- approx(measure, method="constant")
plot(CSVdata$Rate,type="l",col="red",ann = FALSE)
lines(approxCSV,col="blue")
lines(approxCSVConstant,col="green")

title('Real rate (Red) and Approx (Blue) / Date')
title(ylab = "Rate") ## draw the axis labels
title(xlab = "Date") ## push this one down a bit in larger margin

#First iteration
approxindex <- approxCSV$x[1]
true_value <- CSVdata$Rate[floor(approxindex)]
approx <- approxCSV$y[approxindex]
erreur <- c(abs((approx-true_value)/true_value)*100)

#Calculate error of each approximation
for ( i in 2:length(approxCSV$x)) { 
  
  approxindex <- approxCSV$x[i]
  true_value <- CSVdata$Rate[floor(approxindex)]
  approx <- approxCSV$y[i]
  erreur <- append(erreur,abs((approx-true_value)/true_value)*100,length(erreur))
  
}

#############################
####### RESULTS  ############
#############################

sprintf("Minimum error : %f, Index : %d, Date %s", min(erreur), which.min(erreur), CSVdata$Date[which.min(erreur)])
sprintf("Maximum error : %f, Index : %d, Date %s", max(erreur), which.max(erreur), CSVdata$Date[which.max(erreur)])
sprintf("Average error : %f", mean(erreur))

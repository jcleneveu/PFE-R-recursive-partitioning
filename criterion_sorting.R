source(file="utils.R")
source(file="config.R")
# Reading CSV input file
CSVdata <- read.csv(CSVfile, sep = ";", header = TRUE)
# Installing and loading party (warning: gcc-fortran is needed)
#install.packages('party')
library('party')

#We take all the parameters
parameters <- data.frame(Google.Trends=CSVdata$Google.Trends[1],
                         Users.Number=CSVdata$Users.Number[1],
                         Volume.Transaction=CSVdata$Volume.Transaction[1],
                         Miners.Gain=CSVdata$Miners.Gain[1],
                         Youtube.Searches=CSVdata$Youtube.Searches[1],
                         Bitcoin.News=CSVdata$Bitcoin.News[1],
                         USA.Unemployment=CSVdata$USA.Unemployment[1],
                         Gold.Price=CSVdata$Gold.Price[1])

#We pick each comination of 3 parameters
all_comb <- combn(colnames(parameters),3)
all_comb

#For each combination
for ( i in 1:ncol(all_comb)) {

  Google.Trends=CSVdata$Google.Trends
  Users.Number=CSVdata$Users.Number
  Volume.Transaction=CSVdata$Volume.Transaction
  Miners.Gain=CSVdata$Miners.Gain
  Youtube.Searches=CSVdata$Youtube.Searches
  Bitcoin.News=CSVdata$Bitcoin.News
  USA.Unemployment=CSVdata$USA.Unemployment
  Gold.Price=CSVdata$Gold.Price
  
  #We print the iteration
  X <- sprintf("Iteration number => %d",i)
  print(X)
  
  #We make 3 columns with the combinations
  columns <- c(all_comb[1,i],all_comb[2,i],all_comb[3,i])
  referencial <- "Rate"
  
  comb_df <- data.frame(get(all_comb[1,i]),get(all_comb[2,i]),get(all_comb[3,i]))
  colnames(comb_df) <- c(all_comb[1,i], all_comb[2,i], all_comb[3,i])
  
  true_value <- CSVdata$Rate[1]
  parameters2 <- data.frame(assign(paste(colnames(comb_df[1]),sep=""),comb_df[1,1]),
                            assign(paste(colnames(comb_df[2]),sep=""),comb_df[1,2]),
                            assign(paste(colnames(comb_df[3]),sep=""),comb_df[1,3]))
  colnames(parameters2) <- c(colnames(comb_df[1]),colnames(comb_df[2]),colnames(comb_df[3]))
  result <- do_ctree(columns, referencial, CSVdata)
  
  #We make the prediction for the first iteration
  prediction <- Predict(result, newdata=parameters2)
  
  #We make the vector for the error
  erreur <- c(abs((prediction-true_value)/true_value)*100)
  
  #For each iteration of n combination we incremate the error vector
  for ( j in 2:nrow(CSVdata)) { 
    true_value <- CSVdata$Rate[j]
    parameters2 <- data.frame(assign(paste(colnames(comb_df[1]),sep=""),comb_df[j,1]),
                              assign(paste(colnames(comb_df[2]),sep=""),comb_df[j,2]),
                              assign(paste(colnames(comb_df[3]),sep=""),comb_df[j,3]))
    parameters2
    
    prediction <- Predict(result, newdata=parameters2)

    erreur <- append(erreur,abs((prediction-true_value)/true_value)*100,length(erreur))
   
  }
  
  #We add the average error to our final data frame
  par <- c(paste(all_comb[1,i],all_comb[2,i],all_comb[3,i],sep="/"))
  
  couples <- data.frame(par,mean(erreur))
  
  
  if(i==1){
    final <- couples
  }
    
  else{
    final <- rbind(final, couples)
  }
  
}

print(final)

#First plot
colnames(final)=c('Triple','Error')
print(final[with(final, order(final[2])), ])
plot(final$Error,type="h",col="lightgrey",xlab="Index", ylab="Error",las=1)
title('Error / Triple')

#Second plot
par(mar=c(5,12,1,6))#,mgp=c(5,1,0))
barplot(final$Error, names.arg=final$Triple, horiz=TRUE, las=1, cex.names=0.5, 
        border=0.5,col="lightgrey",xlab="Average Error (%)")
title('Triple / Error')

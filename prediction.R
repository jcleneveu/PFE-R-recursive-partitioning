# Include ctree main program
source(file="script.R")

# Prediction from data and tree
prediction <- Predict(result, newdata=parameters)
print(prediction)
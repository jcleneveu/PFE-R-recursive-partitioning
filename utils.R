# This method find the less significant dataset by finding the lowest criterion.
# It returns a list containing the value of this criterion and the dataset name
analyseCriterions <- function(columns, tree){
  last_significant <- list(value=1, name="undefined") 
  for(c in columns) {
    if(tree$criterion[2]$criterion[[c]] < last_significant$value) {
      last_significant$value = tree$criterion[2]$criterion[[c]];
      last_significant$name = c;
    }
  }
  if(last_significant$value > criterion_threshold) {
    if( ! tree$terminal) {
      left <- analyseCriterions(columns, tree$left)
      right <- analyseCriterions(columns, tree$left)
      if(left$value < right$value) {
        last_significant <- left
      } else {
        last_significant <- right
      }
    }
  }
  return(last_significant)
}

# This method is used to build the query from the columns list
build_query <- function(columns) {
  query <- ""
  for(c in columns) {
    query <- paste(query, c, sep = " + ")
  }
  query <- substring(query, 4)
  return(query)
}

# This method is the core of the program: it does a ctree from data
# using party library and return the datasets without the less significant
analyse_ctree <- function(columns, referencial, CSVdata) {
  # Building query
  query <- build_query(columns)
  
  # Executing query and getting data analysis
  formula <- paste(referencial, query, sep = " ~ ")
  fit.ctree <- ctree(eval(parse(text=formula)), data=CSVdata)
  
  # Plot and print data
  fit.ctree
  plot(fit.ctree)
  
  # Anaylse of criterions to determine less significant criterion
  last_significant <- analyseCriterions(columns, fit.ctree@tree)
  
  # We remove the last significant data based on criterion
  if(last_significant$value < criterion_threshold && length(columns) > min_nb_parameters) {
    columns <- columns[-which(columns == last_significant$name)]
  }
  return(columns)
}
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
      right <- analyseCriterions(columns, tree$right)
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

# This function build the query and get the tree from columns, referencial and data
do_ctree <- function(columns, referencial, CSVdata) {
  # Building query
  query <- build_query(columns)
  
  # Executing query and getting data analysis
  formula <- paste(referencial, query, sep = " ~ ")
  return(ctree(eval(parse(text=formula)), data=CSVdata))
}

# This method is the core of the program: it creates a ctree from data
# using party library, analyse the result and return the datasets
# without the less significant parameter
analyse_ctree <- function(columns, referencial, CSVdata) {
  # We get the ctree
  fit.ctree <- do_ctree(columns, referencial, CSVdata)
  
  # Anaylse of criterions to determine less significant criterion
  last_significant <- analyseCriterions(columns, fit.ctree@tree)
  
  # We remove the last significant data based on criterion only if under threshold
  if(last_significant$value < criterion_threshold && length(columns) > min_nb_parameters) {
    columns <- columns[-which(columns == last_significant$name)]
  }
  return(columns)
}
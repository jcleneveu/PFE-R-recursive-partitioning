analyseCriterions <- function(columns, tree){
  last_significant <- list(value=1, name="undefined") 
  for(c in columns) {
    if(tree$criterion[2]$criterion[[c]] < last_significant$value) {
      last_significant$value = tree$criterion[2]$criterion[[c]];
      last_significant$name = c;
    }
  }
  return(last_significant)
}

build_query <- function(columns) {
  query <- ""
  for(c in columns) {
    query <- paste(query, c, sep = " + ")
  }
  query <- substring(query, 4)
  return(query)
}
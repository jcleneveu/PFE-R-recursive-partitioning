# Why these scripts?
They are part of a project of Big Data in Finance. Their goal is to find the most significant datasets to easily deduce a curve. For instance one can find the bitcoin rate in $USD from multiple parameters such as bitcoin activity, wikipedia views, or google trends.

# How to run?
* Set the working directory
* Edit config.R to specify your own data path
* Run ;)

Notes:
* To import party, you need gcc-fortran which can be found here: https://gcc.gnu.org/fortran/
* If rstudio tells you something about party being recompiled, feel free to comment this line:
              install.packages('party')

# Dependencies
party => gcc-fortran
R

# Note to developpers: if needed, you can find here some useful hints ;)

* fit.ctree@tree$nodeID
* fit.ctree@tree$weights
* fit.ctree@tree$criterion
* fit.ctree@tree$terminal
* fit.ctree@tree$psplit
* fit.ctree@tree$ssyplits$variableName
* fit.ctree@tree$prediction
* fit.ctree@tree$left
* fit.ctree@tree$right
* fit.ctree@tree$weights
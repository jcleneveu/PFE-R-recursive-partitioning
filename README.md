# PFE R recursive partitioning

## Why these scripts?
They are part of a project of Big Data in Finance. Their goal is to find the most significant datasets to easily deduce a curve. For instance one can find the bitcoin rate in $USD from multiple parameters such as bitcoin activity, wikipedia views, or google trends.

## How to run?
* Set the working directory
* Edit `config.R` to specify your own data path
* Run ;)

Notes:
* To import party, you need `gcc-fortran` which can be found here: https://gcc.gnu.org/fortran/
* If rstudio tells you something about party being recompiled, feel free to comment this line: `install.packages('party')`

## Dependencies
* `party` => which needs `gcc-fortran` to be compiled
* `R` (of course)

## License : GPL
    Copyright (C) 2015 Jean-Charles Leneveu, Maxime Wyka, Léo Mansart, Antoine Chereau, Tarek Mesbah

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Note to developpers:

if needed, you can find here some useful hints ;)

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
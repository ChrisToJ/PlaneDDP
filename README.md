planeR
========================================================

A "shiny" application to determine the best-fitting plane 
for a set of five 3D points

The problem
---

In biology (e. g. 3D microscopy reconstruction) and 
in geology (e. g. landmark measurements) and 
in many other research
areas it is sometimes necessary to 
determine a plain that best fits to a set of data points. 
And often these data points are hard to obtain.

[**planeR**](http://christoj.shinyapps.io/planeR) 
can determine a plane from as few as five
3D point measurements.


The solution
---

[**planeR**](http://christoj.shinyapps.io/planeR) offers the following features:

- flexible user input
- centroid calculation
- normal vector calculation
- interactive 3D visualisation
- good documentation

Please share the link with everybody who might be interested!


### Requirements

library(shinyRGL)  
library(rgl)  


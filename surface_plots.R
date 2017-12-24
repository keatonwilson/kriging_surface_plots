#Keaton Wilson
#2017-12-24
#keatonwilson@me.com

##Sample and explanatory code for generating surface plots


#Install and load the fields package, which includes all the 
#relevant functions for generating the heat maps
require(fields)

#Reading in the sample csv file 
cats = read.csv(file = "data/keatoncats.csv")

#inspecting the data.frame
str(cats)

#Ok, so the basic pipeline for getting this stuff to work is:
#1. Reformat your data into a matrix or "coordinates" and a vector which represents the third variable 
  # a. The first matrix are your "coordinates" - where in the 2-dimensional space each point lies
  # So for my data, these the amount of protein or carbohydrates eaten.

x = as.matrix(cbind(cats$Protein, cats$Carbs))

#The second piece is a vector that is aligned with your matrix with whatever third variable you want
#in color on the heatmap
Y = cats$Performance


#The krig function.
# The first part is generating the model. Theta here modifies how much smoothing there is in the model. 
# check out ?Krig
fit = Krig(x, Y, theta = 0.2)

# This generates the output of the Krig model, so we can plot it.
out.p = predictSurface( fit)

#Plotting stuff 
#3-d surface first
plot.surface(out.p, type = "p", xlab = "Protein (g)", ylab = "Carbohydrates (g)", zlab = "Performance", theta = 180, phi = 30)

#Level or contour plot
plot.surface(out.p, type = "I", xlab = "Protein (g)", ylab = "Carbohydrates (g)", zlab = "Performance", xlim = c(0,5.5), ylim = c(0,5.5))

#You can plot normal base-R plotting stuff on top of this. You can also expand the area that is interporlated
#by describing a convex hull with a series of points. Check out ?Krig

#Lots of extra work to get to a really nice-looking figure, but this is just the basics. 

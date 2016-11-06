## R Studio's manipulate package

# the manipulate package
# it's a pretty good way to practice making interactive plots before
# delving into the RStudio Shiny world. When RStudio came out and they 
# introduced this package, it was great. My lab mates and I were trying 
# to make sense of our data sets, using for loops with Sys.sleep(5) calls
# to scroll through lots of preliminary plots.

library(manipulate)
library(readxl)
library(dplyr)

## Using more than one slider
manipulate(
  plot(cars, xlim=c(x.min,x.max)),
  x.min=slider(0,15),
  x.max=slider(15,30))

## Filtering data with a picker
manipulate(
  barplot(as.matrix(longley[,factor]),
          beside = TRUE, main = factor),
  factor = picker("GNP", "Unemployed", "Employed"))

## Create a picker with labels
manipulate(
  plot(pressure, type = type),
  type = picker("points" = "p", "line" = "l", "step" = "s", "both" = "b"))

## Toggle boxplot outlier display using checkbox
manipulate(
  boxplot(Freq ~ Class, data = Titanic, outline = outline),
  outline = checkbox(FALSE, "Show outliers"))

## Combining controls
manipulate(
  plot(cars, xlim = c(x.min, x.max), type = type,
       axes = axes, ann = label),
  x.min = slider(0,15),
  x.max = slider(15,30, initial = 25),
  type = picker("p", "l", "b", "c", "o", "h", "s", "S", "n"),
  axes = checkbox(TRUE, "Draw Axes"),
  label = checkbox(FALSE, "Draw Labels"))

## Making up some data and having some fun

birds <- tbl_df(read_excel("~/Dropbox/Presentations/tw_analytics/plots_that_blow_your_mind/birdie_data.xlsx"))

birds$loc_num <- as.numeric(as.factor( birds$Location))
birds$tree_num <- as.numeric(as.factor( birds$Tree_Species))

x_var <- "Year" # "ID", "loc_num", "tree_num", 
y_var <- "Num_Hatched" # "Eggs", "Num_Fledged"
col_vars <- "Father_Age"  # c("Father_Age", "Mother_Age", "Tree_Species", "Good_Food", "Predators", "Year", "Location")
size_vars <- "Father_Age" # c("Father_Age", "Mother_Age", "Good_Food", "Nest_Height", "Predators")

manipulate(
  plot(birds[,c(x_var,y_var)], 
       cex = as.matrix(birds[,size_vars]), 
       pch = 19,
       col = as.matrix(birds[,col_vars])),
  x_var = picker("Year", "ID", "loc_num", "tree_num", initial = "Year"),
  y_var = picker("Num_Hatched", "Eggs", "Num_Fledged", initial = "Num_Hatched"),
  size_vars = picker("Father_Age", "Mother_Age", "Good_Food", "Nest_Height", "Predators", initial = "Father_Age"),
  col_vars = picker("Father_Age", "Mother_Age", "Good_Food", "Predators", "Year", "Location", initial = "Father_Age")
)


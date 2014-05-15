library(plyr)

## data import from local file
gDat <- read.delim("gapminderDataFiveYear.tsv")

country_colors <- read.delim("gapminder-country-colors.tsv",
                             colClasses = list(color = "character"))
str(country_colors)
## 'data.frame':	142 obs. of  3 variables:
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 95 39 43 28 118 121 127 6..
##  $ color    : chr  "#7F3B08" "#833D07" "#873F07" "#8B4107" ...

## insert color as a variable in gDat
gDat <- merge(gDat, country_colors)

## Sort by year (increasing) and population (decreasing)
## Why? So larger countries will be plotted "under" smaller ones.
gDatOrdered <- arrange(gDat, year, desc(pop))

write.table(gDatOrdered, "gapminderDataColorReadySorted.tsv",
            quote = FALSE, sep = "\t", row.names = FALSE)

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/stripplot-')

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) 
gDat <- read.delim("gapminderDataFiveYear.tsv")
str(gDat)

#' stripplots: univariate scatterplots (but w/ ways to also convey 1+ factors)
ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_point()

#' we have an overplotting problem; need to spread things out
ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_jitter()

#' we can have less jitter in x, no jitter in y, more alpha transparency
ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)

#' boxplots -- covered properly elsewhere
ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_boxplot()

#' raw data AND boxplots
ggplot(gDat, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink") +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)

#' superpose a statistical summary
ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4) +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)
  
#' let's reorder the continent factor based on lifeExp
ggplot(gDat, aes(reorder(x = continent, lifeExp), y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4) +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)

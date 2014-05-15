#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/uni-quant-')

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) 
gDat <- read.delim("gapminderDataFiveYear.tsv")
str(gDat)

#' distribution of a quant var: histogram
ggplot(gDat, aes(x = lifeExp)) + geom_histogram()

#' smooth histogram = densityplot
ggplot(gDat, aes(x = lifeExp)) + geom_density()

#' show the different continents, but I think it's weird to stack up the
#' histograms, which is what default of `position = "stack"` delivers
ggplot(gDat, aes(x = lifeExp, fill = continent)) + geom_histogram()

#' `position = "identity"` is good to know about
ggplot(gDat, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

#' densityplots work better in terms of one continent not obscuring another
ggplot(gDat, aes(x = lifeExp, color = continent)) + geom_density()

#' alpha transparency works here too
ggplot(gDat, aes(x = lifeExp, fill = continent)) + geom_density(alpha = 0.2)

#' with only two countries, maybe we should ignore Oceania?
ggplot(subset(gDat, continent != "Oceania"),
       aes(x = lifeExp, fill = continent)) + geom_density(alpha = 0.2)

#' facets work here too
ggplot(gDat, aes(x = lifeExp)) + geom_density() + facet_wrap(~ continent)

ggplot(subset(gDat, continent != "Oceania"),
       aes(x = lifeExp, fill = continent)) + geom_histogram() +
  facet_grid(continent ~ .)

#' boxplot for one quantitative variable against a discrete variable  
#' first attempt does not work since year is not formally a factor
ggplot(gDat, aes(x = year, y = lifeExp)) + geom_boxplot()

#' by explicitly specifying year as the grouping variable, we get what we want
ggplot(gDat, aes(x = year, y = lifeExp)) + geom_boxplot(aes(group = year))

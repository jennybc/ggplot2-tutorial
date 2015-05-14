#' ---
#' author: "Jenny Bryan"
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/uni-quant-', error = TRUE)

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
#gdURL <- "http://tiny.cc/gapminder"
#gapminder <- read.delim(file = gdURL) 
#gapminder <- read.delim("gapminderDataFiveYear.tsv")
library(gapminder)
str(gapminder)

#' distribution of a quant var: histogram
ggplot(gapminder, aes(x = lifeExp)) + geom_histogram()

#' smooth histogram = densityplot
ggplot(gapminder, aes(x = lifeExp)) + geom_density()

#' show the different continents, but I think it's weird to stack up the
#' histograms, which is what default of `position = "stack"` delivers
ggplot(gapminder, aes(x = lifeExp, fill = continent)) + geom_histogram()

#' `position = "identity"` is good to know about
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

#' densityplots work better in terms of one continent not obscuring another
ggplot(gapminder, aes(x = lifeExp, color = continent)) + geom_density()

#' alpha transparency works here too
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.2)

#' with only two countries, maybe we should ignore Oceania?
ggplot(subset(gapminder, continent != "Oceania"),
       aes(x = lifeExp, fill = continent)) + geom_density(alpha = 0.2)

#' facets work here too
ggplot(gapminder, aes(x = lifeExp)) + geom_density() + facet_wrap(~ continent)

ggplot(subset(gapminder, continent != "Oceania"),
       aes(x = lifeExp, fill = continent)) + geom_histogram() +
  facet_grid(continent ~ .)

#' boxplot for one quantitative variable against a discrete variable  
#' first attempt does not work since year is not formally a factor
ggplot(gapminder, aes(x = year, y = lifeExp)) + geom_boxplot()

#' by explicitly specifying year as the grouping variable, we get what we want
ggplot(gapminder, aes(x = year, y = lifeExp)) + geom_boxplot(aes(group = year))

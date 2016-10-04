#' ---
#' author: "Jenny Bryan"
#' output: github_document
#' ---

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/uni-quant-', error = TRUE)

#' Note: this is rendered by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

#' load the data and ggplot2 (part of the tidyverse)
library(tidyverse)
library(gapminder)
gapminder

#' distribution of a quant var: histogram
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram()

#' experiment with bin width; think in terms of the units of the x variable
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram(binwidth = 1)

#' show the different continents, but it's weird to stack up the
#' histograms, which is what default of `position = "stack"` delivers
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram()

#' `position = "identity"` is good to know about
#' it's still weird to layer them on top of each other like this
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

#' geom_freqpoly() is better in this case
ggplot(gapminder, aes(x = lifeExp, color = continent)) +
  geom_freqpoly()

#' smooth histogram = densityplot
ggplot(gapminder, aes(x = lifeExp)) + geom_density()

#' you should look at different levels of smoothing
ggplot(gapminder, aes(x = lifeExp)) + geom_density(adjust = 1)
ggplot(gapminder, aes(x = lifeExp)) + geom_density(adjust = 0.2)

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

#' try geom_violin() instead and just generally goofing off now
ggplot(gapminder, aes(x = year, y = lifeExp)) +
  geom_violin(aes(group = year)) +
  geom_jitter(alpha = 1/4) +
  geom_smooth(se = FALSE)


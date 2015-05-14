#' ---
#' author: "Jenny Bryan"
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/themes-', error = TRUE)

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)
library(ggthemes)

#' pick a way to load the data
#gdURL <- "http://tiny.cc/gapminder"
#gapminder <- read.delim(file = gdURL) 
#gapminder <- read.delim("gapminderDataFiveYear.tsv")
library(gapminder)
str(gapminder)

#' revisit a plot from earlier
p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
p <- p + scale_x_log10()
p <- p + aes(color = continent) + geom_point() + geom_smooth(lwd = 3, se = FALSE)
p

#' give it a title
p + ggtitle("Life expectancy over time by continent")

#' change overall look and feel with a premade theme
p + theme_grey() # the default

#' suppress the usual grey background
p + theme_bw()

#' exploring some themes from the ggthemes package  
#' https://github.com/jrnold/ggthemes
p + theme_calc() + ggtitle("ggthemes::theme_calc()")
p + theme_economist() + ggtitle("ggthemes::theme_economist()")
p + theme_economist_white() + ggtitle("ggthemes::theme_economist_white()")
p + theme_few() + ggtitle("ggthemes::theme_few()")
p + theme_gdocs() + ggtitle("ggthemes::theme_gdocs()")
p + theme_tufte() + ggtitle("ggthemes::theme_tufte()")
p + theme_wsj() + ggtitle("ggthemes::theme_wsj()")

sessionInfo()
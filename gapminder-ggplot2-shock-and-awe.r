#' ---
#' author: "Jenny Bryan"
#' output:
#'   html_document:
#'     keep_md: TRUE
#' ---

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/shock-awe-', error = TRUE)

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
#gdURL <- "http://tiny.cc/gapminder"
#gapminder <- read.delim(file = gdURL) 
#gapminder <- read.delim("gapminderDataFiveYear.tsv")
library(gapminder)
str(gapminder)

#' drop Oceania
gapminder <- droplevels(subset(gapminder, continent != "Oceania"))

#' Note that the gapminder package ships with color schemes for countries and continents.
head(country_colors)

jYear <- 2007 # this can obviously be changed
jPch <- 21
jDarkGray <- 'grey20'
jXlim <- c(150, 115000)
jYlim <- c(16, 100)

ggplot(subset(gapminder, year == jYear),
       aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10(limits = jXlim) + ylim(jYlim) +
  geom_point(aes(size = sqrt(pop/pi)), pch = jPch, color = jDarkGray,
             show_guide = FALSE) + 
  scale_size_continuous(range=c(1,40)) +
  facet_wrap(~ continent) + coord_fixed(ratio = 1/43) +
  aes(fill = country) + scale_fill_manual(values = country_colors) +
  theme_bw() + theme(strip.text = element_text(size = rel(1.1)))

ggplot(gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(lwd = 1, show_guide = FALSE) + facet_wrap(~ continent) +
  aes(color = country) + scale_color_manual(values = country_colors) +
  theme_bw() + theme(strip.text = element_text(size = rel(1.1)))


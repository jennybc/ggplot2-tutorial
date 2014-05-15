#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/shock-awe-')

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) 
gDat <- read.delim("gapminderDataFiveYear.tsv")
str(gDat)

#' load the color scheme
country_colors <- read.delim("gapminder-country-colors.tsv",
                             colClasses = list(color = "character"))
str(country_colors)

#' drop Oceania
gDat <- droplevels(subset(gDat, continent != "Oceania"))
country_colors <- droplevels(subset(country_colors, continent != "Oceania"))

jYear <- 2007 # this can obviously be changed
jPch <- 21
jDarkGray <- 'grey20'
jXlim <- c(150, 115000)
jYlim <- c(16, 100)

## handy for ggplot2 scale_fill_manual()
jColors <- country_colors$color
names(jColors) <- country_colors$country

ggplot(subset(gDat, year == jYear),
       aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10(limits = jXlim) + ylim(jYlim) +
  geom_point(aes(size = sqrt(pop/pi)), pch = jPch, color = jDarkGray,
             show_guide = FALSE) + 
  scale_size_continuous(range=c(1,40)) +
  facet_wrap(~ continent) + coord_fixed(ratio = 1/43) +
  aes(fill = country) + scale_fill_manual(values = jColors) +
  theme_bw() + theme(strip.text = element_text(size = rel(1.1)))

ggplot(gDat, aes(x = year, y = lifeExp, group = country)) +
  geom_line(lwd = 1, show_guide = FALSE) + facet_wrap(~ continent) +
  aes(color = country) + scale_color_manual(values = jColors) +
  theme_bw() + theme(strip.text = element_text(size = rel(1.1)))


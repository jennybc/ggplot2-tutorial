#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/colors-')

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)
library(RColorBrewer)

#' pick a way to load the data
gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) 
gDat <- read.delim("gapminderDataFiveYear.tsv")
str(gDat)

#' let just look at four countries
jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
x <- droplevels(subset(gDat, country %in% jCountries))
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()

#' reorder the country factor to reflect lifeExp in 2007
x <- transform(x, country = reorder(country, -1 * lifeExp, max))
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()

#' look at the RColorBrewer color palettes
display.brewer.all()

#' focus on the qualitative palettes
display.brewer.all(type = "qual")

#' pick some colors
jColors = brewer.pal(n = 8, "Dark2")[seq_len(nlevels(x$country))]
names(jColors) <- levels(x$country)

#' remake the plot with our new colors
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point() +
  scale_color_manual(values = jColors)

#' pick some super ugly colors for shock value
kColors = c("darkorange2", "deeppink3", "lawngreen", "peachpuff4")
names(kColors) <- levels(x$country)

#' remake the plot with our ugly colors
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point() +
  scale_color_manual(values = kColors)

sessionInfo()
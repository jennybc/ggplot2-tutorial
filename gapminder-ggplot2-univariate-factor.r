#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/uni-factor-')

#' Note: this HTML is made by applying `knitr::spin()` to an R script. So the
#' narrative is very minimal.

library(ggplot2)

#' pick a way to load the data
gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) 
gDat <- read.delim("gapminderDataFiveYear.tsv")
str(gDat)

#' bar charts  
#' consider: no. of observations for each continent
table(gDat$continent)

#' this works because default stat for geom_bar() is "bin"
ggplot(gDat, aes(x = continent)) + geom_bar()

#' let's reorder the continents based on frequency
p <- ggplot(gDat, aes(x = reorder(continent, continent, length)))
p + geom_bar()

#' would you rather the bars run horizontally?
p + geom_bar() + coord_flip()

#' how about a better data:ink ratio?
p + geom_bar(width = 0.05) + coord_flip()

#' consider a scenario where you DON'T want the default "bin" stat, i.e. the bar
#' length or height already exists as a variable
(jDat <- as.data.frame(with(gDat, table(continent, deparse.level = 2))))

#' this simple call no longer works, because we have pre-tabulated
ggplot(jDat, aes(x = continent)) + geom_bar()

#' THIS works when bar length or height already exists
ggplot(jDat, aes(x = continent, y = Freq)) + geom_bar(stat = "identity")

sessionInfo()

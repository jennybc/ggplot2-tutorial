library(plyr)
library(RColorBrewer)                   # will use for color-coding
                                        # continent

## data import from local file
gDat <- read.delim("gapminderDataFiveYear.tsv")

## reach out and touch the data
str(gDat) # 'data.frame':  1704 obs. of  6 variables:

## continent-level info
(cDat <- aggregate(country ~ continent, gDat,
                   function(x) length(unique(x))))
(nCont <- nrow(cDat))

## map continent and country into colors

## choose a range of colors for each continent
#display.brewer.all(type = "div")

color_anchors <-
  list(Africa = brewer.pal(n = 11, 'PuOr')[1:5], # orange/brown/gold
       Americas = brewer.pal(n = 11, 'RdYlBu')[1:5],     # red
       Asia = brewer.pal(n = 11, 'PRGn')[1:5],           # purple
       Europe = brewer.pal(n = 11, 'PiYG')[11:7],        # green
       Oceania = brewer.pal(n = 11, 'RdYlBu')[11:10])    # blue

## retain the first or darkest color to represent the whole continent
cDat$color <- laply(color_anchors, "[", 1)

## expand into palettes big enough to cover each country in a
## continent
country_colors <- ddply(gDat, ~ continent, function(x) {
  the_continent <- x$continent[1]
  x <- droplevels(x)
  countriesBigToSmall <-
    with(x, levels(reorder(country, desc(pop), max)))
  colorFun <- colorRampPalette(color_anchors[[the_continent]])
  return(data.frame(country = I(countriesBigToSmall),
                    color = I(colorFun(length(countriesBigToSmall)))))
})

## make a nice figure of my color scheme

## fiddly parameters that control printing of country names
charLimit <- 12
xFudge <- 0.05
jCex <- 0.75

## store figure making code as a function so can make pdf and png
make_figure <- function() {
  plot(c(0, nCont), c(0, 1), type = "n",
       xlab = "", ylab="", xaxt = "n", yaxt = "n", bty = "n",
       main = "Gapminder Color Scheme")
  for(i in seq_len(nCont)) {
    thisCont <- cDat$continent[i]
    nCols <- with(cDat, country[continent == thisCont])
    yFudge <- 0.1/nCols
    foo <- seq(from = 0, to = 1, length = nCols + 1)
    rect(xleft = i - 1,
         ybottom = foo[-(nCols + 1)],
         xright = i,
         ytop = foo[-1],
         col = with(country_colors, color[continent == thisCont]))
    text(x = i - 1 + xFudge,
         y = foo[-(nCols + 1)] + yFudge,
         labels = with(country_colors,
                       substr(country[continent == thisCont], 1, charLimit)),
         adj = c(0, 0), cex = jCex)
  }
  mtext(cDat$continent, side = 3, at = seq_len(nCont) - 0.5)
  mtext(c("smallest\npop", "largest\npop"),
        side = 2, at = c(0.9, 0.1), las = 1)
}

op <- par(mar = c(1, 4, 6, 1) + 0.1)
make_figure()
par(op)

png("gapminder-country-colors.png",
    width = 7, height = 10, units = "in", res = 200)
op <- par(mar = c(1, 4, 6, 1) + 0.1)
make_figure()
dev.off()
par(op)

pdf("gapminder-country-colors.pdf",
    width = 7, height = 10)
op <- par(mar = c(1, 4, 6, 1) + 0.1)
make_figure()
dev.off()
par(op)

write.table(country_colors, "gapminder-country-colors.tsv",
            quote = FALSE, sep = "\t", row.names = FALSE)

write.table(cDat, "gapminder-continent-colors.tsv",
            quote = FALSE, sep = "\t", row.names = FALSE)


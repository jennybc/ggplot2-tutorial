library(ggplot2)

gdURL <- "http://tiny.cc/gapminder"
gDat <- read.delim(file = gdURL) # pick one
gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)

ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) # nothing to plot yet!

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) # just initializes

p + geom_point()
#p + layer(geom = "point")

## log transformation ... quick and dirty
ggplot(gDat, aes(x = log10(gdpPercap), y = lifeExp)) + geom_point()
p + geom_point() + scale_x_log10() # a bit better

p <- p + scale_x_log10() # let's make that stick

## convey continent by color
p + geom_point(aes(color = continent))
ggplot(gDat, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + scale_x_log10() # in full detail, up to now

## address overplotting
p + geom_point(alpha = (1/3), size = 5)

## add a smooth regression line
p + geom_point() + scale_x_log10() + geom_smooth(lwd = 3, se = FALSE)

p + geom_point() + scale_x_log10() +
  geom_smooth(lwd = 3, se = FALSE, method = "lm")

p + aes(color = continent) + geom_point() + geom_smooth(lwd = 3, se = FALSE)

## connect the dots scatterplot of lifeExp over year for one country
ggplot(subset(gDat, country == "Zimbabwe"),
       aes(x = year, y = lifeExp)) + geom_line() + geom_point()
## geom_path() works here to because our data already sorted on year

## stripplots of lifeExp by continent

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_point()

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_jitter()

ggplot(gDat, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1),
              alpha = 1/4)

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_boxplot()

## distribution of a quant var

ggplot(gDat, aes(x = lifeExp)) + geom_histogram()

ggplot(gDat, aes(x = lifeExp)) + geom_density()

# weird to stack up the histograms?
ggplot(gDat, aes(x = lifeExp, fill = continent)) + geom_histogram()

ggplot(gDat, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

ggplot(gDat, aes(x = lifeExp, color = continent)) + geom_density()

ggplot(gDat, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.2)

## bar chart

table(gDat$continent)
ggplot(gDat, aes(x = continent)) + geom_bar()
ggplot(gDat, aes(x = continent)) + geom_bar() + coord_flip()
ggplot(gDat, aes(x = continent)) + geom_bar(width = 0.05) + coord_flip()

ggplot(gDat, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + geom_bin2d()

# facetting

p + geom_point() + facet_wrap(~ continent)

p + geom_point() + facet_wrap(~ continent) + geom_smooth(lwd = 2, se = FALSE)

ggplot(gDat, aes(x = lifeExp)) + geom_density() +
  facet_wrap(~ continent)

ggplot(gDat, aes(x = lifeExp, fill = continent)) + geom_histogram() +
  facet_wrap(~ continent)

ggplot(subset(gDat, subset = year == 2007),
       aes(x = continent, y = lifeExp)) + geom_point()

ggplot(subset(gDat, subset = year == 2007),
       aes(x = continent, y = lifeExp)) +
  geom_jitter(position = position_jitter(width = .2))



## shock and awe
gdURL <- "http://www.stat.ubc.ca/~jenny/notOcto/STAT545A/examples/gapminder/data/gapminderCountryColors.txt"
countryColors <- read.delim(file = gdURL, as.is = 3) # protect color
str(countryColors)
head(countryColors)
jYear <- 2007 # this can obviously be changed
jPch <- 21
jDarkGray <- 'grey20'
jXlim <- c(150, 115000)
jYlim <- c(16, 100)

## needed for ggplot2 scale_fill_manual()
jColors <- countryColors$color
names(jColors) <- countryColors$country

## needed for lattice cex
jCexDivisor <- 1500                     # arbitrary scaling constant

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


## below here experimental ....

## this needs to be using *my* country colors
ggplot(subset(gDat, subset = year %% 10 == 2 & continent != "Oceania"),
       aes(x = gdpPercap, y = lifeExp, color = country)) +
  geom_point(show_guide = FALSE) +
  scale_x_log10() + facet_grid(continent ~ year)

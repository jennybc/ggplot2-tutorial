#' ---
#' author: "Jenny Bryan"
#' output: github_document
#' ---

#+ setup, include = FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/scatterplot-', error = TRUE)

#' Note: this report is made by rendering an R script. So the narrative is very
#' minimal.

library(tibble)
library(ggplot2)

#' Load the [`gapminder`](https://github.com/jennybc/gapminder) data package.
library(gapminder)
gapminder

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) # nothing to plot yet!

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) # just initializes

#' scatterplot
p + geom_point()

#' log transformation ... quick and dirty
ggplot(gapminder, aes(x = log10(gdpPercap), y = lifeExp)) +
  geom_point()
#' a better way to log transform
p + geom_point() + scale_x_log10()

#' let's make that stick
p <- p + scale_x_log10()
#' common workflow: gradually build up the plot you want  
#' re-define the object 'p' as you develop "keeper" commands  

#' convey continent by color: MAP continent variable to aesthetic color
p + geom_point(aes(color = continent))
## add summary(p)!
plot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + scale_x_log10() # in full detail, up to now

#' address overplotting: SET alpha transparency and size to a value
p + geom_point(alpha = (1/3), size = 3)

#' add a fitted curve or line
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(lwd = 3, se = FALSE)
p + geom_point() + geom_smooth(lwd = 3, se = FALSE, method = "lm")

#' revive our interest in continents!
p + aes(color = continent) + geom_point() +
  geom_smooth(lwd = 3, se = FALSE)

#' facetting: another way to exploit a factor
p + geom_point(alpha = (1/3), size = 3) +
  facet_wrap(~ continent)
p + geom_point(alpha = (1/3), size = 3) +
  facet_wrap(~ continent) +
  geom_smooth(lwd = 2, se = FALSE)

#' exercises:  

#' * plot lifeExp against year  
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  geom_jitter(alpha = 1/3, size = 3)

#' * make mini-plots, split out by continent
#' HINT: use facet_wrap() 
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  facet_wrap(~ continent, scales = "free_x") +
  geom_jitter(alpha = 1/3, size = 3) +
  scale_color_manual(values = continent_colors)

ggplot(subset(gapminder, continent != "Oceania"),
       aes(x = year, y = lifeExp, group = country, color = country)) +
  geom_line(lwd = 1, show_guide = FALSE) + facet_wrap(~ continent) +
  scale_color_manual(values = country_colors) +
  #scale_color_brewer()+
  theme_bw() + theme(strip.text = element_text(size = rel(1.1)))


#' * add a fitted smooth and/or linear regression, w/ or w/o facetting  

ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  facet_wrap(~ continent, scales = "free_x") +
  geom_jitter(alpha = 1/3, size = 3) +
  scale_color_manual(values = continent_colors) +
  geom_smooth(lwd = 2)


#' * use `dplyr::filter()` to plot lifeExp against
#' year for just one country or continent
jc <- "Cambodia"
gapminder %>% 
  filter(country == jc) %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  labs(title = jc) +
  geom_line()

rwanda <- gapminder %>%
  filter(country == "Rwanda")
p <- ggplot(rwanda, aes(x = year, y = lifeExp)) +
  labs(title = "Rwanda") +
  geom_line()
print(p)
ggsave("rwanda.pdf")
ggsave("rwanda.pdf",plot = p)

#' * other ideas?  










#' plot lifeExp against year
(y <- ggplot(gapminder, aes(x = year, y = lifeExp)) + geom_point())

#' make mini-plots, split out by continent
y + facet_wrap(~ continent)

#' add a fitted smooth and/or linear regression, w/ or w/o facetting
y + geom_smooth(se = FALSE, lwd = 2) +
  geom_smooth(se = FALSE, method ="lm", color = "orange", lwd = 2)

y + geom_smooth(se = FALSE, lwd = 2) +
  facet_wrap(~ continent)

#' last bit on scatterplots  
#' how can we "connect the dots" for one country?  
#' i.e. make a spaghetti plot?
y + facet_wrap(~ continent) + geom_line() # uh, no
y + facet_wrap(~ continent) + geom_line(aes(group = country)) # yes!
y + facet_wrap(~ continent) + geom_line(aes(group = country)) +
  geom_smooth(se = FALSE, lwd = 2) 

#' note about subsetting data

#' sadly, ggplot() does not have a 'subset =' argument  
#' so do that 'on the fly' with subset(..., subset = ...)
ggplot(subset(gapminder, country == "Zimbabwe"),
       aes(x = year, y = lifeExp)) + geom_line() + geom_point()

#' or could do with dplyr::filter
suppressPackageStartupMessages(library(dplyr))
ggplot(gapminder %>% filter(country == "Zimbabwe"),
       aes(x = year, y = lifeExp)) + geom_line() + geom_point()

#' let just look at four countries
jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
ggplot(subset(gapminder, country %in% jCountries),
       aes(x = year, y = lifeExp, color = country)) + geom_line() + geom_point()

#' when you really care, make your legend easy to navigate  
#' this means visual order = data order = factor level order
ggplot(subset(gapminder, country %in% jCountries),
       aes(x = year, y = lifeExp, color = reorder(country, -1 * lifeExp, max))) +
  geom_line() + geom_point()

#' another approach to overplotting
#' ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + geom_bin2d()

sessionInfo()
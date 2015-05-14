Jenny Bryan  



Note: this HTML is made by applying `knitr::spin()` to an R script. So the
narrative is very minimal.


```r
library(ggplot2)
library(RColorBrewer)
```

pick a way to load the data


```r
#gdURL <- "http://tiny.cc/gapminder"
#gapminder <- read.delim(file = gdURL) 
#gapminder <- read.delim("gapminderDataFiveYear.tsv")
library(gapminder)
str(gapminder)
```

```
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ year     : num  1952 1957 1962 1967 1972 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

let just look at four countries


```r
jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
x <- droplevels(subset(gapminder, country %in% jCountries))
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()
```

![](figure/colors-unnamed-chunk-3-1.png) 

reorder the country factor to reflect lifeExp in 2007


```r
x <- transform(x, country = reorder(country, -1 * lifeExp, max))
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()
```

![](figure/colors-unnamed-chunk-4-1.png) 

look at the RColorBrewer color palettes


```r
display.brewer.all()
```

![](figure/colors-unnamed-chunk-5-1.png) 

focus on the qualitative palettes


```r
display.brewer.all(type = "qual")
```

![](figure/colors-unnamed-chunk-6-1.png) 

pick some colors


```r
jColors = brewer.pal(n = 8, "Dark2")[seq_len(nlevels(x$country))]
names(jColors) <- levels(x$country)
```

remake the plot with our new colors


```r
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point() +
  scale_color_manual(values = jColors)
```

![](figure/colors-unnamed-chunk-8-1.png) 

pick some super ugly colors for shock value


```r
kColors = c("darkorange2", "deeppink3", "lawngreen", "peachpuff4")
names(kColors) <- levels(x$country)
```

remake the plot with our ugly colors


```r
ggplot(x, aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point() +
  scale_color_manual(values = kColors)
```

![](figure/colors-unnamed-chunk-10-1.png) 

```r
sessionInfo()
```

```
## R version 3.1.2 (2014-10-31)
## Platform: x86_64-apple-darwin10.8.0 (64-bit)
## 
## locale:
## [1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] gapminder_0.1.0    RColorBrewer_1.0-5 ggplot2_1.0.0     
## [4] knitr_1.10.5      
## 
## loaded via a namespace (and not attached):
##  [1] colorspace_1.2-4  digest_0.6.8      evaluate_0.7     
##  [4] formatR_1.2       grid_3.1.2        gtable_0.1.2     
##  [7] htmltools_0.2.6   labeling_0.3      magrittr_1.5     
## [10] MASS_7.3-35       munsell_0.4.2     plyr_1.8.2       
## [13] proto_0.3-10      Rcpp_0.11.6       reshape2_1.4.0.99
## [16] rmarkdown_0.5.1   scales_0.2.4      stringi_0.4-1    
## [19] stringr_1.0.0     tools_3.1.2       yaml_2.1.13
```


---
title: "gapminder-ggplot2-colors.r"
author: "jenny"
date: "Thu May 14 12:58:27 2015"
---

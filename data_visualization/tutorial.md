# Data visualization in R

Authored by Taylor Dunivin for [EDAMAME2018](https://github.com/edamame-course/2018-tutorials/wiki)

***
EDAMAME tutorials have a CC-BY [license](https://github.com/edamame-course/2015-tutorials/blob/master/LICENSE.md). _Share, adapt, and attribute please!_
***

## Overarching Goal
* This tutorial will contribute towards understanding of best practices and fundamentals of data visualization 

## Learning Objectives
* Become familiar with RStudio
* Best practives for data organization
* Understand grammar of graphics
* Visualizing different types of data in R
* Saving publication-ready plots

## Required tools
* [R](https://cran.r-project.org/mirrors.html)
* [RStudio](https://www.rstudio.com/products/rstudio/download/#download)

## Helpful resources
* [R for Data Science](http://r4ds.had.co.nz/index.html)
* [Fundamentals of Data Visualization](http://serialmentor.com/dataviz/index.html)

## Extra practice
* [2017 EDAMAME tutorials](http://germslab.org/datavisualization/index.html)
* [Complete ggplot2 tutorial](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html)

## Installing and loading packages
ggplot is not part of “base R”; rather it is a package – a library of functions that an R user wrote. This extensibility is part of the beauty of R. As of December 2016, there are 9,600 such packages in the official Comprehensive R Archive Network, better known as CRAN.

ggplot is one of the most popular packages for R. It is part of a suite of R tools that make up “The Tidyverse”. Its author conveniently bundled these tools together in a super-package called tidyverse. To use the tidyverse tools, you first need to download them to your machine (once) and then load them (each R session you want to use them). To install tidyverse use the `install.packages` function: 

```
install.packages("tidyverse")
```

Whenever you want to use a package, you have to load it in your R session. For that, use the library function:

```
library(tidyverse)
```

Notice how we did not use quotes this time. This is because "" in R refer to things outside of R. Before installing, tidyverse was outside of R. Once installed, R "knows about" tidyverse, so quotes are no longer needed. 

* __Pro tip:__ It is a good idea to load all required packages at the beginning of an R script. This helps people who are using your code know what they need to load/ install. 

 
## Reading in/ tidying data
For this tutorial we will use *real* data! This is gene abundance data from a site in Centralia, PA. If you cloned this repository, you should have the data file in your `data` folder (`gene_abundance_centralia.txt`). It tells us the normalized abundance for each Site (13 total) and each gene (9 total).

### Reading in data
Let's read in our gene abundance data:

```
data <- read_delim("data/gene_abundance_centralia.txt", delim = "\t")
```

* __Pro tip:__ `Alt` +  `-` (or `option` + `-` for mac) will insert ` <- `. While ` <- ` and `=` *technically* interchangable when assigning a variable, it is useful to use ` <- ` for assignment operators since `=` is used for assigning arguments *within* a function.  

This data, like most data you will work with, does not have all of our information. For your own study system, you probably have (or need to make) a mapping file that details metadata for each site/ sample. In this case, we have information on the fire history of each site and the temperature of each site. Let's read in our metadata:
```
meta <- read_delim("data/Centralia_temperature.txt", delim = "\t")
```

### Annotating your data
Let's add our metadata to our data. Here we will assign a new variable using ` <- `. We will also use a pipe `%>%`, which means "then do" in R. The code reads as follows take `data` then do a `left_join` with `meta` by the `Site` column. 

```
data.annotated <- data %>%
  left_join(meta, by = "Site")
```

### Saving a table
You might want to save this annotated data so that you have it handy in the future. We will export it here:

```
write.table(data.annotated, "output/gene_data_annotated.txt", sep = "\t", row.names = FALSE, quote = FALSE)
```

* We have exported it to our output folder for organizational purposes
* You can call the file whatever you want. We recomend using a useful file extension. For tab delimited file, `.txt` or `.tsv` is appropriate; for a comma separated file, `.csv` is appropriate
* You can specify your own separation with `sep = `
* We added `row.names = FALSE` and `quote = FALSE` to clean up the output file. Try to save it without these, and see what you get!

## Subsetting data
To start plotting, we will use the simplest form of data (ie one gene only). 

```
geneA <- data.annotated %>%
  subset(Gene == "arsM")
```

* __Activity 1:__ what does this line of code say? 

## Basic plotting with ggplot
Let's talk a little about the grammar of graphics and how plotting is structured in the `ggplot2` package.

Now that we know what to expect, let's plot stuff! The `ggplot` command is used to plot graphs in R... let's try it with our tiny dataset `geneA`:

```
ggplot(geneA)
```
![simple plot](https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_plot.png)

Looks like we need to add some aesthetics using `aes`. To start, we will use `Fire_history` as our x-value and `Normalized.abundance` for our y-value

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance))
```
![xy plot](https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_plot_xy.png)

* __Checkpoint:__ _What type of data is this? What's missing here?_

## Adding Geometric layers
Geometric layers are added with functions that have a `geom_` prefix. Let's try adding points to our plot:

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 
```
![geom_point](https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_points.png)

* __Pro tip:__ it seems like a `%>%` would be appropriate to use here, but unfortunately, `ggplot` was created before the pipe existed. To layer in `ggplot`, you *must* use `+`
* __Checkpoint:__ _What's a better way of looking at this data?_
* __Activity 2:__ Let's try a boxplot instead of a point.

![boxplot](https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_boxplot.png)

Boxplots are more useful than bars for this data because they show the variability. Even still, we might want to add points *on top of* the boxplots so that readers can see the points as well. 
* __Checkpoint:__ _How do we add points to this plot? How can we control what is the top layer?_

![boxplotpoint](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_point.png)

This plot still does not highlight all of our information. The points are too small, too close together, and hard to see over the black lines of the boxplots.

* __Pro tip:__ When there are a lot of points with similar y-values and when the x-value is categorical, it can be helpful to spread them out. This is done with a different geom: `geom_jitter`
* __Activity 3:__ Make a boxplot with jittered points that are larger and colored

![boxplot_jitter](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_better.png)

* __Checkpoint:__ _How would we know what our options are within a function? Why is the color in quotes?_

## Aesthetic layers
We are already a little familiar with aesthetics since we used `aes` to designate our x and y values. Based on this, _can you guess when it is appropriate to use `aes`?

* __Activity 4:__ let's add color to the plot based on the temperature of a site.

![boxplot_jitter_temp](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp.png)

* __Checkpoint:__ _Where is the best place to designate color? Why?_


## Scale layers
Our plot is looking good! Let's control the temperature color so that it's easier to see. For this we would use `scale_color_continuous` 

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red")
```

![boxplot_jitter_temp_better](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp_better.png)

* __Checkpoint:__ _What scale would we use if we did not have continuous data?_  
* __Pro tip :__ You can explore different options by hitting the tab key. For example, to explore different `scale` functions, type `scale` and hit `tab`. An options list should come up. 
* __Pro tip:__ You can do this within a function as well! For example, `scale_color_continuous(` and `tab` will bring up options such as `low` and `high`, which we used in this function!
* __Pro tip:__ To find full information on a function, use a `?`. For example `?scale_color_continuous`. To search for packages, use `??` instead. 

## Coordinate layers
As the name implies, coordinate layers impact the *coordinates* of a plot. 

* __Pro tip:__ It is recomended to flip coordinates when labels for your x values are long and difficult to read
* __Activity 5:__ flip the x and y coordinates

![boxplot_jitter_temp_flip](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp_flip.png)


## Facet layers
As microbial ecologists, you probably are working with more than one gene (or taxonomic group or organism) at a time. This makes faceting very useful. The word facet literally means side or plane. Thus, faceting in R will will separate your plot into multiple panels to show the different sides/ planes of your data. To explore faceting, let's go back to our full dataset `data.annotated`. As you might expect, facet functions begin with the prefix `facet_`. 

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene)
```
![boxplot_facet](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_facet_fixed.png)

* __Pro tip:__ the `~` in R essentially translates to "by". The above line reads "facet_wrap by column Gene"
* __Checkpoint:__ _How can we improve this plot? Are we missing/distorting any of our data?_
* __Checkpoint:__ _How could we look at options for faceting?_

![boxplot_facet_free](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_facet_free.png)

## Theme layers
With an additional line of code, you can easily change the "ambience" or theme of your plot. Theme functions have the prefix `theme`.

* __Activity 6:__ change the theme of your plot
* __Activity 6.5 (optional):__ install and load `ggthemes` and explore even *more* themes!

Another function `theme` can be used to make your own theme OR adjust an existing theme. Let's use `theme` to adjust our x-axis for readability

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
```
![boxplot_theme](https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_bw_angle.png)



## Label layers
It can be annoying to have spaces within data in R. We get around this by using `.` or `_` as spaces, but those are not ideal when publishing a figure. Label or `lab` functions can be used to easily adjust labels on a plot. Let's try some:

``` 
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
  ylab("Normalized abundance") +
  xlab("Fire history") +
  labs(color = "Temperature (°C)") 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/gene.boxplot.png" width="600">

* __Checkpoint__: _What if we wanted to change a shape label?_

## Saving a plot
Now that you have a beautiful plot, you'll probably want to save it! R makes this very easy with function `ggsave`.

First, we need to save our plot as an object. Based on our object assignment earlier, _how do we save the plot in our R environment?_

```
boxplot <- ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
  ylab("Normalized abundance") +
  xlab("Fire history") +
  labs(color = "Temperature (°C)")
```
* __Pro tip:__ Saving a plot as an object can be frustrating since the plot saves without opening. If you put `(` `)` around the code, the plot will both save *and* print!

Now let's save our `boxplot` to our computer:
```
ggsave(boxplot, filename = "figures/gene.boxplot.eps", units = "in", width = 6, height = 4)
```
The above code reads save boxplot as an `.eps` file called `gene.boxplot.eps` in the folder `figures`, and make this file 6 inches wide and 4 inches tall. 
* __Pro tip:__ `ggsave` will make the file based on the extension you give it. For example, saving as `gene.boxplot.png` saves a `.png` file

## Example 2: bar charts
Using the same data, let's make some bar charts. When using bar charts, we need to consider mapping parameters such as what statistic or `stat` to use. `geom_bar` defaults to stat count, which means it will count the number of instances a particular x value occurs. We can visualize this with our tiny dataset:
```
ggplot(geneA, aes(x = Fire_history)) +
  geom_bar() 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/simple_bar.png" width="400">


The plot should show that we have 7 fire affected sites, 5 recovered sites, and one reference site. Be careful with `geom_bar`... look what happens if we used this same code on the full dataset:
```
ggplot(data.annotated, aes(x = Fire_history)) +
  geom_bar() 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/simple_bar_full.png" width="400">

* __Checkpoint:__ _Do we actually have > 60 fire affected sites? Why does it look like this?_

Hint: try the following code
```
ggplot(data.annotated, aes(x = Fire_history)) +
  geom_bar() +
  facet_wrap(~Gene)
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/facet_bar.png" width="500">

Up to this point, we have used `color` to add color to a plot, but `geom_bar` is a great function to examine the difference between `color` and `fill`. Let's compare them on our bar chart to get an idea of what it does
```
ggplot(geneA, aes(x = Fire_history)) +
  geom_bar(color = "black") 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/bar_color.png" width="400">

now try fill
```
ggplot(geneA, aes(x = Fire_history)) +
  geom_bar(fill = "black")
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/bar_fill.png" width="400">

* __Pro tip:__ either `color` or `fill` can be used to color points.

It's often useful to use color to highlight separation of different colors of a bar chart. Let's look at all of our genes in a site
```
ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", aes(fill = Gene)) 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/stacked_bar_fill.png" width="400">

* __Checkpoint:__ _Why is `color` outside of `aes` here? Why is `fill` inside `aes`?_

In addition to `stat` mappings, `geom_bar` also offers `position` mapping. The default is `position = "stack"`.

```
ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "stack", aes(fill = Gene)) 
```

* __Checkpoint__ _What is the difference between "dodge" and "fill" with position mapping?_
  * Try `position = "dodge"`
  * Now try `position = "fill"` 

* __Activity 7:__ Make a pie chart of all of our genes within one sample
  * Hint 1: You can subset your data within ggplot!
  * Hint 2: What layer do we use to change coordinates?

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/pie.png" width="600">


## Challenge #1
Using the same data, make this graph:
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/challenge1.png" width="600">

## Challenge #2
Using the same data, make this graph:
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/challenge2.png" width="600">


## Answer key
### Activity 1
Take `data.annotated` then `subset` so that column `Gene` only includes "arsM"  

### Activity 2
Change the `geom` applied to the plot. Since we want to visualize a boxplot, we will use `geom_boxplot()` instead of `geom_point()`.

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() 
```

### Activity 3
To add points on top of a boxplot, you should add a line with `geom_boxplot` _first_. Next add a line for `geom_point()`. In this case, we want our points to be a bit spread out, so we will use `geom_jitter()` instead. To enlarge the points, we will set `size = 3`; to add red color to the point, use the argument `color = "red"`; to adjust the width of the jitter, use `width = 0.2`. Numbers do not need quotes, but since colors are "outside of R", we use `""`.

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, color = "red", width = 0.2) 
```

__Note:__ as is, the code only changes the color of the points. If you wanted both the points and the boxplot to be red, you could set the color in the `ggplot` umberella. For example: 

```
ggplot(geneA, color = "red", aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2) 
```

### Activity 4
Here we want to add color that is based on _our_ data, not an arbitrarily (like `"red"`). To achieve this, simlpy put the color argument *within* an aesthetics (`aes`) argument. 
```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) 
```

### Activity 5
To control coordinates, we use `coord` functions. As the name implies, adding layer `coord_flip()` will flip your coordinates. 

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  coord_flip()
```

### Activity 6
Explore theme layers by typing `theme` + `tab` and select any theme you want! See below for an example using `theme_bw()`.

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw()
```

### Activity 6.5
Explore even more themes! More themes are included in package `ggthemes`. Install and load this package before exploring. See below for an example with a theme based on the Wall Street Journal:

```
install.packages("ggthemes")
library(ggthemes)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_wsj()
```

### Activity 7
Subset your data first to include only one site. This can be done one of two ways:
option1:
```
ggplot(subset(data.annotated, Site == "Cen01"), aes(x = Site, y = Normalized.abundance))
```

option2:
```
data.annotated %>%
subset(Site == "Cen01") %>%
ggplot(aes(x = Site, y = Normalized.abundance))
```


Converting a bar chart to a pie chart changes the plot coordinates, so we use a `coord` function (`coord_polar`). For additional aesthetics, you can simplify the theme by adding a `theme_void()` layer and removing the x-axis text with `theme(axis.text.x=element_blank())`. 

```
ggplot(subset(data.annotated, Site == "Cen01"), aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black",  aes(fill = Gene), width = 1) +
  coord_polar(start = 0, "y") +
  theme_void() +
  theme(axis.text.x=element_blank())
```

### Challenge 1
```
ggplot(data.annotated, aes(x = Temperature, y = Normalized.abundance)) +
  geom_smooth(method = "lm", linetype = "dashed", color = "black") +
  geom_point(size = 3, aes(shape = Fire_history, color = Gene)) +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  xlab("Temperature (°C)") +
  ylab("Normalized abundance")
```

### Challenge 2
```
ggplot(data.annotated, aes(x = Site, y = Gene)) +
  geom_point(aes(size = Normalized.abundance, color = Temperature)) +
  geom_point(aes(size = Normalized.abundance), shape = 1, color = "black") +
  scale_color_continuous(low = "yellow", high = "red") +
  theme_bw() +
  coord_flip()
```

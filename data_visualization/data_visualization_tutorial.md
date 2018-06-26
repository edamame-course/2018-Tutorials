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
* Understand [grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.pdf)
* Visualizing different types of data in R
* Saving publication-ready plots

## Required tools
* [R](https://cloud.r-project.org/)
* [RStudio](https://www.rstudio.com/products/rstudio/download/#download)

## Helpful resources
* [R for Data Science](http://r4ds.had.co.nz/index.html)
* [Fundamentals of Data Visualization](http://serialmentor.com/dataviz/index.html)

## Extra practice
* [2017 EDAMAME tutorials](http://germslab.org/datavisualization/index.html)
* [Complete ggplot2 tutorial](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html)

## Before you begin
Make sure you go through the [Intro R](https://github.com/edamame-course/2018-Tutorials/edit/master/Intro_R_RStudio/R_tutorial.md) tutorial! 

If you really want to skip that tutorial, you will still need to set up your R environment. See below:
```
#load required packages
library(tidyverse)

# read in data file
data <- read_delim("data/gene_abundance_centralia.txt", delim = "\t")

# read in meta data
meta <- read_delim("data/Centralia_temperature.txt", delim = "\t")

#annotate data (join data and metadata)
data.annotated <- data %>%
  left_join(meta, by = "Site")
  
# subset data to include only one gene
geneA <- data.annotated %>%
  subset(Gene == "arsM")
```

## DATA layers: Basic plotting with ggplot
Let's talk a little about the grammar of graphics and how plotting is structured in the `ggplot2` package.

Now that we know what to expect, let's plot stuff! The `ggplot` command is used to plot graphs in R... let's try it with our tiny dataset `geneA`:

```
ggplot(geneA)
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_plot.png" width="400">

Looks like we need to add some aesthetics using `aes`. To start, we will use `Fire_history` as our x-value and `Normalized.abundance` for our y-value

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance))
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_plot_xy.png" width="400">

* __Checkpoint:__ _What type of data is this? What's missing here?_

## GEOMETRIC layers
Geometric layers are added with functions that have a `geom_` prefix. Let's try adding points to our plot:

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_points.png" width="400">

* __Pro tip:__ it seems like a `%>%` would be appropriate to use here, but unfortunately, `ggplot` was created before the pipe existed. To layer in `ggplot`, you *must* use `+`
* __Checkpoint:__ _What's a better way of looking at this data?_
* __Activity 2:__ Let's try a boxplot instead of a point.

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/plain_boxplot.png" width="400">

Boxplots are more useful than bars for this data because they show the variability. Even still, we might want to add points *on top of* the boxplots so that readers can see the points as well. 
* __Checkpoint:__ _How do we add points to this plot? How can we control what is the top layer?_

This plot still does not highlight all of our information. The points are too small, too close together, and hard to see over the black lines of the boxplots.

* __Pro tip:__ When there are a lot of points with similar y-values and when the x-value is categorical, it can be helpful to spread them out. This is done with a different geom: `geom_jitter`
* __Activity 3:__ Make a boxplot with jittered points that are larger and colored

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_better.png" width="400">

* __Checkpoint:__ _How would we know what our options are within a function? Why is the color in quotes?_

## AESTHETIC layers
We are already a little familiar with aesthetics since we used `aes` to designate our x and y values. Based on this, _can you guess when it is appropriate to use `aes`?

* __Activity 4:__ let's add color to the plot based on the temperature of a site.

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp.png" width="400">

* __Checkpoint:__ _Where is the best place to designate color? Why?_


## Adjusting scales
Our plot is looking good! Let's control the temperature color so that it's easier to see. For this we would use `scale_color_continuous` 

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red")
```

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp_better.png" width="400">


* __Checkpoint:__ _What scale would we use if we did not have continuous data?_  
* __Pro tip :__ You can explore different options by hitting the tab key. For example, to explore different `scale` functions, type `scale` and hit `tab`. An options list should come up. 
* __Pro tip:__ You can do this within a function as well! For example, `scale_color_continuous(` and `tab` will bring up options such as `low` and `high`, which we used in this function!
* __Pro tip:__ To find full information on a function, use a `?`. For example `?scale_color_continuous`. To search for packages, use `??` instead. 

## COORDINATE layers
As the name implies, coordinate layers impact the *coordinates* of a plot. 

* __Pro tip:__ It is recomended to flip coordinates when labels for your x values are long and difficult to read
* __Activity 5:__ flip the x and y coordinates

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_jitter_temp_flip.png" width="400">


## FACET layers
As microbial ecologists, you probably are working with more than one gene (or taxonomic group or organism) at a time. This makes faceting very useful. The word facet literally means side or plane. Thus, faceting in R will will separate your plot into multiple panels to show the different sides/ planes of your data. To explore faceting, let's go back to our full dataset `data.annotated`. As you might expect, facet functions begin with the prefix `facet_`. 

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene)
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_facet_fixed.png" width="600">

* __Pro tip:__ the `~` in R essentially translates to "by". The above line reads "facet_wrap by column Gene"
* __Checkpoint:__ _How can we improve this plot? Are we missing/distorting any of our data?_
* __Checkpoint:__ _How could we look at options for faceting?_

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_facet_free.png" width="600">

## THEME layers
With an additional line of code, you can easily change the "ambience" or theme of your plot. Theme functions have the prefix `theme`.

* __Activity 6:__ change the theme of your plot
* __Activity 6.5 (optional):__ install and load `ggthemes` and explore even *more* themes!

Another function `theme` can be used to make your own theme OR adjust an existing theme. Let's use `theme` to adjust our x-axis for readability

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))
```
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/boxplot_bw_angle.png" width="600">



## Labeling 
It can be annoying to have spaces within data in R. We get around this by using `.` or `_` as spaces, but those are not ideal when publishing a figure. Label or `lab` functions can be used to easily adjust labels on a plot. Let's try some:

``` 
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
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
<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/stacked_bar_fill.png" width="600">

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

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/pie.png" width="500">


## Challenge #1
Using the same data, make this graph:
<space/>
<space/>


<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/challenge1.png" width="600">

## Challenge #2
Using the same data, make this graph:
<space/>
<space/>

<img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/challenge2.png" width="600">


## Answer key
### Activity 1
Take `data.annotated` then `subset` so that column `Gene` only includes "arsM"  

***

### Activity 2
Change the `geom` applied to the plot. Since we want to visualize a boxplot, we will use `geom_boxplot()` instead of `geom_point()`.

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() 
```

***

### Activity 3
To add points on top of a boxplot, you should add a line with `geom_boxplot` _first_. Next add a line for `geom_point()`. In this case, we want our points to be a bit spread out, so we will use `geom_jitter()` instead. To enlarge the points, we will set `size = 2`; to add red color to the point, use the argument `color = "red"`; to adjust the width of the jitter, use `width = 0.2`. Numbers do not need quotes, but since colors are "outside of R", we use `""`.

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, color = "red", width = 0.2) 
```

__Note:__ as is, the code only changes the color of the points. If you wanted both the points and the boxplot to be red, you could set the color in the `ggplot` umberella. For example: 

```
ggplot(geneA, color = "red", aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2) 
```

***

### Activity 4
Here we want to add color that is based on _our_ data, not an arbitrarily (like `"red"`). To achieve this, simlpy put the color argument *within* an aesthetics (`aes`) argument. 
```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) 
```

***

### Activity 5
To control coordinates, we use `coord` functions. As the name implies, adding layer `coord_flip()` will flip your coordinates. 

```
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  coord_flip()
```

***

### Activity 6
Explore theme layers by typing `theme` + `tab` and select any theme you want! See below for an example using `theme_bw()`.

```
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw()
```

***

### Activity 6.5
Explore even more themes! More themes are included in package `ggthemes`. Install and load this package before exploring. See below for an example with a theme based on the Wall Street Journal:

```
install.packages("ggthemes")
library(ggthemes)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_wsj()
```

***

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

***

### Challenge 1
```
ggplot(data.annotated, aes(x = Temperature, y = Normalized.abundance)) +
  geom_smooth(method = "lm", linetype = "dashed", color = "black") +
  geom_point(size = 2, aes(shape = Fire_history, color = Gene)) +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  xlab("Temperature (°C)") +
  ylab("Normalized abundance")
```

***

### Challenge 2
```
ggplot(data.annotated, aes(x = Site, y = Gene)) +
  geom_point(aes(size = Normalized.abundance, color = Temperature)) +
  geom_point(aes(size = Normalized.abundance), shape = 1, color = "black") +
  scale_color_continuous(low = "yellow", high = "red") +
  theme_bw() +
  coord_flip()
```


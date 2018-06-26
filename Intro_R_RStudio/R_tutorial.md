# Introduction to R and RStudio

Authored by Taylor Dunivin for [EDAMAME2018](https://github.com/edamame-course/2018-tutorials/wiki). This tutorial was based on a previous [EDAMAME tutorial](http://germslab.org/datavisualization/01-intro-r-rstudio.html) and [Software carpentry tutorials](http://data-lessons.github.io/gapminder-R/).

***
EDAMAME tutorials have a CC-BY [license](https://github.com/edamame-course/2015-tutorials/blob/master/LICENSE.md). _Share, adapt, and attribute please!_
***

## Overarching Goal
* This tutorial will contribute towards use of R and RStudio

## Learning Objectives
* Appreciate why a scientist writes code and why R specifically
* Become familiar with RStudio
* Manage your workspace in an interactive R session
* Understand variables and how to assign to them
* Be able to seek help via ? and Google
* Be able to read data into R
* Be able to examine the structure and content of a data frame.

## Required tools
* [R](https://cloud.r-project.org/)
* [RStudio](https://www.rstudio.com/products/rstudio/download/#download)

## Helpful resources
* [Cookbook for R](http://www.cookbook-r.com/)
* [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/)
* [2017 EDAMAME tutorials](http://germslab.org/datavisualization/index.html)

## Why use R?
* free
* open-source 
* designed for data analysis and statistics
* highly extensible
* easy organization with RStudio
* user-community
  * [r-bloggers.com](www.r-bloggers.com)
  * twitter: [@hadleywickham](@hadleywickham) [@rstudiotips](@rstudiotips)
  * [support.rstudio.com](https://support.rstudio.com/hc/en-us)
 
***
## RStudio: an interactive development environment for R
See below for an example of what RStudio looks like. 
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/RStudio_diagram.jpg" width="600"> 

### Workspace/history (upper right)
This space might have 2 or more tabs which show different aspects of R
  * __Environment__: Your current R environment. This will list any objects you assigned.
  * __History__: Your current R history. This will list key strokes entered into the Console
  * __Git__: If you have set up GitHub with your RStudio for version control, you will also see a `Git` tab. This is where you can check in with GitHub in your RStudio. If you are interested in configuring your RStudio to include Git, [here](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN) is a helpful tutorial form R Support. 
  
### Help (lower right)
This space has different tabs designed to help you use R.
  * __Files__: Files in your current working directory. 
  * __Plots__: Visualization of plots. We will use this tab a lot in our [data visualization](https://github.com/edamame-course/2018-Tutorials/blob/master/data_visualization/data_visualization_tutorial.md) tutorial
  * __Help__: Help search window that can be used interactively or can be called on through the console.
  * __Viewer__: Tab for local web content. [More info](https://support.rstudio.com/hc/en-us/articles/202133558-Extending-RStudio-with-the-Viewer-Pane)

### Console (left or bottom left)
The console is similar to running R in your command line. This is where all of your code is run (even if you are using a script). 
* Directly typing into the console is useful for running commands that you do not need to repeat. For example viewing a file.
*  Directly typing into the console is *not* useful for reproducible executing an existing workflow or writing your own R workflow. It will save you time and energy to use R scripts instead. 

### Script (upper left)
An R script is a text file with a `.R` extension that contains R code. This is a great place to save your R code! `.R` scripts allow others to reproduce your code *and* lets you easily revisit old workflows. 

If you do not see a script in the upper left corner of RStudio, you can create new R script (`File -> New File -> R Script` or `ctrl` + `shift` + `N` (`cmd` + `shift` + `N` for mac)) or open an existing script (`File -> Open File -> YOUR_SCRIPT.R` ).

If you run code from a script, it will show in the console! 
* `ctrl` + `enter` (or `cmd` + `enter` for mac) will execute one line of code from a script 
* If you highlight several lines of code, `ctrl` + `enter` (or `cmd` + `enter` for mac) will run all of the highlighted portion
* You do *not* need to highlight several lines of code when `%>%` or `+` is used, but we'll go over this in more detail later

***
__Pro tip:__ There are tons of useful keyboard shortcuts in addition to `ctrl/cmd` + `enter`. Here is an [R support page](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts) with default shortcuts.
***

## Organization in RStudio: Projects
R projects are *amazing*! Projects are a special feature of RStudio that allow you to make a special home for all of the code, data, workspace, R history, and more for one project! 

### Why use R Projects
People often cite R projects as par of "best practices" for reproducible workflows. Here's why:

* Automatically sets working directory to project directory
  * this is especially useful for sharing code
* Version control friendly
  * If you're using GitHub for version control, projects automatically create a `.gitignore` file
* Saves your R environment for a particular project
  * This is useful when you are working on multiple projects at once (aka you're a scientist). You can work on one project in RStudio without mixing your R `Environment`
* Run multiple RStudio's at once and literally work on two projects at the same time
  * <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/rproj_dock.png" width="600"> 


### Creating an R Project
Creating an R Project will result in a `.Rproj` file that is by default named after the directory it is in.

* To create a new R project, select `File -> New Project`, and a page like this should come up
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/rproject.png" width="400"> 


* Here you can make a new directory for a project, use an existing directory you've been workin in, or even a version controlled directory (think GitHub)

### More information
Can't get enough of R projects? Great! We'll use one in our [data visualization](https://github.com/edamame-course/2018-Tutorials/blob/master/data_visualization/data_visualization_tutorial.md) tutorial. Also check out [RStudio support](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) for even more information on R Projects!

***
## The basics
For a short tutorial on the basics of R (arithmetic, comparisons, variables) see last [year's tutorial](http://germslab.org/datavisualization/01-intro-r-rstudio.html).

***

## Using R: Packages
An R package is a bungle of R functions, data, and code that R users can install and use in their own work.  

One of the reasons R is widely used in *many* fields is the existence of R packages. There are over 10,000! See below for a graph from Gergely Daróczi showing the number of packages over time. 
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/packages.png" width="400"> 

Installing R/ RStudio does not automatically give you all R packages, only a few that are considered part of "base R." In fact, it is likely that you will never use most R packages since many are field specific. Instead, you need to install any package you are interested in using. Installing packages requires the function `install.packages()`.

Let's try it by installing a common package: `tidyverse`. This package is unique in that its author bundled *many* tools together (`ggplot2`,`dplyr`,`readr`, and more!) in a super-package called tidyverse.
```
install.packages("tidyverse")
```

Congratulations! With one line of code, you have installed *many* useful R packages, but you are not ready to use these packages quite yet. Whenever you want to use a package, you have to load it in your R session. For that, use the `library()` function:
```
library(tidyverse)
```
Now `tidyverse` is loaded and ready for use!

Notice how we did not use quotes this time. This is because `""` in R typically refer to things outside of R. Before installing, tidyverse was outside of R. Once installed, R "knows about" tidyverse, so quotes are no longer needed. 

***
__Pro tip:__ It is a good idea to load all required packages at the beginning of an `.R` script. This helps people who are using your code know what they need to load/ install. 
***

## Data types and structure in R
R recognizes several types of data/information
* Numeric
  * integer
  * double
* Logical
* Character
* Factor (a character with *levels*)

These data types can be put into different data structures based on their dimensions and how many types of data they contain.
<br/>
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/R_data_structures.png" width="400"> 

Now that we can get around a little in R, let's play with some data! As microbial ecologists, you will often work with tables of data such as data frames/ tibbles, so we will explore these now.

***

## Reading data into R
In this section, we will focus on reading dataframes/ tibbles into R. In other words, we will read in some data that is multi-dimensional (has rows and columns) and contains different data types (has both numbers and characters). Reading data into R requires `read` functions. 

For this tutorial we will use *real* data! This is gene abundance data from a site in Centralia, PA. If you cloned the `2018-tutorials` repository, you should have the data file on your computer. Navigate to `2018-tutorials/data_visualization/data` folder, and you should see a file `gene_abundance_centralia.txt`. It tells us the normalized abundance for each Site (13 total) and each gene (9 total).

First, we all need to have the data on our computers! You can choose your own adventure to get the data, but either way, you need to remember where you put it on your computer. 

* If you use GitHub, you can clone the repository with the following code:
```
git clone https://github.com/edamame-course/2018-Tutorials.git
```
* If you do not have/use GitHub, you can download the repository from your web browser. 
  * Go to [https://github.com/edamame-course/2018-Tutorials](https://github.com/edamame-course/2018-Tutorials)
  * Press Clone/Download
  * Press Download Zip
  * <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/git_download.png" width="400"> 


### `read` functions
First, we will read this file into R as a data.frame with the function `read.delim()`. The file is currently outside of R, so we will put it in quotes. 
```
read.delim("data/gene_abundance_centralia.txt")
```

Here, R assumes that your first argument is the file you are interested in. If you would like to be more specific, you could specify `file = ` within the code. 

```
read.delim(file = "data/gene_abundance_centralia.txt")
```
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/read_df.png" width="400"> 


***
__Pro tip:__ Rather than guessing what arguments within a funciton are called, simply hit `tab` after opening the function (`read.delim(`). A list of argument options will come up within RStudio, and you can tab-to-complete these as well! This will automatically insert spaces around the `=` to improve code readability with minimal effort on your part!
***

If we wanted to read in a tibble instead, we would use `read_delim()`. Tibbles a bit fussier than data.frames, but it's all in the name of reproducibility. `read_delim()` forces you to specify the delimiter of the file. In this case, it is tab delimited, so we will specify `delim = "\t"`.

* __Checkpoint:__ What are *three* ways we could figure out that the argument is `delim = `?

```
read_delim("data/gene_abundance_centralia.txt", delim = "\t")
```
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/read_tibble.png" width="400"> 

Congratulations, R is reading your data!  
* __Checkpoint:__ Why do these functions print out to the console?

Reading in other data.frames or tibbles is very similar, and there are often many functions that can read similar data structures.  
* tab separated values
  * `read.tsv()`: reads files as tab separated values into a data.frame
  * `read.delim(sep = "\t")`: reads files as tab separated values into a data.frame
  * `read_delim(delim = "\t")`: reads files as tab separated values into a tibble
* comma separated values
  * `read.csv()`: reads files as comma separated values into a data.frame
  * `read.delim(sep = ",")`: reads files as comma separated values into a data.frame
  * `read_csv()`: reads files as comma separated values into a tibble
  * `read_delim(delim = ",")`: reads files as comma separated values into a tibble
* space separated values
  * `read.table(sep = " ")`: reads files as space separated values into a data.frame
  * `read_delim(delim = " ")`: reads files as space separated values into a tibble
  
* __Checkpoint:__ What differences can you see between tibbles and data.frames? 
* See [here](http://r4ds.had.co.nz/introduction-2.html) fore more information on the differences between tibbles and data.frames

# Saving objects to your R environment
It's great to see that R is recognizing our data, but if we want to actually work with the data in R, we need R to *remember* it. We need to name it! 

Object assignment in R requires a few things
* a name
* `<-` or `=`
* the object 

For example, if we want to make an numeric object `3` that is called `a`, we could say `a <- 3`. Then if we typed `a` into the console, R would say `3`. 

We already know how to tell R to read our data, so all we need is a name and ` <- `. Let's try it:
(ps we'll be using tibbles here)
```
data <- read_delim("data/gene_abundance_centralia.txt", delim = "\t")
```
<br/>
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/data_in_env.png" width="400"> 
<br/>

No output lines printed in your console! Instead, you should now be able to see object `data` in your `environment`. 

***
__Pro tip:__ `Alt` +  `-` (or `option` + `-` for mac) will insert ` <- `. While ` <- ` and `=` *technically* interchangable when assigning a variable, it is useful to use ` <- ` for assignment operators since `=` is used for assigning arguments *within* a function.  
***

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

* __Activity:__ what does this line of code say? 


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
At some point in your workflow, you might be interested in subsetting your data. The simplest way to do this with the function `subset()`. 
```
geneA <- data.annotated %>%
  subset(Gene == "arsM")
```

## Congratulations! You're ready for plotting! 
On to the [data visualization](https://github.com/edamame-course/2018-Tutorials/blob/master/data_visualization/data_visualization_tutorial.md) tutorial!

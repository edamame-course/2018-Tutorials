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
* Use basic math functions in R, with calculator and fun() notation
* Understand variables and how to assign to them
* Understand errors, warnings, and messages
* Be able to seek help via ? and Google
* Be able to data into R
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


### Creating an R Project
Creating an R Project will result in a `.Rproj` file that is by default named after the directory it is in.

* To create a new R project, select `File -> New Project`, and a page like this should come up
 <img src="https://github.com/edamame-course/2018-Tutorials/blob/master/images/rproject.png" width="400"> 


* Here you can make a new directory for a project, use an existing directory you've been workin in, or even a version controlled directory (think GitHub)

### More information
Can't get enough of R projects? Great! We'll use one in our [data visualization](https://github.com/edamame-course/2018-Tutorials/blob/master/data_visualization/data_visualization_tutorial.md) tutorial. Also check out [RStudio support](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects) for even more information on R Projects!

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

## Using R: Packages



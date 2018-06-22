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




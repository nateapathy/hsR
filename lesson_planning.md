# Getting Set Up
For the first session all you'll need is a laptop with one of the following:
1.	R and RStudio Installed
  - Click the [appropriate link here to install R](https://ftp.ussg.iu.edu/CRAN/) for your operating system
  -	Click on the [appropriate installer here to install RStudio](https://www.rstudio.com/products/rstudio/download/#download) for your operating system 
2.	Neither of those installed but have admin privileges
  - We will install it tomorrow using the above links
3.	OR none of that but access to [IU Anyware](https://uits.iu.edu/iuanyware)
  - You can access RStudio if you search for it or use the Citrix Connection software you may have downloaded

We are going to spend the first ~3-4 sessions talking about the code from [this blog post](https://nateapathy.com/2017/12/20/how-old-is-the-senate/). In the first session we will barely touch the first couple lines of this at the bitter end.

I'll also be storing things for these sessions out on [GitHub](https://kb.iu.edu/d/bagk). We will talk about that tomorrow, too. Don't worry about knowing anything about GitHub right now. I'll invite you all to the folder so you can access it for this particular class. It will make things much easier.


# Session 1: Getting Oriented to RStudio & R Packages
- Installing R
- Installing RStudio
  - The relationship between RStudio and R
  - Versioning of R & RStudio - significance of software updates
- Orienting to the RStudio Screen - the four boxes, what appears, what gets saved
- Setting a working directory (build an R-dedicated folder for project files)
- R Projects & why they are important to use
- What is a package? Why do we need them?
  - Sandbox metaphor
  - Use tobit analysis package as example; not everything is developed by “default” or “included” stuff
  - They are like plugins with extra features
  - Package implications for sharing code (don’t know what packages people have, so you need the “install…” code to ensure they can do it themselves
- Introduce the first few lines of the Senate Ages R script (installing packages, commenting, loading packages)
  - [Blog post](https://nateapathy.com/2017/12/20/how-old-is-the-senate/)
 - [Swirl](http://swirlstats.com/students.html) for learning R

# Session 2: Objects, Data Types, & Functions

*Review:* Projects & Packages

## Objects
- What is an object?
  - What does an "object-oriented language" mean?
  - How is that different from "syntax?"
  - What flexibility do objects give me? Why should I care about this?
- How do we create objects?
- What does <- mean?
  - "Assignment Operator"

## Data Types
- Are there different types of objects?
  - What different parts do different types of objects have?
- [R-Bloggers on Classes](https://www.r-bloggers.com/classes-and-objects-in-r/)
- [StatMethods on Data Types](https://www.statmethods.net/input/datatypes.html)
  - Focus on Data Frames & Lists

## Functions
- Why are functions important?
- What are functions analogous to in other stats software?
- How will I primarily use functions?
  - Data Creation
  - Data Cleaning/Organizing/Analysis Setup
  - Data Analysis
- Some prep readings & resources:
  - [Base R Statistical Functions](http://www.dummies.com/education/math/statistics/base-r-statistical-functions/)
    - [Some examples of these functions](http://www.biostat.jhsph.edu/~hji/courses/statcomputing/StatFunc.pdf) (ignore the mathy parts of this slide deck)
  - [Useful Functions](http://www.sr.bham.ac.uk/~ajrs/R/r-function_list.html)
  - [Function Reference Card](https://cran.r-project.org/doc/contrib/Short-refcard.pdf)
  - [StatMethods on Base Functions](https://www.statmethods.net/management/functions.html)

## Administrative
- Determine a recurring day of the week & time that reliably works for everyone
- Updates from the [RStudio Conference](https://www.rstudio.com/conference/)
  - Many presenters share slides
    - Page through [this one](https://speakerdeck.com/jennybc/data-rectangling-1) related to lists & data frames before next session
  - Search Twitter for [#rstudioconf](https://twitter.com/hashtag/#rstudioconf)
    - Find one cool tweet to share with the group next week
    - For example, I found this very useful [syntax cheatsheet](http://www.science.smith.edu/~amcnamara/Syntax-cheatsheet.pdf)
- Twitter [#rstats](https://twitter.com/hashtag/#rstats) and [#rstudio](https://twitter.com/hashtag/#rstudio) are great ways to find out about new/cool packages, visualizations, and things people are doing with R & RStudio that may apply to your own work

# Session 3: Data Management Introduction

We're going to work almost exclusively with data frames today.

## Getting Data
- HIX Compare website
- download() functions to get data **files** from the internet
    - not to be confused with scraping tables/html/etc.
    - that's what we do in the sen_ages file, but more often we will be downloading or pulling in data files we already have or that are stored on a server somewhere
- read_*() family of functions
- storing raw data files

## Merging Data
- checking that fields/columns match
- cbind() and rbind()
- tidyverse intro and [R for Data Science](http://r4ds.had.co.nz/)
- joining steps for HIX

## Cleaning Data
- Missingness & NAs
- **won't cover this in detail today**

## Subsetting Data
- valid observations
- fields you care about

## Visualizaing Data
- simple exploratory plots

## Your turn!
- download [session3.R](https://github.iu.edu/natea/hsR/blob/master/session3.R) from the github site
    - this is basically what we've just reviewed
- download [hix_rdata_files.zip](https://github.iu.edu/natea/hsR/raw/master/hix_rdata_files.zip) from the github site
- unzip the zip and place all five files in your project folder
- then they should show up in RStudio
- we will walk through the first part (what is already written)
- then you each have a commented out section that is there for you to accomplish the task listed



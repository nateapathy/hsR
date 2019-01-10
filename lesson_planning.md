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
  - Fridays 1:30-3p seem to be the best time for everyone
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

## Subsetting Data
- subset to find out things about your data set
- answer questions about subpopulations
- understand what data you want in your study

## Your turn!
- download [session3.R](https://github.iu.edu/natea/hsR/blob/master/session3.R) from the github site
    - this is basically what we've just reviewed
- download [hix_rdata_files.zip](https://github.iu.edu/natea/hsR/raw/master/hix_rdata_files.zip) from the github site
- unzip the zip and place all five files in your project folder
- then they should show up in RStudio
- we will walk through the first part (what is already written)
- then you each have a commented out section that is there for you to accomplish the task listed

# Session 4: Data Management II & Intro to Visualization for EDA

## Administrative
- Determine a recurring day of the week & time that reliably works for everyone
- Updates from the [RStudio Conference](https://www.rstudio.com/conference/)
  - Many presenters share slides
    - Page through [this one](https://speakerdeck.com/jennybc/data-rectangling-1) related to lists & data frames before next session
  - Search Twitter for [#rstudioconf](https://twitter.com/hashtag/#rstudioconf)
    - Find one cool tweet to share with the group next week
    - For example, I found this very useful [syntax cheatsheet](http://www.science.smith.edu/~amcnamara/Syntax-cheatsheet.pdf)
- Twitter [#rstats](https://twitter.com/hashtag/#rstats) and [#rstudio](https://twitter.com/hashtag/#rstudio) are great ways to find out about new/cool packages, visualizations, and things people are doing with R & RStudio that may apply to your own work

## Review last week's activities
- How did you go about answering the questions?

## Exploring Cleaning Data
- Missingness & NAs
- skimr function in more depth
- VIM functions for visualizing missing data

## Subsetting Data
- we did this a little bit last week
- valid observations
- fields you care about
- understanding what qualifies for your study, what doesn't
- dealing with duplicates

## Visualizaing Data
- simple exploratory plots
- summarizing a dataset for plots
- ggplot() grammar
- adding elements to a single graph

# Session 5: Introduction to Stats in R

## Data Set
- Pick a data set you're already familiar with
- You can use the HIX Compare one or another one you have access to
- Read it in using whatever appropriate read_*() function fits your data type
- Make sure the variables are formatted correctly
- Encourage you to use a relatively small data set
- R also has some built-in data sets that can be used
- MASS (about Massachussets), mtcars, in the datasets package

## Basic Statistics
- resources
    - [quickR guide](https://www.statmethods.net/stats/index.html)
    - [R tutor guide](http://www.r-tutor.com/elementary-statistics)
    - [multivariate analysis guide](https://little-book-of-r-for-multivariate-analysis.readthedocs.io/en/latest/)
- correlations
- t-tests
- chi-square
- wilcoxon rank sum
- mcnemar
- simple linear regression

## Multivariate Linear and Logistic Regressions
- next week we are going to do a review of regression assumptions
- then we will dive further into regression functions next week and the week after
- linear regression, output, using output from linear models
- logistic regression, attending to data types

# Session 6: Regression Assumptions Review & Implementation

## Regression Assumptions
- Review the assumptions of multiple linear regression
- Use the [regression_assumptions](https://github.iu.edu/natea/hsR/blob/master/regression_assumptions.pdf) file
- Emphasize their implications for the estimates

## How to do regression diagnostics in R
- [Quick-R Tutorial](https://www.statmethods.net/stats/rdiagnostics.html)
- [R Stats Detailed Walkthrough](http://r-statistics.co/Assumptions-of-Linear-Regression.html)
- Assumption-specific steps
- Automated evaluation with gvlma()

# Session 7: Different Types of Regression

## Common Regression Models Used in HSR
- [Tutorial](http://tutorials.iq.harvard.edu/R/Rstatistics/Rstatistics.html)
- [Fitting models to your data](https://magesblog.com/post/2011-12-01-fitting-distributions-with-r/)
    - Distributions & [modeling](https://magesblog.com/img/magesblog/distributions.png)
- Linear Regression
- Logistic Regression
    - Odds Ratios
    - Marginal Effects
    - Interactions
- Multinomial Regression
- Count Model Regressions

# Session 9: Causal Inference (Propensity Scores & IPTW)

## DAGs in R & Review of Confounding
- [review](https://cran.r-project.org/web/packages/ggdag/vignettes/bias-structures.html) of sources of bias
- ggdag [package](https://cran.r-project.org/web/packages/ggdag/index.html)
    - [introduction vignette](https://cran.r-project.org/web/packages/ggdag/vignettes/intro-to-ggdag.html)

## Propensity Scores & Matching
- review of packages built for propensity scoring
    - Matching [example](http://sekhon.berkeley.edu/matching/)
    - MatchIt [example](http://pareonline.net/pdf/v19n18.pdf)
    - nonrandom [example](https://cran.r-project.org/web/packages/nonrandom/vignettes/nonrandom.pdf)
- also can do this with logistic regression
- we will do an example using the [Matching](https://cran.r-project.org/web/packages/Matching/Matching.pdf) package

## Inverse Probability of Treatment Weighting (IPTW)


# Session 10: Causal Inference (Diff in Diff, RD, & Instrumental Variables)
Reading
Pomeranz D. [Impact Evaluation Methods in Public Economics: A Brief Introduction to Randomized Evaluations and Comparison with Other Methods. Public Finance Review](https://paperpile.com/shared/ueOzYd). 2017 Jan 1;45(1):10–43. Available from: https://doi.org/10.1177/1091142115614392

## Difference in Differences

## Regression Discontinuity

## Instrumental Variables


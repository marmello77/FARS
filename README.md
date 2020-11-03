# FARS

[Coursera's Building R packages](https://www.coursera.org/learn/r-packages)

Final Peer-graded Assignment: Building an R Package

Author: Marco Mello

E-mail: marmello@usp.br


## Instructions

The purpose of this assessment is for you to combine your skills of creating, writing, documenting, and testing an R package with releasing that package on GitHub. In this assessment you'll be taking the R files from Week 2's assessment about documentation and putting that file in an R package.

For this assessment you must:

1. Write a vignette to include in your package using knitr and R Markdown;

2. Write at least one test written using testthat;

3. Put your package on GitHub;

4. Set up the repository so that the package can be checked and built on Travis;

5. Once your package has built on Travis and the build is passing with no errors, warnings, or notes you should add your Travis badge to the README.md file of your package repository.


## Review criteria

For this assignment you'll submit a link to the GitHub repository which contains your package. This assessment will ask reviewers the following questions:

1. Does this package contain the correct R file(s) under the R/ directory?

2. Does this package contain a man/ directory with corresponding documentation files?

3. Does this package contain a vignette which provides a meaningful description of the package and how it should be used?

4. Does this package have at least one test included in the tests/ directory?

5. Does this package have a NAMESPACE file?

6. Does the README.md file for this directory have a Travis badge?

7. Is the build of this package passing on Travis?

8.Are the build logs for this package on Travis free of any errors, warnings, or notes?


## Data sources

This package uses example data from the [US National Highway Traffic Safety Administration's Fatality Analysis Reporting System](https://www.nhtsa.gov) (FARS), which is a nationwide census providing the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes. 

Unfortunately, since the course was last updated, the website of FARS changed considerably and data are more difficult to find now. Therefore, the data actually used here were downloaded directly from the [course's website](https://d3c33hcgiwev3.cloudfront.net/_e1adac2a5f05192dc8780f3944feec13_fars_data.zip?Expires=1604534400&Signature=RTTvUAKz8DKWFiSEcAetz-uqBOzv79moF3uW0TbPA8k8fvG6Pa~o1wndjQsxlNKDxFWVONipYXks9nQ~G3zuKUfDj0ufW2d0ITHZlmi9VqjXjoTbW4MjXzoLX8I-CLjs-OG4VzhK6dewCktT1k2mIVfRodd72Kzu3BQTcqK5lZI_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A).


# Further readings

To complete this peer-graded assignment, in addition to the course's readings, I have also consulted other invaluable sources, which are listed here. If you want to dive deeper into the details about how to build an R package, read the following sources, in this order:

1. [Writing an R package from scratch](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/)

2. [R Packages](https://r-pkgs.org/index.html)

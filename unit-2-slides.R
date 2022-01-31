## ----setup, include=FALSE-----------------------
knitr::opts_chunk$set(echo = FALSE)


## ---- echo=FALSE--------------------------------
# then load all the relevant packages
pacman::p_load(pacman, knitr)


## ----xaringan-panelset, echo=FALSE--------------
xaringanExtra::use_panelset()


## ----xaringanExtra-clipboard, echo=FALSE--------
# these allow any code snippets to be copied to the clipboard so they 
# can be pasted easily
htmltools::tagList(
  xaringanExtra::use_clipboard(
    button_text = "<i class=\"fa fa-clipboard\"></i>",
    success_text = "<i class=\"fa fa-check\" style=\"color: #90BE6D\"></i>",
  ),
  rmarkdown::html_dependency_font_awesome()
)

## ----xaringan-extras, echo=FALSE----------------
xaringanExtra::use_tile_view()



## ----load-libraries, message=TRUE, echo=TRUE----
library(readxl)
library(tidyverse)
library(tidygraph)
library(ggraph)


## ---- echo=FALSE--------------------------------
library(igraph)


## ---- echo=TRUE---------------------------------
# YOUR CODE HERE




## ----example-code, echo=TRUE--------------------
example <- sum(0:9)
print(example)

# adding #<< after a line of code highlights it like this 
alphabet <- letters #<<
print(alphabet)


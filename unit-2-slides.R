## ----setup, include=FALSE-----------
knitr::opts_chunk$set(echo = FALSE)


## ---- echo=FALSE--------------------
# then load all the relevant packages
pacman::p_load(pacman, knitr)


## ----xaringan-panelset, echo=FALSE----
xaringanExtra::use_panelset()


## ----xaringanExtra-clipboard, echo=FALSE----
# these allow any code snippets to be copied to the clipboard so they 
# can be pasted easily
htmltools::tagList(
  xaringanExtra::use_clipboard(
    button_text = "<i class=\"fa fa-clipboard\"></i>",
    success_text = "<i class=\"fa fa-check\" style=\"color: #90BE6D\"></i>",
  ),
  rmarkdown::html_dependency_font_awesome()
)

## ----xaringan-extras, echo=FALSE----
xaringanExtra::use_tile_view()



## ----load-libraries, message=TRUE, echo=TRUE, message=FALSE----
library(readxl)
library(tidyverse)
library(tidygraph)
library(ggraph)


## ---- echo=FALSE, message=FALSE-----
library(igraph)


## ----load-igraph, echo=TRUE---------
# YOUR CODE HERE




## ----import-data, echo=TRUE, message=FALSE----
year_1_collaboration <- read_excel("data/year_1_collaboration.xlsx", 
                                   col_names = FALSE)


## ----inspect-data, echo=TRUE--------
# ADD CODE BELOW
#
#



## ----wrangle-data, echo=TRUE, message=FALSE, warning=FALSE----

year_1_matrix <- as.matrix(year_1_collaboration)

rownames(year_1_matrix) <- 1:43 

colnames(year_1_matrix) <- 1:43


year_1_network <- as_tbl_graph(year_1_matrix, directed = TRUE)



## ----view-netwok, echo=TRUE---------
# ADD CODE BELOW
#
#



## ----density, echo=TRUE-------------
edge_density(year_1_network)


## ----examine-density, strip.white=TRUE, echo=FALSE----
autograph(year_1_network) +
  theme_graph()


## ----centrality, echo=TRUE----------
centr_degree(year_1_network, mode = "all")


## ----examine-centrality, strip.white=TRUE, echo=FALSE----
autograph(year_1_network) +
  theme_graph()


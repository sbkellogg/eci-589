
library(RCurl)
library(tidygraph)
library(igraph)
library(readxl)

ga.mat<-getURL("https://docs.google.com/spreadsheet/pub?key=0Ai--oOZQWBHSdDE3Ynp2cThMamg1b0VhbEs0al9zV0E&single=true&gid=0&output=txt",
               ssl.verifypeer = FALSE)
ga.mat<-as.matrix(read.table(textConnection(ga.mat), sep="\t",
                             header=T, row.names=1, quote="\""))
#Second, read in the network attributes
ga.atts<-getURL("https://docs.google.com/spreadsheet/pub?key=0Ai--oOZQWBHSdDE3Ynp2cThMamg1b0VhbEs0al9zV0E&single=true&gid=1&output=txt",
                ssl.verifypeer = FALSE)
ga.atts<-read.table(textConnection(ga.atts), sep="\t", header=T, quote="\"",
                    stringsAsFactors=F, strip.white=T, as.is=T)
#Third, create a network object using the sociomatrix and its corresponding attributes
ga.net<-network(ga.mat, vertex.attr=ga.atts, vertex.attrnames=colnames(ga.atts),
                directed=F, hyper=F, loops=F, multiple=F, bipartite=F)

# WRANGLE


# Import Data

edge_matrix <- read_csv("unit-3/data/School Leaders Data Chapter 9_d.csv")


node_list <- 
  read_excel("unit-3/data/School Leaders Data Chapter 9_e.xlsx", 
             col_types = c("text", "numeric", "numeric", "numeric", "numeric"))


## Convert to Matrix

matrix <- edge_matrix %>%
  as.matrix()

class(matrix)

## Dichotomize matrix

matrix[matrix <= 2] <- 0

matrix[matrix >= 3] <- 1

matrix

## Convert Adjacent Matrix 

adjacency_matrix <- graph.adjacency(matrix)

class(adjacency_matrix)


## Convert to edge list



edge_list <- get.data.frame(adjacency_matrix) %>%
  to_simple()


edge_list

## Create Network Object 

network <- tbl_graph(edges = edge_list,
                     nodes = node_list,
                     directed = TRUE)

simple_network <- network %>%
  convert(to_simple)

  

simple_network



plot(simple_network) 


# EXPLORE

# Degree

network_measures <- simple_network %>%
  activate(nodes) %>%
  mutate(degree = centrality_degree(mode = "all")) %>%
  mutate(in_degree = centrality_degree(mode = "in")) %>%
  mutate(out_degree = centrality_degree(mode = "out"))

network_measures

node_measures <- network_measures %>% 
  activate(nodes) %>%
  data.frame()

summary(node_measures)


ergm_network <- network(edge_list, vertex.attr = node_list, matrix.type = "edgelist", ignore.eval = FALSE, loops = TRUE)

ergm_network

ergm.getnetwork(ergm_network)

class(network)


plot(ergm_network)

ergm_1 <- ergm(network ~ edges) # Estimate the model 



library(RCurl)
library(tidygraph)
library(igraph)

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

# Import Data

matrix <- read_csv("unit-3/data/School Leaders Data Chapter 9_d.csv") %>%
  as.matrix()

class(matrix)



adjacency_matrix <- graph.adjacency(matrix,
                             weighted = TRUE)

class(adjacency_matrix)

edge_list <- get.data.frame(adjacency_matrix)

edge_list


node_list <- 
  read_excel("unit-3/data/School Leaders Data Chapter 9_e.xlsx", 
             col_types = c("text", "numeric", "numeric", "numeric", "numeric"))

network <- tbl_graph(edges = edge_list,
                     nodes = node_list)

network

ergm_network <- network(edge_list, vertex.attr = node_list, matrix.type = "edgelist", ignore.eval = FALSE, loops = TRUE)

ergm_network

ergm.getnetwork(ergm_network)

class(network)


plot(ergm_network)

ergm_1 <- ergm(network ~ edges) # Estimate the model 


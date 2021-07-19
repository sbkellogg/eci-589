library(tidyverse)
library(tidygraph)
library(igraph)
library(readxl)
library(statnet)

# WRANGLE ####


# Import Data ####

leader_nodes <- 
  read_excel("unit-3/data/School Leaders Data Chapter 9_e.xlsx", 
             col_types = c("text", "numeric", "numeric", "numeric", "numeric"))

leader_matrix <- 
  read_excel("unit-3/data/School Leaders Data Chapter 9_d.xlsx", 
             col_names = FALSE)


## Convert to Matrix ####

leader_matrix <- leader_matrix %>%
  as.matrix()

class(leader_matrix)

## Dichotomize matrix ####

leader_matrix[leader_matrix <= 2] <- 0

leader_matrix[leader_matrix >= 3] <- 1

leader_matrix

#add names to matrix object
rownames(leader_matrix) <- leader_nodes$ID
colnames(leader_matrix) <- leader_nodes$ID

## Convert Adjacent Matrix #### 

adjacency_matrix <- graph.adjacency(leader_matrix,
                                    diag = FALSE)

class(adjacency_matrix)

## Convert to edge list ####

leader_edges <- get.data.frame(adjacency_matrix)


leader_edges

## Create Network Object #### 

network <- tbl_graph(edges = leader_edges,
                     nodes = node_list,
                     directed = TRUE)


network

plot(network) 


# EXPLORE ####

# Degree ####

network_measures <- network %>%
  activate(nodes) %>%
  mutate(degree = centrality_degree(mode = "all")) %>%
  mutate(in_degree = centrality_degree(mode = "in")) %>%
  mutate(out_degree = centrality_degree(mode = "out"))

network_measures

node_measures <- network_measures %>% 
  activate(nodes) %>%
  data.frame()

summary(node_measures)


# MODEL ####

## Convert to network object ####


leader_network <- as.network(leader_edges,
                             vertices = leader_nodes)

class(leader_network)

leader_network

list.vertex.attributes(leader_network)


plot(leader_network)

ergm_1 <- ergm(leader_network ~ edges) 

summary(ergm_1)

ergm_2 <- ergm(leader_network ~ edges + 
                 mutual)

summary(ergm_2)

ergm_3 <- ergm(leader_network ~ edges +
                 mutual +
                 nodematch('MALE'))
  

summary(ergm_3)

ergm_4 <- ergm(leader_network ~ edges +
                 mutual +
                 nodematch('MALE') +
                 absdiff('EFFICACY')
               )
  
  
summary(ergm_4)

ergm_5 <- ergm(leader_network ~ edges +
                 mutual +
                 nodematch('MALE') +
                 absdiff('EFFICACY') +
                 absdiff('TRUST')
)


summary(ergm_5)

ergm_6 <- ergm(leader_network ~ edges +
                 mutual +
                 nodematch('MALE') +
                 nodematch('DISTRICT/SITE') +
                 absdiff('EFFICACY') +
                 absdiff('TRUST')
)


summary(ergm_6)


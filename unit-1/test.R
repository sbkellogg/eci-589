
## Import Data #### 
ties <- read_csv("data/dlt1-edgelist.csv", 
                 col_types = cols(Sender = col_character(), 
                                  Receiver = col_character(), 
                                  `Category Text` = col_skip(), 
                                  `Comment ID` = col_character(), 
                                  `Discussion ID` = col_character()))

library(readr)
actors <- read_csv("data/dlt1-nodes.csv", 
                   col_types = cols(UID = col_character(), 
                                    Facilitator = col_character(), 
                                    expert = col_character(), 
                                    connect = col_character()))





network <- graph_from_data_frame(d=ties, 
                             vertices=actors, 
                             directed=T) 

network

simple_network <- simplify(network)

simple_network

is_weighted(simp)

edges <- ties %>% 
  count(Sender, Receiver) %>%
  rename(weight = n)

edges


hist(edges$weight, breaks = 20)
mean(edges$weight)
median(edges$weight)


weights <- E(weighted_network)$weight

hist(weights, breaks = 10)
mean(weights)
median(weights)

medi
sd(edges$weight)

hist(deg, breaks = 50)
mean(deg)
sd(deg)

boxplot(deg)

net <- graph_from_data_frame(d=edges, 
                             vertices=actors, 
                             directed=T) 
net


isolates = which(degree(network)==0)
no_isolates = delete.vertices(network, isolates)

no_isolates

plot(network, 
     vertex.label.dist=1.5)


net

net[]

matrix <- as_adjacency_matrix(net, attr="weight")





deg <- degree(net, mode="in")

l <- layout_with_fr(net)




ggraph(net, layout = "fr") +
  geom_edge_link() +   
  geom_node_point()   

ggraph(net, layout = "fr") +
  geom_edge_fan() +   
  geom_node_point()   


ceb <- cluster_edge_betweenness(net.sp) 

dendPlot(ceb, mode="hclust")

plot(ceb, net.sp) 

clp <- cluster_label_prop(net.sp)

plot(clp, net.sp)




fr <- layout_with_fr(net)
su <- layout_with_sugiyama(net)
lgl <- layout_with_lgl(net)



net <- simplify(net, remove.multiple = F, remove.loops = T) 

E(net)$width <- E(net)$weight/10


deg <- degree(simple_network, mode="in")

plot(simple_network, 
     layout = layout_with_kk,
     edge.arrow.size=.04,
     edge.width = .2,
     vertex.label=NA,
     vertex.size=deg*.04)

edge_attr_names(network)

edge_attr_names(net)

vertex_attr_names(network)



net


cut.off <- mean(edges$weight) 
net.sp <- delete_edges(net, E(net)[weight<5])


plot(net.sp, 
     layout=layout_with_kk,
     edge.arrow.size=.04,
     edge.width = .5,
     vertex.label=NA,
     vertex.size=deg*.04)
     


ggraph(net, layout="fr") +
  geom_edge_fan(color="gray50", width=0.05, alpha=0.5) + 
  geom_node_point(size=1) +
  theme_void()


ggraph(net, layout="fr") +
  geom_edge_link(aes(size = weight/2)) +           # colors by edge type 
  geom_node_point(aes(color = Facilitator,
                      size = deg*.5)) +  # size by audience size  
  theme_void()

ggraph(net, layout = "fr") +
  geom_edge_link() +   # add edges to the plot
  geom_node_point()    # add nodes to the plot

ggraph(net, layout = "fr") +
  geom_edge_fan() +   # add edges to the plot
  geom_node_point()    # add nodes to the plot


ceb <- cluster_edge_betweenness(net) 

dendPlot(ceb, mode="hclust")

plot(ceb, net) 

clp <- cluster_label_prop(net)

plot(clp, net)


deg <- degree(net, mode="in")

l <- layout_with_fr(net)

net <- simplify(net, remove.multiple = F, remove.loops = T) 

plot(net, 
     layout = l,
     edge.arrow.size=.05,
     edge.width = .5,
     vertex.label=NA,
     vertex.size=deg*.04)

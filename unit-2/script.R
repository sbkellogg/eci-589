
library(tidyverse)
library(rtweet)
library(tidygraph)
library(igraph)
library(ggraph)

bearer <- "AAAAAAAAAAAAAAAAAAAAAFAwLQEAAAAAmFL160b%2BO9CcgPoUjmOvaA3YwN4%3D5wCNhlxblv7nbt5ruhpw1uh8tf3kN6TrjxG9JvtyIjxpGOWnha"
app_name <- "Text Mining in Education"
api_key <- "U3DQ45N3CMP0YHKbv7Ol6yOdb"
api_secret_key <- "rnUzLj3AalImQeIUgQ9lC6Eq8UbcVfeQNTZnMCfkemcVRhg3fK"
access_token <- "17572410-YUIDme40uuBGd4TiwiV5eDRL5FV1Z7iosR4Rn88yj"
access_token_secret <- "wvk5rw1ZuVm4fUJQYeUBl5BT6xatFoSWzgocWI5zSnz3E"

## authenticate via web browser
token <- create_token(
  app = app_name,
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)

token


get_token()


ccss_dictionary <- c("#commoncore", '"common core"')

ccss_tweets <- ccss_dictionary %>% 
  search_tweets2(n=5000, include_rts = FALSE)


ccss_tweets


nrow(ccss_tweets)

regex <- "@([A-Za-z]+[A-Za-z0-9_]+)(?![A-Za-z0-9_]*\\.)"

ccss_tweets_1 <-
  ccss_tweets %>%
  # Use regular expression to identify all the usernames in a tweet
  mutate(all_mentions = str_extract_all(text, regex)) %>%
  unnest(all_mentions)


mentions <-
  ccss_tweets_1 %>%
  mutate(all_mentions = str_trim(all_mentions)) %>%
  select(sender = screen_name, all_mentions)


edgelist <- 
  mentions %>% 
  # remove "@" from all_mentions column
  mutate(all_mentions = str_sub(all_mentions, start = 2)) %>% 
  # rename all_mentions to receiver
  select(sender, receiver = all_mentions)

interactions_sent <- edgelist %>% 
  # this counts how many times each sender appears in the data frame, effectively counting how many interactions each individual sent 
  count(sender) %>% 
  # arranges the data frame in descending order of the number of interactions sent
  arrange(desc(n))


interactions_sent

interactions_sent <- 
  interactions_sent %>% 
  filter(n > 1)


g <- as_tbl_graph(ties,
               directed = TRUE)

g

g %>% 
  activate(nodes) %>% 
  mutate(community=as.character(group_edge_betweenness())) %>%
  ggraph("kk")  + 
  geom_edge_link()  + 
  geom_node_point(aes(color=community), size=3) + 
  theme_graph()

g

g %>%
  # we chose the kk layout as it created a graph which was easy-to-interpret, but others are available; see ?ggraph
  ggraph(layout = "fr") +
  # this adds the points to the graph
  geom_node_point() +
  # this adds the links, or the edges; alpha = .2 makes it so that the lines are partially transparent
  geom_edge_link(alpha = .2) +
  # this last line of code adds a ggplot2 theme suitable for network graphs
  theme_graph()


network_1 %>% 
  # this calculates the centrality of each individual using the built-in centrality_authority() function
  mutate(centrality = centrality_degree(mode = "in")) %>% 
  ggraph(layout = "kk") + 
  geom_node_point(aes(size = centrality, color = centrality)) +
  # this line colors the points based upon their centrality
  geom_node_text(aes(label = screen_name), size=3, color="gray50", repel=T) +
  scale_color_continuous(guide = 'legend') + 
  geom_edge_link(alpha = .2) +
  theme_graph()

g %>% 
activate(nodes) %>% 
  mutate(community=as.character(group_edge_betweenness())) %>%
  ggraph("kk")  + 
  geom_edge_link()  + 
  geom_node_point(aes(color=community), size=3) + 
  theme_graph() +
  theme(legend.position="none")

create_notable('tutte') %>%
  activate(nodes) %>%
  mutate(group = group_louvain()) %>%
  ggraph("fr")  + 
  geom_edge_link()  + 
  geom_node_point(aes(color=group), size=3) + 
  theme_graph()



g %>% 
  # this calculates the centrality of each individual using the built-in centrality_authority() function
  mutate(centrality = centrality_degree(mode = "in")) %>% 
  ggraph(layout = "kk") + 
  geom_node_point(aes(size = centrality, color = centrality)) +
  # this line colors the points based upon their centrality
  scale_color_continuous(guide = 'legend') + 
  geom_edge_arc(alpha = .2) +
  theme_graph()




play_smallworld(1, 100, 3, 0.05) %>% 
  mutate(centrality = centrality_authority()) %>% 
  ggraph(layout = 'kk') + 
  geom_edge_link() + 
  geom_node_point(aes(size = centrality, colour = centrality)) + 
  scale_color_continuous(guide = 'legend') + 
  theme_graph()

g %>% 
  mutate(community = as.factor(group_infomap())) %>% 
  ggraph(layout = 'kk') + 
  geom_edge_link(aes(alpha = ..index..), show.legend = FALSE) + 
  geom_node_point(aes(colour = community), size = 3, show.legend = FALSE) + 
  theme_graph() 


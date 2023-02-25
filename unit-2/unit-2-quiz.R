library(janitor)
library(tidyverse)
library(igraph)
library(tidygraph)
library(ggraph)

dlt1_ties <- read_csv("unit-2/data/dlt1-edges.csv") |>
  clean_names()

dlt1_ties

dlt2_ties <- read_csv("unit-2/data/dlt2-edges.csv") |>
  clean_names()

dlt2_ties


dlt1_nodes <- read_csv("unit-2/data/dlt1-nodes.csv") |>
  clean_names()

dlt1_nodes

dlt2_nodes <- read_csv("unit-2/data/dlt2-nodes.csv") |>
  clean_names()

dlt2_nodes

dlt1_nodes |> 
  filter(location == "NC")

dlt2_nodes |> 
  filter(location == "NC")

dlt2_nodes |> 
  filter(experience >= 10)

dlt2_nodes |> 
  filter(experience > 10)


dlt2_nodes |> 
  arrange(desc(experience))


dlt2_nodes |> 
  filter(location == "NC") |>
  group_by(gender) |>
  summarise(mean = mean(experience))



babynames %>% 
  filter(name == "Garrett", sex == "M") %>% 
  summarise(total = sum(n), max = max(n), mean = mean(n))

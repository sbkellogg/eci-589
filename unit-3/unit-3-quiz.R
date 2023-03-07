library(tidyverse)
library(tidytext)
library(tidygraph)
library(ggraph)

ccss_tweets <- read_csv("unit-3/data/ccss-tweets-simple.csv")

ccss_edges <- ccss_tweets |>
  select(user_id,
         status_id,
         created_at,
         screen_name,
         reply_to_screen_name,
         quoted_screen_name, 
         hashtags)

write_csv(ccss_edges, "unit-3/data/ccss_edges.csv")

ccss_text <- ccss_tweets |>
  select(status_id,
         text)

write_csv(ccss_edges, "unit-3/data/ccss_text.csv")

distinct(ccss_tweets, screen_name) |>
  count()

distinct(ccss_tweets, status_id) |>
  count()

ccss_tweets |>
count(screen_name)

ccss_separate <- ccss_edges |>
  separate(created_at, 
           into = c("date", 
                    "time"), 
           sep = " ")


ccss_united <- ccss_separate |>
  unite(target, 
        reply_to_screen_name, 
        quoted_screen_name,
        na.rm = TRUE)

# ccss_united <- ccss_separate |>
#   unite(target, 
#         reply_to_screen_name, 
#         quoted_screen_name)


distinct(ccss_united, target) |>
  count()

count(ccss_united, target)


ccss_join <- left_join(ccss_united,
                        ccss_text,
                        )



ccss_actors <- ccss_united |> 
  gather(key = "direction", 
         value = "name",
         screen_name,
         target) |>
  distinct(name)

ccss_actors


ccss_actors <- left_join(ccss_actors, )






ccss_united <- ccss_tweets |>
  unite(target, 
        reply_to_screen_name, 
        mentions_screen_name, 
        quoted_screen_name, 
        sep = " ")

ccss_separate <- ccss_united |>
  separate(target, 
           into = c("name_1", 
                    "name_2", 
                    "name_3", 
                    "name_4",
                    "name_5"), 
           fill = "right",
           sep = " ")

ccss_gather <- ccss_separate |> 
  gather(key = "order",
         value = "name",
         name_1,
         name_2,
         name_3,
         name_4,
         name_5) |>
  select(screen_name, name) |>
  drop_na(name)


n_distinct(ccss_tweets$screen_name)

unique(ccss_tweets$screen_name)






ties_1 <-  ccss_tweets |>
  relocate(sender = screen_name, # rename scree_name to sender
           target = mentions_screen_name) |> # rename to receiver
  select(sender,
         target,
         created_at,
         text)

ties_1


ties_2 <- ties_1 |>
  unnest_tokens(input = target,
                output = receiver,
                to_lower = FALSE) |>
  relocate(sender, receiver)

ties_2

ties <- ties_2 |>
  drop_na(receiver)




write_csv(ties, "unit-3/data/ccss-edgelist.csv")



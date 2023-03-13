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

write_csv(ccss_edges, "unit-3/data/ccss-edges.csv")

ccss_text <- ccss_tweets |>
  select(status_id,
         text)

write_csv(ccss_text, "unit-3/data/ccss-text.csv")

#### Question 1 Import Data ####

# Load the appropriate package(s) and use the read_csv( ) function to import the "ccss-edges.csv" file located in your data folder. Save to your R environment as an object named "ccss_edges". 
#
# This file contains a small subset of tweets from 2021 that included the term #commoncore. The Common Core was a major education policy initiative of the early 21st century. A primary aim of the Common Core was to strengthen education systems across the United States through a set of specific and challenging education standards.  
#
# Use a function or method of your choosing to inspect your data and then match the following variables with the correct definitions. 

ccss_edges <- read_csv("unit-3/data/ccss-edges.csv")

glimpse(ccss_edges)

ccss_edges

#### Question 2 Count Distinct Values #### 

# During this time period, how many "distinct" actors posted a tweet during this week about in our Twitter network dataset?
#   
# Hint:  Actors are identified by their Twitter "screen_name" and the tidyverse package has a function for selecting the unique/distinct rows from a data frame. 

distinct(ccss_edges, screen_name) |>
  count()

distinct(ccss_edges, status_id) |>
  count()

ccss_edges |>
count(screen_name, sort = T)


#### Question 3 Split Column ####

# Use the separate() function to split our created_at variable in our ccss_edges data frame into two separate columns, one containing the date and one containing the time. 
# 
# Save your new data frame as "ccss_separate" and then answer the following question by taking a count all tweets for each day of the week in our data set. 
# 
# On which day were the most tweets posted? 

ccss_separate <- ccss_edges |>
  separate(created_at, 
           into = c("date", 
                    "time"), 
           sep = " ")


distinct(ccss_separate, date) |>
  arrange()

count(ccss_separate, date)



### Question 4 Combine Columns ####

# Combine the reply_to_screen_name and the quoted_screen_name in the ccss_seperate data frame into a single column named "to_screen_name".
# 
# Assign your new data frame to an object named ccss_unite and then answer the following question:
#   
#   How many unique actors were replied to or quoted in our Twitter data set? 
#   
#   Hint: Look up the unite() function in the Help tab to figure out how might you deal with missing values, i.e., NA. Also, be mindful of the rows combining two missing values when taking your count.

ccss_unite <- ccss_separate |>
  unite(to_screen_name, 
        reply_to_screen_name, 
        quoted_screen_name,
        na.rm = TRUE)

# ccss_united <- ccss_separate |>
#   unite(target, 
#         reply_to_screen_name, 
#         quoted_screen_name)


distinct(ccss_unite, to_screen_name) |>
  count()

count(ccss_unite, to_screen_name)

### Question 5 Pivot Columns ####

# use the read_csv( ) function to import the "ccss-edges.csv" file located in your data folder. Save to your R environment as an object named "ccss_edges". 

ccss_text <- read_csv("unit-3/data/ccss-text.csv")

ccss_join <- left_join(ccss_unite,
                       ccss_text,
                       by = "status_id")

ccss_join


### Question 6 Joing Data Frames ####

# Finally, create a nodelist containing a single row for each actor in our network using the gather() function to pivot our screen_name and target columns into a single column named "actors" and save as a new data frame named "ccss_actors". 
# 
# How many total unique actors are in our network? 
#   
#   Hint: Ignore the blank row(s) that resulted from combining the empty reply_to_screen_name and quoted_screen_name columns. 

ccss_actors <- ccss_unite |> 
  gather(key = "direction", 
         value = "name",
         screen_name,
         to_screen_name) |>
  filter(name != "")

ccss_actors

ccss_actors |> count(name)


# packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(lubridate)
library(hrbrthemes)
library(here)
library(ggstream)

# Read data ---------------------------------------------------------------
clean_df <- read_rds(here("data", "wb_clean.rds"))


clean_df <- clean_df %>%
  filter(str_detect(type, "Paper|Article")) %>% 
  mutate(
    type = str_replace_all(type, "[\\n]", " "),
    type = str_squish(type),
  ) %>% 
  filter(!is.na(year)) 

clean_df %>% 
  group_by(year) %>%
  count() %>% 
  ggplot(
    aes(x = year, y = n)
  ) + 
  geom_col() + 
  labs(
    x = "Year",
    y = "Total number of papers",
    title = "Articles througout the years at the World Bank"
  ) +
  theme_ipsum_rc() +
  theme(
    panel.grid.minor.x = element_blank()
  )

clean_df %>% 
  group_by(year, type) %>% 
  add_tally() %>% view()
  filter(n == 5) 
  count(year, type) %>%
  ggplot(
    aes(x = year, y = n, fill = type, color = type, label = type)
  ) + 
  geom_stream(type = "ridge", n_grid = 3000, bw = .78) 
  
  add_count(year, type) %>% 
  complete(year, nesting(type), fill = list(n = 0)) %>% view()

clean_df <- df %>%
  mutate(
    date = mdy(document_date),
    year = year(date),
    # year = as_factor(year), 
    yday = yday(date),
    month = month(date),
    abstract = na_if(abstract, "not to be displayed--")
  )

clean_df %>%   
  group_by(year) %>% 
  count() %>% 
  ggplot(aes(x = year, y = n)) + 
  geom_col(color = "black") +
  theme_ipsum_rc()

clean_df %>%  
  group_by(year) %>% 
  summarize(
    sum = sum(download_stats)
  ) %>% 
  ungroup() %>% 
  ggplot(
    aes(x = year, y = sum)
  ) + 
  geom_col(color = "black") +
  scale_y_continuous(labels = scales::comma) + 
  theme_ipsum_rc()

clean_df %>% 
  group_by(year, month) %>% 
  summarize(
    sum = sum(download_stats)
  ) %>% 
  ungroup() %>% 
  filter(year > 2017) %>% 
  ggplot(
    aes(x = month, y = sum)
  ) + 
  geom_col() + 
  facet_wrap(~ year) +
  scale_x_continuous(breaks = seq(1,12,1), labels = c("Jan", "Feb", "Mar", "Apr",
                                                      "May", "Jun", "Jul", "Aug", 
                                                      "Sep", "Oct", "Nov", "Dec")) +
  scale_y_continuous(labels = scales::comma) + 
  theme_ipsum_rc()

# Reports and pubs --------------------------------------------------------
files <- list.files(path = "data/working papers/", pattern = "*.xlsx", full.names = TRUE)
pubs  <- map_df(files, read_excel) %>% 
  clean_names()

pubs_clean <- pubs %>%
  mutate(
    date = mdy(document_date),
    year = year(date),
    # year = as_factor(year), 
    yday = yday(date),
    month = month(date),
    abstract = na_if(abstract, "not to be displayed--")
  )

pubs_clean %>% 
  group_by(year) %>% 
  count() %>% 
  ggplot(aes(x = year, y = n)) + 
  geom_col(color = "black") + 
  theme_ipsum_rc()


pubs_clean %>% 
  group_by(year) %>% 
  summarize(
    sum = sum(download_stats)
  ) %>% 
  ggplot(aes(x = year, y = sum)) + 
  geom_col(color = "black") +
  scale_y_continuous(labels = scales::comma) + 
  theme_ipsum_rc()

pubs_clean %>%
  count(download_stats) %>% 
  filter(download_stats < 100000) %>% 
  ggplot(aes(x = download_stats, y = n)) + 
  geom_col() + 
  scale_x_continuous(labels = scales::comma) + 
  scale_y_continuous(labels = scales::comma) 

pubs_clean %>% 
  filter(str_detect(document_type, "Working Paper")) %>% 
  count(download_stats)

pubs_clean %>% 
  group_by(document_name) %>% 
  filter(n()>1) %>% view()


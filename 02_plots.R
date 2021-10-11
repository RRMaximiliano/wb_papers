
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
  filter(type %in% c("Policy Research Working Paper", "Working Paper", "Working Paper (Numbered Series)")) %>% 
  group_by(year) %>%
  count() %>% 
  ggplot(
    aes(x = year, y = n)
  ) + 
  geom_col(color = "black") + 
  labs(
    x = "Year",
    y = "Total number of papers",
    title = "Articles througout the years at the World Bank",
    subtitle = "Only works that were published under Policy Research Working Paper, Working Paper, and Working Paper (Numbered Series)"
  ) +
  scale_y_continuous(labels = scales::comma) + 
  theme_ipsum_rc() +
  theme(
    plot.title = element_text(family = "Inconsolata", size = 22),
    axis.text.x = element_text(family = "Inconsolata"), 
    axis.text.y = element_text(family = "Inconsolata"),     
    axis.title.y = element_text(hjust = 0.5, size = 12), 
    axis.title.x = element_text(hjust = 0.5, size = 12), 
    plot.caption = element_text(hjust = 0, size = rel(1.1)),
    panel.grid.minor = element_blank()
  )

ggsave(
  filename = "figs/downloads_year.png",
  dpi = 320,  
  height = 8, width = 16, 
  scale = 0.8,
  bg = "white"
)


clean_df %>% 
  filter(type %in% c("Policy Research Working Paper", "Working Paper", "Working Paper (Numbered Series)")) %>% 
  select(guid, year, download_count, title, type) %>% 
  mutate(
    cuts = cut(download_count, 
               breaks = c(0, 1000, 5000, 10000, 50000, 110000),
               labels = c("[0-1,000)", "[1,000-5,000)", "[5,000-10,000)", "[10,000-50,000)", "[50,000+)"),
               right = FALSE)
  ) %>% 
  count(cuts) %>% 
  ggplot(
    aes(x = cuts, y = n)
  ) + 
  geom_col(color = "black") + 
  geom_text(aes(label = scales::comma(n)), vjust = -0.5, family = "Inconsolata", size = 4) + 
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "Downloads (Categories)",
    y = "Number of papers",
    title = "Downloads distribution of Working Papers from the World Bank",
    subtitle = "The figure only includes papers that were categorized as 'Policy Research Working Paper', 'Working Paper', or 'Working Paper (Numbered Series)'\nfrom 1946 to 2021",
    caption = "Data: The World Bank Documents & Reports | Plot: @rrmaximiliano\nNotes: Downloads counts information as of October 7th, 2021"
  ) + 
  theme_ipsum_rc() + 
  theme(
    plot.title = element_text(family = "Inconsolata", size = 22),
    axis.text.x = element_text(family = "Inconsolata"), 
    axis.text.y = element_text(family = "Inconsolata"),     
    axis.title.y = element_text(hjust = 0.5, size = 12), 
    axis.title.x = element_text(hjust = 0.5, size = 12), 
    plot.caption = element_text(hjust = 0, size = rel(1.1)),
    panel.grid.minor = element_blank()
  )

ggsave(
  filename = "figs/downloads_counts.png",
  dpi = 320,  
  height = 8, width = 16, 
  scale = 0.8,
  bg = "white"
)



# packages ----------------------------------------------------------------

library(tidyverse)
library(janitor)
library(lubridate)
library(hrbrthemes)
library(here)
library(ggstream)
library(gt)
library(gtExtras)

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
    title = "Articles throughout the years at the World Bank",
    subtitle = "The figure only includes papers that were categorized as 'Policy Research Working Paper', 'Working Paper', or 'Working Paper (Numbered Series)'\nfrom 1946 to 2021",
    caption = "Data: The World Bank Documents & Reports | Plot: @rrmaximiliano\nNotes: Downloads counts information as of October 7th, 2021"
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

## DIME Papers

tab <- clean_df %>% 
  filter(str_detect(origu, "DIME|DECIE")) %>% 
  arrange(desc(download_count)) %>% 
  head(10) %>%
  mutate(
    teratopic = str_replace_all(teratopic, ",", ", "),
    download_count = scales::comma(download_count)
  ) %>% 
  select(authors, year, title, teratopic, geo_regions, download_count) %>% 
  gt() %>% 
  # gt_hulk_col_numeric(download_count) %>% 
  gt_merge_stack(col1 = title, col2 = authors) %>% 
  cols_label(
    download_count = md("Downloads"),
    year = "Published",
    title = md("Title & Authors"),
    teratopic = md("Topic"),
    geo_regions = md("Region of Study")
  ) %>% 
  tab_header(
    title = "Most downloaded papers from the Development Impact Evaluation Unit at the World Bank",
    subtitle = "Top 10 papers"
  )%>%
  tab_source_note(
    source_note = md("**Data:** The World Bank Documents & Reports | **Table:** @rrmaximiliano")
  )%>%
  tab_footnote(
    footnote = md("Downloads as of October 7th, 2021"),
    locations = cells_column_labels(columns = "download_count")
  ) %>% 
  # STYLE: Title
  tab_style(
    style = list(
      cell_text(
        font   = google_font(name = "Roboto Condensed"), 
        weight = "900",
        align  = "left", 
        color  = "#EAAA00"
      )
    ),
    locations = cells_title(groups = "title")
  ) %>% 
  # STYLE: Subtitle
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"), align = "left"
      )
    ),
    locations = cells_title(groups = "subtitle")
  ) %>%
  # STYLE: COLS 
  tab_style(
    style = list(
      cell_text(
        font  = google_font(name = "Roboto Condensed"), 
        align = "left", 
        v_align = "bottom"
      )
    ),
    locations = cells_column_labels(
      columns = c(authors, year, title, teratopic, geo_regions, download_count)
    )
  ) %>% 
  # STYLE: BODY - NUMBERS
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Inconsolata"),
        align = "left"
      )
    ),
    locations = cells_body(columns = c(year, download_count))
  ) %>% 
  # STYLE: BODY - Others
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"),
        align = "left",
      )
    ),
    locations = cells_body(columns = c(teratopic, geo_regions))
  ) %>% 
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"),
        align = "left",
        size = "large"
      )
    ),
    locations = cells_body(columns = c(title, authors))
  ) %>% 
  # STYLE: Footnote
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"), style = "italic"
      )
    ),
    locations = cells_footnotes()
  ) %>%
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed")
        )
    ),
    locations = cells_source_notes()
  ) %>%
  # LINES (BORDERS)
  tab_options(
    table.border.top.style = "hidden",
    table.border.bottom.style = "hidden"
  ) %>% 
  # Width
  cols_width(
    geo_regions ~ px(200)
  )
  
gtsave_extra(
  data = tab,
  filename = "figs/table_downloads.png"
)



# DEC ---------------------------------------------------------------------

tab_dec <- clean_df %>% 
  filter(str_detect(origu, "DECRG")) %>% 
  arrange(desc(download_count)) %>% 
  head(15) %>%
  mutate(
    teratopic = str_replace_all(teratopic, ",", ", "),
    download_count = scales::comma(download_count)
  ) %>% 
  select(authors, year, title, teratopic, geo_regions, download_count) %>% 
  gt() %>% 
  # gt_hulk_col_numeric(download_count) %>% 
  gt_merge_stack(col1 = title, col2 = authors) %>% 
  cols_label(
    download_count = md("Downloads"),
    year = "Published",
    title = md("Title & Authors"),
    teratopic = md("Topic"),
    geo_regions = md("Region of Study")
  ) %>% 
  tab_header(
    title = "Most downloaded papers from the Development Research Group Staff at the World Bank",
    subtitle = "Top 15 papers"
  )%>%
  tab_source_note(
    source_note = md("**Data:** The World Bank Documents & Reports | **Table:** @rrmaximiliano")
  )%>%
  tab_footnote(
    footnote = md("Downloads as of October 7th, 2021"),
    locations = cells_column_labels(columns = "download_count")
  ) %>% 
  # STYLE: Title
  tab_style(
    style = list(
      cell_text(
        font   = google_font(name = "Roboto Condensed"), 
        weight = "900",
        align  = "left", 
        color  = "#EAAA00"
      )
    ),
    locations = cells_title(groups = "title")
  ) %>% 
  # STYLE: Subtitle
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"), align = "left"
      )
    ),
    locations = cells_title(groups = "subtitle")
  ) %>%
  # STYLE: COLS 
  tab_style(
    style = list(
      cell_text(
        font  = google_font(name = "Roboto Condensed"), 
        align = "left", 
        v_align = "bottom"
      )
    ),
    locations = cells_column_labels(
      columns = c(authors, year, title, teratopic, geo_regions, download_count)
    )
  ) %>% 
  # STYLE: BODY - NUMBERS
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Inconsolata"),
        align = "left"
      )
    ),
    locations = cells_body(columns = c(year, download_count))
  ) %>% 
  # STYLE: BODY - Others
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"),
        align = "left",
      )
    ),
    locations = cells_body(columns = c(teratopic, geo_regions))
  ) %>% 
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"),
        align = "left",
        size = "large"
      )
    ),
    locations = cells_body(columns = c(title, authors))
  ) %>% 
  # STYLE: Footnote
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed"), style = "italic"
      )
    ),
    locations = cells_footnotes()
  ) %>%
  tab_style(
    style = list(
      cell_text(
        font = google_font(name = "Roboto Condensed")
      )
    ),
    locations = cells_source_notes()
  ) %>%
  # LINES (BORDERS)
  tab_options(
    table.border.top.style = "hidden",
    table.border.bottom.style = "hidden"
  ) %>% 
  # Width
  cols_width(
    geo_regions ~ px(200)
  )

gtsave_extra(
  data = tab_dec,
  filename = "figs/table_dec_downloads.png"
)


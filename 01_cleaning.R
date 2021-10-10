
# packages ----------------------------------------------------------------

library(tidyverse)
library(lubridate)
library(here)

# Load data ---------------------------------------------------------------

papers_df     <- read_rds(here("data", "wb_documents.rds"))
downloads_df  <- read_rds(here("data", "wb_downloads.rds"))

df <- papers_df %>% 
  mutate(
    n = row_number()
  ) %>% 
  left_join(
    downloads_df %>% 
      mutate(
        n = row_number()
      ), by = c("n", "guid")
  ) %>% 
  select(name, guid, docdt, display_title, download_count, everything())

clean_df <- df %>% 
  # Unnest abstracts (2 levels)
  unnest(cols = abstracts, keep_empty = TRUE) %>%  
  unnest(cols = abstracts, keep_empty = TRUE) %>%
  # Mutate main vars
  mutate(
    date = ymd_hms(docdt),
    date = as_date(date),
    year = year(date),
    yday = yday(date),
    month = month(date),
    display_title = str_squish(display_title),
    abstracts = unlist(abstracts),
    abstracts = str_remove_all(abstracts, "cdata!"),
    abstracts = str_replace_all(abstracts, "[\\r\\n]", " "),
    abstracts = str_remove_all(abstracts, "[^.[:^punct:]]"),
    abstracts = str_squish(abstracts)
  ) %>% 
  # Keep relevant vars
  select(
    name, id, title = display_title, abstracts, date, year, month, yday, 
    region = count, type = docty, type_key = docty_key, owner, 
    lang, subtopic, teratopic, geo_regions, pdfurl, version = versiontyp, 
    projectid, available_in, authors, keywords = keywd, colti, origu, dois, 
  )

# Authors
clean_df <- clean_df %>% 
  mutate(
    authors = map_chr(authors, toString),
    authors = str_replace_all(authors, "\"", ""),
    authors = str_replace_all(authors, "[)],", "; "),
    authors = str_remove_all(authors, "[()]"),
    authors = str_remove_all(authors, "list|author|\\`|\\=|[[:digit:]]"),
    authors = str_replace_all(authors, ",", ", "),
    authors = str_squish(authors)
  ) 

# Geo Regions
clean_df <- clean_df %>% 
  mutate(
    geo_regions = map_chr(geo_regions, toString),
    geo_regions = str_replace_all(geo_regions, "\"", ""),
    geo_regions = str_replace_all(geo_regions, "[)],", "; "),
    geo_regions = str_remove_all(geo_regions, "[()]"),
    geo_regions = str_remove_all(geo_regions, "geo_region"),
    geo_regions = str_remove_all(geo_regions, "list|\\`|\\=|[[:digit:]]"),
    geo_regions = str_replace_all(geo_regions, ",", ", "),
    geo_regions = str_squish(geo_regions)
  )

clean_df %>% 
  write_rds(here("data", "wb_clean.rds"))

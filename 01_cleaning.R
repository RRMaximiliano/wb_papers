# Load data ---------------------------------------------------------------

df <- read_rds(here("data", "wb_complete.rds"))

clean_df <- df %>% 
  mutate(
    date = ymd_hms(docdt),
    date = as_date(date),
    year = year(date),
    yday = yday(date),
    month = month(date),
    display_title = str_squish(display_title)
  ) %>% 
  select(
    name, id, title = display_title, abstracts, date, year, month, yday, 
    region = count, type = docty, type_key = docty_key, owner, 
    lang, subtopic, teratopic, geo_regions, pdfurl, version = versiontyp, 
    projectid, available_in, authors, keywords = keywd, colti, origu, dois, 
  ) 

clean_df <- clean_df %>%
  unnest_wider(authors, names_sep = "_")

test <- clean_df %>% 
  mutate(
    across(
      starts_with("authors"), 
      ~ str_remove_all(str_squish(.x), "list|author|\\`|\\=|[^,[:^punct:]]|[[:digit:]]") 
    )
  )











df <- map_dfr(list, ~ as.data.frame(t(.))) %>% 
  filter(abstracts != "NULL",
         url != "NULL") %>% 
  select(paper = display_title, abstracts, authors, region = admreg, country = count, url, area = teratopic, date = disclosure_date) %>% 
  mutate(
    abstracts = unlist(abstracts), 
    across(
      where(is.list), as.character
    )
  ) %>% 
  as_tibble() %>% 
  mutate(
    abstracts = str_replace_all(abstracts, "[\\r\\n]", " "),
    abstracts = str_remove_all(abstracts, "[^.[:^punct:]]"),
    abstracts = str_replace_all(abstracts, fixed("  "), ""),
    paper = str_replace_all(paper, fixed("  "), ""),
    authors = str_replace_all(authors, ", ", " and "),
    authors = str_remove_all(authors, "list|author|\\`|\\=|[^,[:^punct:]]|[[:digit:]]"),
    authors = str_replace_all(authors, ",", ", "),
    authors = str_replace_all(authors, fixed("  "), ""),
    date = str_extract(date, "^.{10}"),
    date = lubridate::ymd(date),
    region = str_split(region, ",") %>% map_chr(., 1),
    area = str_replace_all(area, ",", ", "),
    area = na_if(area, "NULL")
  ) %>% 
  distinct(abstracts, .keep_all = TRUE)




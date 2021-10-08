
# packages ----------------------------------------------------------------

library(tidyverse)
library(jsonlite)
library(lubridate)
library(progress)
library(here)

# setup -------------------------------------------------------------------

SCRAPE      = 0
SCRAPE_DOWN = 0

SAVE_PAPERS     = 0
SAVE_DOWNLOADS  = 0

# JSON Data ---------------------------------------------------------------

if(SCRAPE == 1) {
  paper_df <- tibble(.rows = NULL)
  main     <- fromJSON("https://search.worldbank.org/api/v2/wds?format=json&fct=docty_exact,count_exact,lang_exact,disclstat_exact&apilang=en&rows=50&os=0&majdocty_key=658101&srt=docdt&order=desc")
  
  len  <- floor(main$total / 100) * 100 
  
  for(docid in seq(0,len,50)){
    cat(docid, "/", len, "\n")
    
    page <- fromJSON(paste0("https://search.worldbank.org/api/v2/wds?format=json&fct=docty_exact,count_exact,lang_exact,disclstat_exact&apilang=en&rows=50&os=",docid,"&majdocty_key=658101&srt=docdt&order=desc"), flatten = TRUE)
    
    list <- page$documents
    df   <- enframe(list) %>% 
      unnest_wider(value) %>% 
      filter(name != "facets")
    
    paper_df <- bind_rows(paper_df, df)
    
  }
} 

# Save data frames --------------------------------------------------------

## Papers
if(SAVE_PAPERS == 1) {
  paper_df %>% 
    write_rds(here("data", "wb_documents.rds"))
} 

# Download Counts ---------------------------------------------------------

if(SCRAPE_DOWN == 1) {
  full_df <- read_rds(here("data", "wb_documents.rds"))
  
  down_df <- tibble(.rows = NULL)
  guid    <- full_df$guid %>% as.list()
  len     <- length(guid)
  
  for(docid in 1:length(guid)) {
    
    paper <- guid[[docid]]
    cat(docid, "/", length(guid), "\n")
    
    page <- fromJSON(paste0("https://pubdocdata.worldbank.org/PubDataSourceAPI/downloadstats?GuId=", paper, "&DocFormat=renderedpdf&index="), flatten = TRUE)
    
    df <- data.frame(
      guid = paper, 
      download_count = page$downloadCount
    )
    
    down_df <- bind_rows(down_df, df)

  }
}

# Save data frames --------------------------------------------------------

## Downloads counts

if(SAVE_DOWNLOADS == 1) {
  down_df %>% 
    write_rds(here("data", "wb_downloads.rds"))
}


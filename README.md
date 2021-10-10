
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The World Bank documents and reports

<!-- badges: start -->
<!-- badges: end -->

This repository contains two datasets: (1) `wb_documents` and (2)
`wb_downloads`, both in `rds` format. The data was scraped on October
7th. Therefore, the download counts information is as of that date.

## wb_documents

``` r
wb_documents
#> # A tibble: 95,325 x 84
#>    name   id    last_modified_d~ admreg admreg_key authors count count_key docna
#>    <chr>  <chr> <chr>            <chr>  <chr>      <list>  <chr> <chr>     <lis>
#>  1 D3346~ 3346~ 2021-10-06T00:0~ East ~ 119225,11~ <named~ East~ 517199    <nam~
#>  2 D3346~ 3346~ 2021-10-06T00:0~ Europ~ 119226,11~ <named~ Arme~ 82665,82~ <nam~
#>  3 D3346~ 3346~ 2021-10-02T00:0~ Afric~ 1927320,1~ <NULL>  Cent~ 82657     <nam~
#>  4 D3319~ 3319~ 2021-06-18T00:0~ South~ 119231,11~ <named~ Nepal 82535     <nam~
#>  5 D3346~ 3346~ 2021-10-06T00:0~ The W~ 622170,62~ <named~ World 517191    <nam~
#>  6 D3346~ 3346~ 2021-10-02T00:0~ Afric~ 1927320,1~ <NULL>  Cent~ 82657     <nam~
#>  7 D3319~ 3319~ 2021-06-21T00:0~ Afric~ 1927320,1~ <named~ Chad  82693     <nam~
#>  8 D3346~ 3346~ 2021-10-06T00:0~ The W~ 622170,62~ <named~ World 517191    <nam~
#>  9 D3346~ 3346~ 2021-10-05T00:0~ Latin~ 119228,11~ <named~ Arge~ 82668     <nam~
#> 10 D3346~ 3346~ 2021-10-04T00:0~ East ~ 119225,11~ <named~ Viet~ 82695     <nam~
#> # ... with 95,315 more rows, and 75 more variables: docty <chr>,
#> #   docty_key <chr>, owner <chr>, seccl <chr>, lang <chr>, lang_key <chr>,
#> #   entityids <list>, subtopic <chr>, subtopic_key <chr>, teratopic <chr>,
#> #   teratopic_key <chr>, repnb <chr>, docdt <chr>, datestored <chr>,
#> #   keywd <list>, volnb <chr>, majdocty <chr>, majdocty_key <chr>,
#> #   abstracts <list>, colti <chr>, repnme <list>, display_title <chr>,
#> #   disclosure_date <chr>, disclosure_type <chr>, pdfurl <chr>, ...
```

### variables

    #> Rows: 95,325
    #> Columns: 84
    #> $ name                  <chr> "D33469805", "D33469617", "D33460018", "D3319129~
    #> $ id                    <chr> "33469805", "33469617", "33460018", "33191290", ~
    #> $ last_modified_date    <chr> "2021-10-06T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ admreg                <chr> "East Asia and Pacific,East Asia and Pacific", "~
    #> $ admreg_key            <chr> "119225,119225", "119226,119226", "1927320,19273~
    #> $ authors               <list> [["Arur,Aneesa"], ["Islamaj,Ergys"], ["Kim,Youn~
    #> $ count                 <chr> "East Asia and Pacific", "Armenia,Belarus,Georgi~
    #> $ count_key             <chr> "517199", "82665,82654,82619,82569,82547,82514,8~
    #> $ docna                 <list> [["Managing Long COVID in East Asia and the Pac~
    #> $ docty                 <chr> "Brief", "Policy Research Working Paper", "Repor~
    #> $ docty_key             <chr> "965331", "620265", "540664", "540664", "620265"~
    #> $ owner                 <chr> "DECRG: Macroeconomics & Growth (DECMG)", "Off o~
    #> $ seccl                 <chr> "Public", "Public", "Public", "Public", "Public"~
    #> $ lang                  <chr> "English", "English", "French", "English", "Engl~
    #> $ lang_key              <chr> "120701", "120701", "120702", "120701", "120701"~
    #> $ entityids             <list> ["090224b088a4229f_1_0"], ["090224b088a402b7_1_~
    #> $ subtopic              <chr> "Early Child and Children's Health,Public Health~
    #> $ subtopic_key          <chr> "672915,672913,738806,672911,672914,672747,79342~
    #> $ teratopic             <chr> "Industry,Law and Development,Health, Nutrition ~
    #> $ teratopic_key         <chr> "644286,644282,644300", "644295,644291,644302,64~
    #> $ repnb                 <chr> "164857", "WPS9795", "164830", "160705", "WPS979~
    #> $ docdt                 <chr> "2021-10-07T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ datestored            <chr> "2021-10-06T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ keywd                 <list> [["Association of Southeast Asian Nations;\n   ~
    #> $ volnb                 <chr> "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"~
    #> $ majdocty              <chr> "Publications & Research", "Publications & Resea~
    #> $ majdocty_key          <chr> "658101", "658101", "658101,658101", "658101,658~
    #> $ abstracts             <list> ["The highly contagious Delta variant is\n     ~
    #> $ colti                 <chr> "Research & Policy Briefs,no. 51", "Policy Resea~
    #> $ repnme                <list> ["Managing Long COVID in East Asia and the Paci~
    #> $ display_title         <chr> "Managing Long COVID in East Asia and\n         ~
    #> $ disclosure_date       <chr> "2021-10-06T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ disclosure_type       <chr> "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", ~
    #> $ pdfurl                <chr> "http://documents.worldbank.org/curated/en/17998~
    #> $ txturl                <chr> "http://documents.worldbank.org/curated/en/17998~
    #> $ listing_relative_url  <chr> "/research/2021/10/33469805/managing-long-covid-~
    #> $ url_friendly_title    <chr> "http://documents.worldbank.org/curated/en/17998~
    #> $ new_url               <chr> "2021/10/33469805/Managing-Long-COVID-in-East-As~
    #> $ ext_pub_date          <chr> "2021-10-06T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ disclstat             <chr> "Disclosed", "Disclosed", "Disclosed", "Disclose~
    #> $ topicv3               <chr> "Immunizations m1327505 1459,Mortality m1504365 ~
    #> $ docm_id               <chr> "090224b088a4229f", "090224b088a402b7", "090224b~
    #> $ chronical_docm_id     <chr> "090224b088a4229f", "090224b088a402b7", "090224b~
    #> $ publishtoextweb_dt    <chr> "2021-10-06T00:00:00Z", "2021-10-06T00:00:00Z", ~
    #> $ totvolnb              <chr> "1", "1", "1", "1", "1", "1", "1", "1", NA, "1",~
    #> $ versiontyp            <chr> "Final", "Final", "Final", "Revised", "Final", "~
    #> $ versiontyp_key        <chr> "1309935", "1309935", "1309935", "1309936", "130~
    #> $ historic_topic        <chr> "Industry,Law and Development,Health, Nutrition ~
    #> $ guid                  <chr> "179981633527816046", "426681633524510673", "870~
    #> $ available_in          <chr> "English", "English", "French", "English", "Engl~
    #> $ fullavailablein       <list> [<data.frame[1 x 3]>], [<data.frame[1 x 3]>], [~
    #> $ url                   <chr> "http://documents.worldbank.org/curated/en/17998~
    #> $ geo_region_mdks       <list> <NULL>, [["South Eastern Europe and Balkans!$!5~
    #> $ geo_regions           <list> <NULL>, [["South Eastern Europe and Balkans"], ~
    #> $ geo_reg_key           <chr> NA, "517208,545134,517191,82689,517198", "517196~
    #> $ dois                  <chr> NA, "10.1596/1813-9450-9795", NA, NA, "10.1596/1~
    #> $ origu                 <chr> NA, "EFI-ECA-POV-Poverty and Equity (EECPV)", NA~
    #> $ projn                 <chr> NA, NA, "CF-Social Protection Policy And Forced\~
    #> $ trustfund             <chr> NA, NA, "TF0A4776-CAR RSR 2017,TF0A8561-R14 - CA~
    #> $ trustfund_key         <chr> NA, NA, "1548833,1681984", NA, NA, "1548833,1681~
    #> $ prdln                 <chr> NA, NA, "Advisory Services & Analytics", "Adviso~
    #> $ prdln_key             <chr> NA, NA, "1416466", "1416466", NA, "1416466", "14~
    #> $ projectid             <chr> NA, NA, "P163501", "P175443", NA, "P163501", "P1~
    #> $ ml_abstracts          <chr> NA, NA, "$^$^$french", NA, NA, "$^$^$french", NA~
    #> $ alt_title             <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ theme                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ majtheme              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ sectr                 <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ sectr_key             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ bdmdt                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ isbn                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ count_exact           <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ docty_exact           <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ lang_exact            <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ disclstat_exact       <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ src_cit               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ subsc                 <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ lndinstr              <list> <NULL>, <NULL>, <NULL>, <NULL>, <NULL>, <NULL>,~
    #> $ lndinstr_key          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ loan_no               <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ issn                  <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ virt_coll             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ credit_no             <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~
    #> $ EnvironmentalCategory <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ~

## wb_downloads

``` r
wb_downloads
#> # A tibble: 95,325 x 2
#>    guid               download_count
#>    <chr>                       <int>
#>  1 179981633527816046             64
#>  2 426681633524510673             17
#>  3 870291633497564723              2
#>  4 233291624285050426             59
#>  5 178841633526651703             33
#>  6 760741633497864137              4
#>  7 642041633397593711             17
#>  8 961501633497058891              2
#>  9 786301633477418850              1
#> 10 826921633442977133             28
#> # ... with 95,315 more rows
```

### variables

    #> Rows: 95,325
    #> Columns: 2
    #> $ guid           <chr> "179981633527816046", "426681633524510673", "8702916334~
    #> $ download_count <int> 64, 17, 2, 59, 33, 4, 17, 2, 1, 28, 3, 18, 117, 1, 28, ~

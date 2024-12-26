# Libraries ------------------------------------------------------------------
# runApp(launch.browser = FALSE)
## For web interface
library(shiny)
library(shinydashboard)
# Data handling
library(DT)
library(dplyr)
library(tidyr)
# Plotting
library(ggplot2)
library(plotly)
library(viridis)

# Set default browser
options(browser='firefox')

# Functions
trimws_df <- function(x, ...){
  x[] <- lapply(x, trimws, ...)
  x
}


# Relevant data
cites <- read.csv("www/assets/scopus_CitationOverview.csv")
pubs <- read.csv("www/assets/scopusPubs.csv")

# Merge specific columns from `pubs` to `cites`
cites <- merge(cites, 
  subset(pubs, select=c(Title, first_author, corr_auth, 
                        Document.Type)), by="Title")


## Clean data
### Drop all rows where only NA
pubs <- pubs[rowSums(is.na(pubs)) != ncol(pubs), ]
### Put in order by year
pubs <- pubs[order(pubs$Year, decreasing=TRUE),]
pubs <- pubs[which(pubs$Document.Type != "Erratum"),]
### Create combined "page" column
pubs$Page <- ifelse(is.na(pubs$Page.start) | pubs$Page.start == "", 
                    pubs$Art..No., pubs$Page.start)

# Citation conversion
#cites <- pivot_longer(cites,
#  cols=-c(Title, Publication.Year, Source.title, first_author, 
#          corr_auth, Document.Type))
#names(cites)[names(cites) == 'name'] <- 'year'
#names(cites)[names(cites) == 'value'] <- 'citations'
#cites$year <- gsub("X","", cites$year)
#cites$year <- as.numeric(cites$year)

# Publications per year
#names(pub_yr)[names(pub_yr) == 'Publication.Year'] <- 'year'
#names(pub_yr)[names(pub_yr) == 'n'] <- 'no_pubs'


# Summary of citation data
#summ_cites <- cites |> group_by(year) |>
#  summarize(
#    sum_cites = sum(citations)
#  )
#summ_cites <- summ_cites[which(summ_cites$year >= 2010),]
#summ_cites <- merge(summ_cites, pub_yr, by="year")

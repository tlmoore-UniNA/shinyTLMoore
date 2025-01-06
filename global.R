# Libraries ------------------------------------------------------------------
# runApp(launch.browser = FALSE)
# rsconnect::deployApp(appName="nanoHTFS")
## For web interface
library(shiny)
library(shinydashboard)
#library(rsvg)
# Data handling
library(DT)
library(dplyr)
library(tidyr)
# Text processing
library(tm)
library(SnowballC)
library(stringr)
#library(wordcloud)
# Plotting
library(ggnetwork)
library(ggplot2)
library(igraph)
library(plotly)
library(viridis)
library(wordcloud2)

# Set default browser
options(browser='firefox')

# Deploy app
# deployApp(appName="TLMoore")

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

# Network data ==============================================================
net <- subset(pubs, select=c(Authors, DOI))

net <- net |>
    mutate(Authors = strsplit(as.character(Authors), ";")) |>
    unnest(Authors)

  net <- trimws_df(net)
  net <- net[order(net$Authors),]
  net$Authors <- gsub("Moore T.L.", "Moore T.", net$Authors)
  net$Authors <- gsub("Manghnani P.N.", "Manghnani P.", net$Authors)
  net$Authors <- gsub("Milosevic A.M.", "Milosevic A.", net$Authors)
  net$Authors <- gsub("Urban D.A.", "Urban D.", net$Authors)
  net$Authors <- gsub("Mascolo D.D.", "Di Mascolo D.", net$Authors)
  net$Authors <- gsub("Podilakrishna R.", "Podila R.", net$Authors)
  net$Authors <- gsub("Rao A.M.", "Rao A.", net$Authors)
  
inst <- read.csv("www/assets/uniqueAuthors.csv")
net <- merge(net, inst, by=c("Authors"))

edges <- net |>
    group_by(DOI) |>
    summarize(Authors = paste(Authors, collapse = ";")) |>
    separate_rows(Authors, sep = ";") |>
    ungroup() |>
    mutate(from = Authors, to = lead(Authors)) |>
    na.omit()

# Extract unique authors (vertices) from the edge list
vertices <- unique(c(edges$from, edges$to))

edges <- subset(edges, select=-c(DOI, Authors))

graph <- graph_from_data_frame(d=edges, vertices = data.frame(name =vertices))

# Graph layout
#graph_layout <- layout_as_tree(graph) # ! top
graph_layout <- layout_nicely(graph) # maybe
#graph_layout <- layout_with_kk(graph)

# Calculate node degrees (number of connections)
node_degrees <- degree(graph)
node_degrees <- as.data.frame(node_degrees)
node_degrees$Authors <- row.names(node_degrees)
names(node_degrees)[names(node_degrees) == 'node_degrees'] <- "degree"


# Join author names with their institutes and degrees
vertex_data <- data.frame(name = vertices) |>
  left_join(unique(net[, c("Authors", "institute")]), 
            by = c("name" = "Authors"))

# Create ggnetwork object and merge with institutes
ggnet <- ggnetwork(graph,
      layout=graph_layout, arrow.gap=0,
        # Add vertex data to the ggnetwork object
        cell.props = list(vertex.names = vertex_data$name,
                          vertex.color = vertex_data$institute))
names(ggnet)[names(ggnet) == 'name'] <- 'Authors'
ggnet <- merge(ggnet, inst, by=c("Authors"))
ggnet <- merge(ggnet, node_degrees, by=c("Authors"))

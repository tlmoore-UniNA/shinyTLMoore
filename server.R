server <- function(input, output, session){

# Publications data table (pubTab) ===========================================
output$pubTab <- DT::renderDataTable({
  tmp <- pubs
  # Select relevant columns
  tmp <- subset(tmp, select=c(Authors, Title, Year, Source.title, Volume, Page,
          DOI, Document.Type, Cited.by, first_author, corr_auth))
  tmp <- trimws_df(tmp) # trim left/right white spaces
  tmp$Cited.by <- as.numeric(tmp$Cited.by)

  # Publication years
  if (input$pubYear == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Year == input$pubYear),]
  } # End ifelse

  # Document type
  if (input$docType == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Document.Type == input$docType),]
  }

  # First author?
  if (input$firstAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$first_author == 1),]
  }

  # Corresponding author?
  if (input$corrAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$corr_auth == 1),]
  }

  # Clean table
  tmp <- subset(tmp, select=-c(first_author, corr_auth, Document.Type))

  table <- DT::datatable(tmp)
},
  options = list(
    autoWidth=TRUE, pageLength=30,
    columnDefs=list(list(width='200px', targets="_all")) # columnDefs
    ## To change multiple column widths 
    # columnDefs = list(#
    #   list(width='200px', targets=c(0,2)), # End first definitions
    #   list(width='80px', targets=c(6)) # End second definitions
    # ) # End columnDefs
  ) # End options list
) # End pubTab

# Publication plots ==========================================================
## Dynamic data frames
# Publication summary
tmp_summ_pubs <- reactive({
  tmp <- pubs

  # Document type
  if (input$plot_docType == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Document.Type == input$plot_docType),]
  }

  # First author?
  if (input$plot_firstAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$first_author == 1),]
  }

  # Corresponding author?
  if (input$plot_corrAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$corr_auth == 1),]
  }


  summ_tmp <- tmp |> group_by(Year, Document.Type) |>
    count()

  return(summ_tmp)
})

## Publications per year -----------------------------------------------------
output$plot_pubYrs <- renderPlotly({
  ggplotly(
    ggplot(tmp_summ_pubs()[which(tmp_summ_pubs()$n > 0),], 
           aes(Year, n, fill=Document.Type))+
      geom_col(colour="#FAFAFA")+
      scale_x_continuous(name = "Year")+
      scale_y_continuous(name="No. new publications")+
      scale_fill_viridis_d(option="H")+
      theme(legend.position="none",
            panel.background=element_rect(fill="#ecf0f5", colour="black"),
            plot.background=element_rect(fill="#ecf0f5"))
  )
})

# Citations
tmp_cites <- reactive({
  tmp <- pivot_longer(cites,
    cols=-c(Title, Publication.Year, Source.title, first_author,
            corr_auth, Document.Type))
  names(tmp)[names(tmp) == 'name'] <- 'year'
  names(tmp)[names(tmp) == 'value'] <- 'citations'
  tmp$year <- gsub("X","", tmp$year)
  tmp$year <- as.numeric(tmp$year)

  # Document type
  if (input$plot_docType == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Document.Type == input$plot_docType),]
  }

  # First author?
  if (input$plot_firstAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$first_author == 1),]
  }

  # Corresponding author?
  if (input$plot_corrAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$corr_auth == 1),]
  }

  return(tmp)
})

## Citations per year --------------------------------------------------------
output$plot_citeYrs <- renderPlotly({
  ggplotly(
    ggplot(tmp_cites()[which(tmp_cites()$citations > 0),], 
        aes(year, citations, fill=Title))+
      geom_col()+
      scale_x_continuous(name = "Year")+
      scale_y_continuous(name="No. new citations")+
      scale_fill_viridis_d()+
      theme(legend.position="none",
            panel.background=element_rect(fill="#ecf0f5", colour="black"),
            plot.background=element_rect(fill="#ecf0f5"))
  )
})

## Pie chart -----------------------------------------------------------------
output$plot_piePubs <- renderPlotly({

  clrs <- viridis_pal(option = "H")(4)

  df <- pubs |> group_by(Document.Type) |>
    count()

  plot_ly(type='pie', labels=df$Document.Type, values=df$n, 
          textinfo='label+percent',
          insidetextorientation='radial',
          marker = list(colors=clrs)) |> 
    layout(showlegend = FALSE,
           paper_bgcolor='#ecf0f5',
           plot_bgcolor='#ecf0f5')
})

## Network plot -------------------------------------------------------------- 
output$plot_network <- renderPlotly({
  ggplotly(
    ggplot(ggnet, 
        aes(x = x, y = y, xend = xend, yend = yend))+
      geom_edges(color = "grey50", alpha=I(0.5))+
      geom_nodes(aes(text=Authors, size=degree, fill=institute), 
                 shape=21)+
#      ggtitle("Publication network")+
      scale_fill_viridis_d(option="H")+
      scale_size(range = c(3, 6))+
      theme_blank()+
      theme(legend.position="none",
            panel.background=element_rect(fill="#ecf0f5", colour="black"),
            plot.background=element_rect(fill="#ecf0f5"))
  )
})

## Publications wordcloud ----------------------------------------------------
tmp_dtm <- reactive({
  
  tmp <- pubs

  # Document type
  if (input$wc_docType == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Document.Type == input$wc_docType),]
  }

  # First author?
  if (input$wc_firstAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$first_author == 1),]
  }

  # Corresponding author?
  if (input$wc_corrAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$corr_auth == 1),]
  }

  # Get text data for word cloud
  absText <- VectorSource(tmp$abstract)
  absText <- VCorpus(absText)
  # Clean corpus
  absText <- tm_map(absText, content_transformer(tolower))
  absText <- tm_map(absText, PlainTextDocument)
  absText <- tm_map(absText, removeNumbers)
  absText <- tm_map(absText, removeWords, stopwords("english"))
  absText <- tm_map(absText,removePunctuation)
  absText <- tm_map(absText,stripWhitespace)

  # Create document text matrix
  dtm <- TermDocumentMatrix(absText)
  dtm <- as.matrix(dtm)
  sorted_dtm <- sort(rowSums(dtm), decreasing=TRUE)
  df_wc <- data.frame(word=names(sorted_dtm), freq=sorted_dtm)
  rownames(df_wc)=NULL

  # Substitutions
  df_wc$word <- str_replace(df_wc$word, "nps","nanoparticles")
  df_wc$word <- str_replace(df_wc$word, "particles","particle")
  df_wc$word <- str_replace(df_wc$word, "vitro","in vitro")
  df_wc$word <- str_replace(df_wc$word, "in in vitro","in vitro")
  df_wc$word <- str_replace(df_wc$word, "vivo","in vivo")
  df_wc$word <- str_replace(df_wc$word, "in in vivo","in vivo")
  df_wc$word <- str_replace(df_wc$word, "nanoparticles","nanoparticle")

  # Summarize abstract words
  df_wc <- df_wc |> group_by(word) |>
    summarize(freq=sum(freq))

  # Remove common words
  df_wc <- df_wc[which(!df_wc == "also"),]
  df_wc <- df_wc[which(!df_wc == "within"),]
  df_wc <- df_wc[which(!df_wc == "however"),]

  # NA omit
  df_wc <- na.omit(df_wc)
  df_wc <- df_wc[order(df_wc$freq, decreasing=TRUE),]
  df_wc <- df_wc[1:100,]

  return(df_wc)
})

output$plot_wordcloud <- renderWordcloud2({
  df <- tmp_dtm()
  p <- wordcloud2(df, color='random-dark', size=0.66,
                  backgroundColor="#ecf0f5", fontFamily="Roboto")
  return(p)
#  wordcloud <- htmltools::html_print(p)
#  return(wordcloud)
})

# CV Download ================================================================
output$downloadCV <- downloadHandler(
    filename = "CV_MooreT.pdf",
    content = function(file) {
      file.copy("www/assets/CV_MooreT.pdf", file)
    }
  )

} # End server

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
      scale_y_continuous(name="No. new citations per year")+
      scale_fill_viridis_d()+
      theme(legend.position="none",
            panel.background=element_rect(fill="#ecf0f5", colour="black"),
            plot.background=element_rect(fill="#ecf0f5"))
  )
})

### Network plot
output$plot_network <- renderPlotly({
  ggplotly(
    ggplot(ggnet, 
        aes(x = x, y = y, xend = xend, yend = yend))+
      geom_edges(color = "grey50", alpha=I(0.5))+
      geom_nodes(aes(text=Authors, size=degree, fill=institute), 
                 shape=21)+
      ggtitle("Publication network")+
      scale_fill_viridis_d(option="H")+
      scale_size(range = c(3, 6))+
      theme_blank()+
      theme(legend.position="none",
            panel.background=element_rect(fill="#ecf0f5", colour="black"),
            plot.background=element_rect(fill="#ecf0f5"))
  )
})

} # End server

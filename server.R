server <- function(input, output, session){

# Publications data table (pubTab) ===========================================
output$pubTab <- DT::renderDataTable({
  tmp <- pubs
  if (input$pubYear == "All Publications"){#
    tmp <- tmp
  } else {#
    tmp <- tmp[which(tmp$Publication.Year == input$pubYear),]
  } # End ifelse

  if (input$firstAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$first_author == 1),]
  }

  if (input$corrAuth == FALSE){#
    tmp <- tmp
  } else {
    tmp <- tmp[which(tmp$corr_auth == 1),]
  }

  tmp <- subset(tmp, select=-c(first_author, corr_auth, keywords))

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

} # End server

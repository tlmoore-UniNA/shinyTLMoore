pubPage <- tabItem(tabName="pubs",
  navbarPage("Research Output", 
    tabPanel("Publications", icon=icon("newspaper"),
      h1("Publications"),
      fluidRow(
        column(2,
          selectInput("pubYear",
          h4("Publication Year"),
          choices=c(#
            list("All Publications"="All Publications"),#
            unique(pubs$Year)),
          selected=FALSE) # End selectInput
        ), # End column
        column(2,
          selectInput("docType",
          h4("Document Type"),
          choices=c(#
            list("All Publications"="All Publications"),
            unique(pubs$Document.Type))
          ) # End selectInput
        ), # End column
        column(4,
          checkboxInput("firstAuth", "First/Co-first Author", value=FALSE),
          checkboxInput("corrAuth", "Corresponding/Co-corresponding Author",# 
                        value=FALSE)
        ) # End column
      ), # End fluidRow
        # Updated
        p(strong("Last Updated:"), "18 December 2024"),
        # Publications table
        DT::dataTableOutput("pubTab")
    ), # End tabPanel "Publications"
    tabPanel("Research Summary", icon=icon("chart-pie"),
      fluidRow(
        column(2,
          selectInput("plot_docType",
          h4("Document Type"),
          choices=c(#
            list("All Publications"="All Publications"),
            unique(cites$Document.Type))
          ) # End selectInput
        ), # End column
        column(4,
          checkboxInput("plot_firstAuth", "First/Co-first Author", 
                        value=FALSE),
          checkboxInput("plot_corrAuth", 
                        "Corresponding/Co-corresponding Author",# 
                        value=FALSE)
        ) # End column
      ), # End fluidRow
      fluidRow(
        column(4,
          plotlyOutput("plot_pubYrs")
        ), # End column
        column(8,
          plotlyOutput("plot_citeYrs")
        )
      ) # End fluidRow
    ) # End tabPanel 
  ) # End navbarPage
) # End tabItem

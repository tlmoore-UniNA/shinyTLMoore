pubPage <- tabItem(tabName="pubs",
  h1("Publications"),
  fluidRow(
    column(2,
      selectInput("pubYear",
        h4("Publication Year"),
        choices=c(#
            list("All Publications"="All Publications"),#
            unique(pubs$Publication.Year)),
          selected=FALSE) # End selectInput
    ), # End column
    column(2,
      checkboxInput("firstAuth", "First/Co-first Author", value=FALSE)
    ), # End column
    column(4,
      checkboxInput("corrAuth", "Corresponding/Co-corresponding Author", value=FALSE)
    ) # End column
  ), # End fluidRow
  DT::dataTableOutput("pubTab")
) # End pubPage

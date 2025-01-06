researchPage <- tabItem(tabName="research",
  navbarPage("Research",
# RESEARCH ===================================================================
    tabPanel("Research", icon=icon("flask-vial"),
      fluidRow(
        column(4,
          h4(strong("Nanomedicines for nucleic acid delivery")),
          #br(),
          p("Within the framework of Spoke 8 of the National Recovery and 
            Resiliance Plan (PNRR,", 
            tags$a(href="https://www.rna-genetherapy.eu/spokes/spoke-8/", "www.rna-genetherapy.eu", 
                   target="_blank"),
            "), our goal is to develop nanomedicines for the delivery of 
            nucleic acids. This encompasses lipid nanoparticles, liposomes,
            and polymeric nanoparticles for the delivery of mRNA, siRNA, cDNA,
            etc."), # End p()
          p("We are interested in developing not only functional, 
            translational nano-formulations, but also evaluating the 
            fundametal interactions of those particles on a sub-cellular,
            cellular, and system level to gain fundamental insights into 
            nanoparticle structure-function relationships.")
        ), # End column
        column(4,
          h4(strong("Automation in nanoparticle production and characterization")),
          #br(),
          p("Increasingly, automation is finding a place in the research 
            laboratory space. In fact, automated processes have long been a 
            part of the chemical and pharmaceutical industries, and recent 
            developments have enabled such a workflow in the 'nano world.'"),
          p("We are interested in applying automated and semi-automated 
            workflows in the production/development of nanomedicines. This 
            encompasses production, characterization, and in vitro 
            evaluation.")
        ), # End column
        column(4,
          h4(strong("Machine learning in nanomedicine")),
          #br(),
          p("Our group is interested in applying machine learning towards
            nanomedicine. We aim to build upon large, robust datasets, 
            predictive machine learning models that can streamline the 
            development of nanomedicine formulations. Furthermore, we aim to
            apply such models to formulate new particle entities that can be
            utilized in interesting or under-researched areas.")
        ) # End column
      ) # End fluidRow
    ), # End tabPanel "Research"
# PUBLICATIONS ===============================================================
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
        p(strong("Last Updated:"), "18 December 2024 from Scopus"),
        # Publications table
        DT::dataTableOutput("pubTab")
    ),
# RESEARCH SUMMARY ===========================================================
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
          h4(strong("Selected publications per year")),
          plotlyOutput("plot_pubYrs")
        ), # End column
        column(8,
          h4(strong("Selected new citations per year")),
          plotlyOutput("plot_citeYrs")
        ) # End column
      ), # End fluidRow
      br(),
      fluidRow(
        column(6,
          h4(strong("No. publications by type")),
          plotlyOutput("plot_piePubs")
        ), # End column
        column(6,
          h4(strong("Co-author network")),
          plotlyOutput("plot_network")
        ) # End column
      ) # End fluidRow
    ), # End tabPanel "Research Summary"
# WORDCLOUD ==================================================================
    tabPanel("Wordcloud", icon=icon("cloud"),
      fluidRow(
        column(2,
          selectInput("wc_docType",
          h4("Document Type"),
          choices=c(#
            list("All Publications"="All Publications"),
            unique(cites$Document.Type))
          ) # End selectInput
        ), # End column
        column(4,
          checkboxInput("wc_firstAuth", "First/Co-first Author",
                        value=FALSE),
          checkboxInput("wc_corrAuth",
                        "Corresponding/Co-corresponding Author",#
                        value=FALSE)
        ) # End column
      ), # End fluidRow
      fluidRow(
        column(12,
          h4(strong("Wordcloud based on manuscript abstracts")),
          wordcloud2Output("plot_wordcloud", width="100%")
        ) # End column
      ) # End fluidRow
    ) # End tabPanel "wordcloud"
  ) # End navbarPage
) # End researchPage

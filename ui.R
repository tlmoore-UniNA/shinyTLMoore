# DEFINE UI ------------------------------------------------------------------
header <- dashboardHeader(title="nanoHTFS Lab") # End header

## SIDEBAR PANEL -------------------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
   menuItem("Home", tabName="home", icon=icon("house")),#home
   menuItem("Research", tabName="research", icon=icon("flask-vial")),#research 
   menuItem("Members", tabName="members", icon=icon("people-group"))#members
  ) # End sidebar menu
) # End sidebar

## BODY ----------------------------------------------------------------------
source("www/ui_homePage.R")
source("www/ui_research.R")
source("www/ui_members.R")


body <- dashboardBody(#
# CSS for the dashboard body
tags$head(tags$style(HTML('
    /* logo */
    .skin-blue .main-header .logo {
      background-color: #17375e;
    }

    /* logo when hovered */
    .skin-blue .main-header .logo:hover {
      background-color: #1199c1;
    }

    /* toggle button when hovered  */                    
    .skin-blue .main-header .navbar .sidebar-toggle:hover{
      background-color: #1199c1;
    }

    /* navbar (rest of the header) */
    .skin-blue .main-header .navbar {
      background-color: #17375e;
    } 

    /* main sidebar */
    .skin-blue .main-sidebar {
      background-color: #17375e;
    }
    
    /* active selected tab in the sidebarmenu */
    .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
      background-color: #1199c1;
    }

    /* other links in the sidebarmenu when hovered */
    .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
      background-color: #0c3444;
    }
    ') # End CSS
  )# End tags$style
), # End tags$head
  tabItems(
    homePage,
    researchPage,
    membersPage
  ) # End tabItems
)# End dashboardBody

ui <- dashboardPage(header, sidebar, body)

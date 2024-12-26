# DEFINE UI ------------------------------------------------------------------
header <- dashboardHeader(title="nanoHTFS Lab") # End header

## SIDEBAR PANEL -------------------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Home", tabName="home", icon=icon("house")),#home
    menuItem("Members", tabName="members", icon=icon("people-group")),#members
    menuItem("Research", tabName="research", icon=icon("flask-vial")),#research 
    menuItem("Research Output", tabName="pubs", icon=icon("book-open-reader"))#pubs
  ) # End sidebar menu
) # End sidebar

## BODY ----------------------------------------------------------------------
source("www/ui_homePage.R")
source("www/ui_members.R")
source("www/ui_research.R")
source("www/ui_pubs.R")


body <- dashboardBody(
  tabItems(
    homePage,
    membersPage,
    researchPage,
    pubPage
  ) # End tabItems
)# End dashboardBody

ui <- dashboardPage(header, sidebar, body)

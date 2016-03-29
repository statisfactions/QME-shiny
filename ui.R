
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(QME)

shinyUI(fluidPage(
  sidebarPanel(
    fileInput('file1', 'Bring in CSV File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    fileInput('file2', 'Bring in CSV key File',
              accept=c('text/csv', 'text/comma-separated-values,text/plain')),
    tags$hr(),
    checkboxInput('header', 'Data Header', TRUE),
    checkboxInput('rownames', 'Data ID Column', TRUE),
    radioButtons('sep', 'Data Separator:', c(Comma=',',Semicolon=';',Tab='\t'),
                 ','),
    radioButtons('quote', 'Data Quote:',
                 c(None='','Double Quote'='"','Single Quote'="'"),
                 '"'),
    tags$hr(),
    checkboxInput('header1', 'Key Header', TRUE),
    radioButtons('sep1', 'Key Separator:', c(Comma=',',Semicolon=';',Tab='\t'),
                 ','),
    radioButtons('quote1', 'Key Quote:',
                 c(None='','Double Quote'='"','Single Quote'="'"),
                 '"')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Data",
              br(),
               br(),br(),
               tableOutput('datafile')
      ),
      tabPanel("Key",
               br(),
               br(),br(),
               tableOutput('key')
               
      ),
      tabPanel("Summary",
               br(),
               hr("Descriptive Statistics"),
               verbatimTextOutput("sum_stats"),
               br()
               
      )
    )
  )
)

)
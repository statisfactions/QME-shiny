library(shiny)
library(QME)


# ui -------------------------------------------------------



ui <- fluidPage(
  sidebarPanel(
  fileInput('file1', 'Bring in Dataset CSV/TXT File',
            accept=c('text/csv', 'text/comma-separated-values,text/plain')),
  fileInput('file2', 'Bring in Key CSV/TXT File',
            accept=c('text/csv', 'text/comma-separated-values,text/plain')),
  tags$hr(),
  checkboxInput('header', 'Data Header?', TRUE),
  checkboxInput('rownames', 'Data ID Column?', TRUE),
  radioButtons('sep', 'Data Separator:', c(Comma=',',Semicolon=';',Tab='\t'),
               ','),
  radioButtons('quote', 'Data Quote:',
               c(None='','Double Quote'='"','Single Quote'="'"),
               '"'),
  tags$hr(),
  checkboxInput('header1', 'Key Header?', TRUE),
  checkboxInput('rownames1', 'Key ID Column?', TRUE),
  radioButtons('sep1', 'Key Separator:', c(Comma=',',Semicolon=';',Tab='\t'),
               ','),
  radioButtons('quote1', 'Key Quote:',
               c(None='','Double Quote'='"','Single Quote'="'"),
               '"')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Data",
               tableOutput('datafile')
      ),
      tabPanel("Key",
               tableOutput('key')
               
      ),
      tabPanel("Summary"
               
      )
    )
  )
)


# server ------------------------------------------------------------------



server <- function(input, output) {
  originalFileInput <- reactive({
    in.file <- input$file1
    
    if (is.null(in.file))
      return(NULL)
    
    if (input$rownames) {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
                 quote=input$quote, row.names=1)
    } else {
      read.table(in.file$datapath, header=input$header, sep=input$sep,
                 quote=input$quote)
    }
  })
  output$datafile <- renderTable({
    head(originalFileInput(), n=10)  
  })
  
  keyFileInput <- reactive({
    key.file <- input$file2
    
    if (is.null(key.file))
      return(NULL)
    
    if (input$rownames1) {
      read.table(key.file$datapath, header=input$header1, sep=input$sep1,
                 quote=input$quote1, row.names=input$rownames1)
    } else {
      read.table(key.file$datapath, header=input$header1, sep=input$sep1,
                 quote=input$quote1)
    }
  })
  output$key <- renderTable({
    head(keyFileInput(), n=10)  
  })
  
}

shinyApp(ui = ui, server = server)
shinyUI(pageWithSidebar(
  headerPanel("Convert Stata (.dta) and SAS (.sas7bdat) files to CSV"),
  sidebarPanel(
    selectInput("type", "1. Choose format", 
              choices = c("Stata", "SAS", "CSV")),
    fileInput('file1', '2. Choose file'),
              # accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
    tags$hr(),
    uiOutput('downloadButton')
  ),
  mainPanel(
    tableOutput('table')
  )
))

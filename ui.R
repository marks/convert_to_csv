shinyUI(fluidPage(
  tags$head(includeScript("google-analytics.js")),
  headerPanel("Convert DBF, SAS, SPSS, and Stata files to CSV"),
  sidebarPanel(
    helpText("Note: Only .dbf, .sas7bdat, .dta, .sav, and .csv files up to 30 MB in size are supported right now"),
    selectInput("type", "1. Choose format", 
              choices = c("DBF","SAS","SPSS", "Stata", "CSV")),
    fileInput('file1', '2. Choose file'),
    tags$hr(),
    uiOutput('downloadButton')
  ),
  mainPanel(
    tableOutput('table')
  )
))

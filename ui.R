library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("flatly"),
  tags$head(includeScript("google-analytics.js")),
  
  column(width = 12,
    h1("Convert DBF, SAS, SPSS, and Stata files to CSV"),
    HTML(
      "<div class='alert alert-info'>",
      "<strong>Heads up!</strong> This is a <em>prototype</em> using R/Shiny. Contact Mark Silverberg (<a href='http://twitter.com/skram' target='blank' class='alert-link'>@Skram</a> || <a href='mailto:mark.silverberg@socrata.com' class='alert-link'>mark.silverberg@socrata.com</a>) with any questions or comments.<br /><a href='http://github.com/marks/convert_to_csv' class='alert-link'>PS - the code is up on Github</a<",
      "</div>"
    )
  ),
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

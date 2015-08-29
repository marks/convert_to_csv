library(shiny)
library(foreign) # Stata and SPSS
library(sas7bdat) # SAS

options(shiny.maxRequestSize=30*1024^2) # via http://stackoverflow.com/a/18037912/252671

shinyServer(function(input, output) {

  datasetInput <- reactive({
    inFile <- input$file1
    if(is.null(inFile)){
      return(NULL)
    }
    else {
      if(input$type == "CSV"){
        data <- read.csv(inFile$datapath) 
      }
      else if(input$type == "Stata"){
        # for Stata files up to v12
        data <- read.dta(inFile$datapath) 
        # TODO Stata >v13
      }
      else if(input$type == "SAS"){
        data <- read.sas7bdat(inFile$datapath)
      }
      else if(input$type == "DBF"){
        data <- read.dbf(inFile$datapath)
      }
      else if(input$type == "SPSS"){
        data <- read.spss(inFile$datapath,to.data.frame=TRUE)
      }
      else {
        return(NULL)
      }

    }
  })

  output$table <- renderTable({
    datasetInput()
  })

  output$downloadButton <- renderUI({
    if(is.null(input$file1$datapath)){
      downloadButton('downloadData', 'Download as CSV', 'disabled')
    }
    else {
      list(
        downloadButton('downloadData', 'Download as CSV')
      )      
    }
  })

  output$downloadData <- downloadHandler(
    filename = function() { paste('x', '.csv', sep='') },
    content = function(file) {
      write.csv(datasetInput(), file, row.names=FALSE)
    }
  )

})

library(shiny)
library(foreign)
library(sas7bdat)

shinyServer(function(input, output) {

  datasetInput <- reactive({
    inFile <- input$file1
    if(is.null(inFile)){
      return(NULL)
    }
    else {
      if(input$type == "CSV"){
        # for CSV files
        data <- read.csv(inFile$datapath) 
      }
      else if(input$type == "Stata"){
        # for Stata files up to v12
        data <- read.dta(inFile$datapath) 
        # TODO Stata v13
      }
      else if(input$type == "SAS"){
        # for SAS
        data <- read.sas7bdat(inFile$datapath)
      } else {
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




shinyServer(function(input, output,session) {

  
  output$a <- renderUI({
    if(input$area=="City") {
    selectInput("city","Choice", cityChoice,selected="ABERDOVEY") 
    } else {
      selectInput("pc","Choice", postCodeChoice,selected="W1T")  
    }
      
  })
  
  
  source("code/locations.R", local = TRUE)
  
 
  
})
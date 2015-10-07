


shinyServer(function(input, output,session) {

  
  output$a <- renderUI({
    if(input$area=="City") {
    selectInput("city","Choice", cityChoice,selected="ABERDOVEY",multiple = T) 
    } else {
      selectInput("pc","Choice", postCodeChoice,selected="L1")  
    }
      
  })
  
  
  source("code/locations.R", local = TRUE)
  
 
  
})
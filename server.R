


shinyServer(function(input, output,session) {

  
  output$a <- renderUI({
    if(input$area=="City") {
    selectInput("city","Choice(s)", cityChoice,selected="ABERDOVEY",multiple = T) 
      
    } else {
      selectInput("pc","Choice(s)", postCodeChoice,selected="L1")  
    }
      
  })
  
  
  source("code/locations.R", local = TRUE)
  
 
  
})
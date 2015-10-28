


shinyServer(function(input, output,session) {

  
  output$a <- renderUI({
    if(input$area=="City") {
      selectInput("city",label = "Choose (Sales in brackets)",c("Cities"="", cityChoice), multiple=TRUE)
   # selectInput("city","Choice(s)", cityChoice,selected="ABERDOVEY",multiple = T) 
      
    } else {
     # selectInput("pc","Choice(s)", postCodeChoice,selected="L1")  
      selectInput("pc",label = "Chooses (Sales in brackets)",c("Postcodes"="", postCodeChoice), multiple=TRUE)
    }
      
  })
  
  
  source("code/locations.R", local = TRUE)
  
 
  
})
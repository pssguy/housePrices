



data <- reactive({
  
  if(input$area=="City") {
cityHouses <-current %>% 
  tbl_df() %>% 
  filter(City==input$city&propertyType!="F") 
  } else {
    cityHouses <-current %>% 
      tbl_df() %>% 
     # mutate(min=)
      filter(postCode>=paste0(input$pc," 1AA")&postCode<=paste0(input$pc," 9ZZ")&propertyType!="F") 
}

  
  
cityHouses$location  <- paste(cityHouses$PAON, cityHouses$Street ,cityHouses$postCode, sep=",")
print(cityHouses$location)
# i<- 1
# latLon <- data.frame(lon=numeric(),lat=numeric()) #str(latLon)
a <-Sys.time()
for (i in 1:nrow(cityHouses)) {
  print(i)
  temp <- geocode(cityHouses$location[i])
  if(i!=1) {
    latLon <- rbind(latLon,temp)
  } else {
    latLon <- temp
  }
}
b <-Sys.time() # yeovil 533(houses only) takes 1 min 20 secs 
print(a)
print(b)
cityHouses <- cbind(cityHouses,latLon)
cityHouses$address <- paste(cityHouses$PAON,cityHouses$Street,cityHouses$City, sep=",")

print("glimpse(cityHouses)")
print(glimpse(cityHouses))

factorPal <-
  colorFactor(c("red","blue"), cityHouses$priceType)


cityHouses$showPrice <- comma_format()(cityHouses$price) # not working

cityHouses$popup <- paste0(cityHouses$year,"<br>",cityHouses$address,"<br>",cityHouses$showPrice)

cityHouses$price <- as.numeric(cityHouses$price)

binPal <-
  colorBin(c("#FFFF00","#FF8000","#FF0000"), cityHouses$price,  pretty = TRUE)
info=list(cityHouses=cityHouses)
return(info)

})

output$map <- renderLeaflet({
  if(is.null(input$city)) return()
  #if(is.null(input$pc)) return()
  if(is.null(data()$cityHouses)) return()
  
  cityHouses <- data()$cityHouses
  
  binPal <-
    colorBin(c("#FFFF00","#FF8000","#FF0000"), cityHouses$price,  pretty = TRUE)
  
cityHouses %>% 
  leaflet() %>% 
  addTiles() %>% 
  #addTiles() %>% 
  addCircleMarkers(color = ~ binPal(cityHouses$price),popup =  ~ popup) 
})

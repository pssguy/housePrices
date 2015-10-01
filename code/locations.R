



data <- reactive({
cityHouses <-current %>% 
  tbl_df() %>% 
  filter(City==input$city&propertyType!="F") 


cityHouses$location  <- paste(cityHouses$PAON, cityHouses$Street ,cityHouses$postCode, sep=",")

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
  
  if(is.null( data()$cityHouses)) return()
  
  cityHouses <- data()$cityHouses
  
  binPal <-
    colorBin(c("#FFFF00","#FF8000","#FF0000"), cityHouses$price,  pretty = TRUE)
  
cityHouses %>% 
  leaflet() %>% 
  addTiles() %>% 
  #addTiles() %>% 
  addCircleMarkers(color = ~ binPal(cityHouses$price),popup =  ~ popup) 
})

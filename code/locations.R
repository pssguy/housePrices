



data <- eventReactive(input$button,{
  
  if (input$housing=="Houses") {
  if (input$area=="City") {
    print(input$city)
cityHouses <-current %>% 
  tbl_df() %>% 
  filter(City==input$city&propertyType!="F") 
  } else {
    print(input$pc)
    cityHouses <-current %>% 
      tbl_df() %>% 
      filter(postCode>=paste0(input$pc," 0AA")&postCode<=paste0(input$pc," 9ZZ")&propertyType!="F") 
  }
  } else if (input$housing=="Flats") {
    if (input$area=="City") {
      print(input$city)
      cityHouses <-current %>% 
        tbl_df() %>% 
        filter(City==input$city&propertyType=="F") 
     # write_csv(cityHouses)
    } else {
      print(input$pc)
      cityHouses <-current %>% 
        tbl_df() %>% 
        filter(postCode>=paste0(input$pc," 0AA")&postCode<=paste0(input$pc," 9ZZ")&propertyType=="F") 
    }
  }  else {
    if (input$area=="City") {
      print(input$city)
      cityHouses <-current %>% 
        tbl_df() %>% 
        filter(City==input$city) 
    } else {
      print(input$pc)
      cityHouses <-current %>% 
        tbl_df() %>% 
        filter(postCode>=paste0(input$pc," 0AA")&postCode<=paste0(input$pc," 9ZZ")) 
    }
  }

  print(nrow(cityHouses))
  
cityHouses$location  <- paste(cityHouses$PAON, cityHouses$Street ,cityHouses$City,cityHouses$postCode, sep=",")
print("cityHouses$propertyType")
print(cityHouses$propertyType)
print(nrow(cityHouses))
print(str(cityHouses))
if (nrow(cityHouses)!=0) {
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


print(nrow(latLon))

cityHouses <- cbind(cityHouses,latLon)
cityHouses$address <- paste(cityHouses$PAON,cityHouses$Street,cityHouses$City, sep=",")

print("glimpse(cityHouses)")
print(cityHouses$propertyType)
print(glimpse(cityHouses))

# factorPal <-  
#   colorFactor(c("red","blue"), cityHouses$priceType)

print(cityHouses$price)
#cityHouses$showPrice <- comma_format()(cityHouses$price) # not working
print(str(cityHouses))
print("thousand")
cityHouses$price <- as.numeric(cityHouses$price)
cityHouses$showPrice <- comma(cityHouses$price)
print(cityHouses$showPrice)


# cityHouses$property <- "Detached"
# cityHouses[cityHouses$propertyType=="F",]$property <- "Flat"
# cityHouses[cityHouses$propertyType=="T",]$property <- "Terraced"
# cityHouses[cityHouses$propertyType=="S",]$property <- "Semi"

cityHouses$date <- paste(month(cityHouses$transferDate, label=T),day(cityHouses$transferDate),year(cityHouses$transferDate),sep=" ")

## need to jitter lon otherwise several have same and do not get shown

cityHouses$lon <- jitter(cityHouses$lon)
cityHouses$popup <- sprintf("<table cellpadding='4' style='line-height:1'><tr>
                        <th>%1$s</th></tr>
                          <tr></tr>
                          <tr><td>Price: %2$s</td></tr>
                          <tr><td>Date: %3$s</td></tr>
                            <tr><td>Property: %4$s</td></tr>
                          
                          </table>",
                            cityHouses$address,
                            cityHouses$showPrice,
                            cityHouses$date,
                            cityHouses$property
)


#cityHouses$popup <- paste0(cityHouses$year,"<br>",cityHouses$address,"<br>",cityHouses$showPrice)



write_csv(cityHouses,"cityHousesTest.csv")

# binPal <-
#   colorBin(c("#FFFF00","#FF8000","#FF0000"), cityHouses$price,  pretty = TRUE)



}




print("reachedInfo")
print(str(cityHouses))
info=list(cityHouses=cityHouses)
return(info)

})

output$map <- renderLeaflet({
  if(is.null(input$city)) return()
  #if(is.null(input$pc)) return()
  if(is.null(data()$cityHouses)) return()
  print(nrow(data()$cityHouses))
  if(nrow(data()$cityHouses)==0) return()
  
  cityHouses <- data()$cityHouses
  
  binPal <-
    colorBin(c("#FFFF00","#FF8000","#FF0000"), cityHouses$price,  pretty = TRUE)
 
#   binPal <-
#     colorQuantile("Blues", domain = NULL,as.numeric(cityHouses$price))
   
  print(glimpse(cityHouses))
  write.csv(cityHouses,"problem.csv", row.names=F)  # data does come through after a null map but then shows map
  # with just grey backgrownd
  
cityHouses %>% 
  leaflet() %>% 
  addTiles() %>% 
  clearBounds() %>% 
  addCircleMarkers(color = ~ binPal(cityHouses$price),popup =  ~ popup) 
})

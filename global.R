library(shiny)

library(shinydashboard)

library(dplyr)
library(ggvis)
#library(rvest) # prob already there
library(DT)
library(stringr)
#library(XML)
#library(markdown)
#library(httr)
#library(lattice)
library(readr)
library(ggmap)
library(data.table)
library(scales)
library(stringr)
library(leaflet)






### import data
#Sys.time()
current <- fread("landRegistry2015toDate.csv", header = TRUE) ## needs to have been pre-downloaded and saved as csv
# Sys.time()
# #NB should do this initially
# colnames(current) <- c("id","price","transferDate","postCode","propertyType","new","duration"
#                        ,"PAON","SAON","Street","Locality","City","District","County","recordStatus")


# probably fastest to subset first and then amend firlds

setkey(current,postCode) 
#cityChoice <- sort(unique(current$City))

# tidy up look
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}


cityOptions <-current %>% 
  group_by(City) %>% 
  tally() 
glimpse(cityOptions)
cityOptions$display <- sapply(tolower(cityOptions$City),simpleCap)

cityOptions <- cityOptions %>% 
  mutate(display= paste0(display," (",n,")"))

cityChoice <- sort(cityOptions$City)

names(cityChoice) <- sort(cityOptions$display)

postCodeOptions <- current %>% 
  group_by(pc) %>% 
  tally() %>% 
  filter(pc>"AA") %>% #  a few are missing
  mutate(display=paste0(pc," (",n,")"))

postCodeChoice <- sort(postCodeOptions$pc)
names(postCodeChoice) <- sort(postCodeOptions$display)



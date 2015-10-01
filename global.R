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
Sys.time()
current <- fread("data/landRegistry2015toDate.csv", header = FALSE) ## needs to have been pre-downloaded and saved as csv
Sys.time()
#NB should do this initially
colnames(current) <- c("id","price","transferDate","postCode","propertyType","new","duration"
                       ,"PAON","SAON","Street","Locality","City","District","County","recordStatus")


# probably fastest to subset first and then amend firlds

setkey(current,postCode) 
cityChoice <- sort(unique(current$City))

postCodeChoice <- current %>% 
  mutate(pc=str_sub(postCode,1,3)) %>% 
  .$pc %>% 
  unique() %>% 
  sort()



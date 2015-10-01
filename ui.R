



dashboardPage(
  skin = "blue",
  dashboardHeader(title = "House Prices"),
  
  dashboardSidebar(
   # includeCSS("custom.css"),
    radioButtons("area","Choose By",c("City","Postal Code"), inline=T),
 
   uiOutput("a"),
    
    
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem(
        "Land Registry", tabName = "registry")
      ),
      
      menuItem("Info", tabName = "info", icon = icon("info")),
      menuItem(
        "Other Dashboards",
        
        
        menuSubItem("Climate",href = "https://mytinyshinys.shinyapps.io/climate"),
        menuSubItem("Cricket",href = "https://mytinyshinys.shinyapps.io/cricket"),
        menuSubItem("Mainly Maps",href = "https://mytinyshinys.shinyapps.io/mainlyMaps"),
        menuSubItem("MLB",href = "https://mytinyshinys.shinyapps.io/mlbCharts"),
        
        menuSubItem("World Soccer",href = "https://mytinyshinys.shinyapps.io/worldSoccer")
        
      ),
      menuItem("", icon = icon("twitter-square"),
               href = "https://twitter.com/pssGuy"),
      menuItem("", icon = icon("envelope"),
               href = "mailto:agcur@rogers.com")
      
    
  ),
  dashboardBody(tabItems(
    tabItem("registry",
           
                box(
                  width = 12, collapsible = TRUE,
                  status = "success", solidHeader = TRUE,
                  title = "Map",
                  leafletOutput("map")
                )
    ),
    tabItem("info", includeMarkdown("info.md"))
    
    
    
  ) # tabItems
  ) # body
  ) # page
  
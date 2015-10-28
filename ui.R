



dashboardPage(title = "House Prices",
  skin = "blue",
  dashboardHeader(title = "House Prices"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
    radioButtons("area","2015 Sales: Choose By",c("City","Postal Code"), inline=T),
    radioButtons("housing",NULL,c("Houses","Flats","Both"), inline=T),
   uiOutput("a"),
    
   actionButton("button", "Obtain Map"),
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem(
        "UK Land Registry",
      menuSubItem("Maps", tabName= "registry_maps"),
      menuSubItem("Info", tabName = "registry_info", icon = icon("info"))
      ),
      
      
      tags$hr(),
      menuItem(text="",href="https://mytinyshinys.shinyapps.io/dashboard",badgeLabel = "All Dashboards and Trelliscopes (14)"),
      tags$hr(),
      
      tags$body(
        a(class="addpad",href="https://twitter.com/pssGuy", target="_blank",img(src="images/twitterImage25pc.jpg")),
        a(class="addpad2",href="mailto:agcur@rogers.com", img(src="images/email25pc.jpg")),
        a(class="addpad2",href="https://github.com/pssguy",target="_blank",img(src="images/GitHub-Mark30px.png")),
        a(href="https://rpubs.com/pssguy",target="_blank",img(src="images/RPubs25px.png"))
      )
    
  )),
  dashboardBody(tabItems(
    tabItem("registry_maps",
           
                box(
                  width = 12, collapsible = TRUE,
                  status = "success", solidHeader = TRUE,
                  title = "Map - Click for Property details",
                  leafletOutput("map")
                )
    ),
    tabItem("registry_info", includeMarkdown("registry_info.md"))
    
    
    
  ) # tabItems
  ) # body
  ) # page
  
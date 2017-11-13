library(shiny)
library(plotly)
library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(bsplus)

shinyApp(
  ui = fluidPage(theme = shinytheme("lumen"),
    navbarPage(
      "The Love Shack",
      id="inTabset",
      tabPanel("The Dilemma",
               style = "overflow:hidden;",
               value="P1",
               fluidPage(
                 style = "background-image: url('https://static.vecteezy.com/system/resources/previews/000/102/689/non_2x/free-cityscape-vector.png'); background-repeat: no-repeat; background-position: bottom;",
                 br(),
                 br(),
                 br(),
                 fluidRow(
                   useShinyjs(),
                   column(4, align="center",
                          br(),
                          br(),
                          br(),
                          actionButton("toLove", 
                                       "Love",  
                                       icon = icon("heart"),
                                       style = "background-color: #E75A7C; color: #fff; height: 70px; font-size: 18px; width: 200px;"
                                       ),
                          br(),
                          br(),
                          h4(id="toLove-text-1","IF YOU LIKED IT"),
                          h4(id="toLove-text-2", "THEN YOU SHOULDA PUT A RING ON IT"),
                          h4(id="toLove-text-3", "OH OH OH"),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br()
                   ),
                   column(4, align="center",
                          h1("Honey,"),
                          h1("Will you get a flat with me?"),
                          br(),
                          br(),
                          br(),
                          htmlOutput("proposalpng"),
                          br(),
                          br(),
                          br(),
                          br(),
                          actionButton("jumpToP2", "Next", class="btn-primary", style="height: 70px; font-size: 18px; width: 200px;"),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br(),
                          br()
                   ),
                   column(4, align="center",
                          br(),
                          br(),
                          br(),
                          actionButton("toInvest", 
                                       "Investment",  
                                       icon = icon("usd"),
                                       style = "background-color: #2BA84A; color: #fff; height: 70px; font-size: 18px; width: 200px;"
                          ),
                          br(),
                          br(),
                          h4(id="toInvest-text-1","Step 1: BTO"),
                          h4(id="toInvest-text-2", "Step 2: ???"),
                          h4(id="toInvest-text-3", "Step 3: Profit"),
                          br(),
                          br(),
                          br(),
                          br(),
                          br()
                   )
                 )
               )
      ),
      tabPanel("Infographics, Infographics on the Wall",
               value="P2",
               fluidPage(
                 fluidRow(
                   column(12, align="center",
                          bs_carousel(id = "with_the_beatles") %>%
                            bs_set_data(interval = FALSE) %>%
                            bs_append(content = bs_carousel_image(src = "http://www.thelocalsociety.com/wp-content/uploads/2016/01/12439036_10153746909230923_7462206031122330888_n.png")) %>%
                            bs_append(content = bs_carousel_image(src = "https://www.areyouready.sg/YourInfoHub/PublishingImages/Pages/Views-Heres-How-CPF-Housing-Grants-Will-Affect-Your-HDB-Flat-Purchase-MoneySmart/Heres%20How%20CPF%20Housing%20Grants%20Will%20Affect%20Your%20HDB%20Flat%20Purchase%202.png")) %>%
                            bs_append(content = bs_carousel_image(src = "https://www.areyouready.sg/YourInfoHub/PublishingImages/Pages/Views-Heres-How-CPF-Housing-Grants-Will-Affect-Your-HDB-Flat-Purchase-MoneySmart/Heres%20How%20CPF%20Housing%20Grants%20Will%20Affect%20Your%20HDB%20Flat%20Purchase%201.png")) %>%
                            bs_append(content = bs_carousel_image(src = "img/ringo.jpg")),
                          actionButton("jumpToP3", "Next", class="btn-primary", style="height: 70px; font-size: 18px; width: 200px;")
                   )
                 )
               )
      ),
      tabPanel("Number Crunching", 
               value="P3",
               sidebarPanel(
                 tags$h5("Default actionButton:"),
                 actionButton("action", "Search"),
                 tags$h5("actionButton with CSS class:"),
                 actionButton("action2", "Action button", class="btn-primary", style="height: 70px; font-size: 18px; width: 200px;")
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Tab 1",
                            h4("Table"),
                            tableOutput("table"),
                            withSpinner(plotlyOutput("barchart_grants")),
                            h4("Verbatim text output"),
                            verbatimTextOutput("txtout"),
                            h1("Header 1"),
                            h2("Header 2"),
                            h3("Header 3"),
                            h4("Header 4"),
                            h5("Header 5")
                   ),
                   tabPanel("Tab 2", "This panel is intentionally left blank"),
                   tabPanel("Tab 3", 
                            actionButton("jumpToP4", "Next", class="btn-primary", style="height: 70px; font-size: 18px; width: 200px;")
                   )
                 )
               )
      ),
      tabPanel("Does Love Trumps All?", 
               value="P4",
               fluidPage(
                 actionButton("jumpToP1", "Replay", class="btn-primary", style="height: 70px; font-size: 18px; width: 200px;")
               )
      )
    )
  ),
  server = function(input, output, session) {
    output$barchart_grants <- renderPlotly({
      plotly_barchart_grants
    })
    output$linechart_marriageAndConstructionRate <- renderPlotly({
      plotly_linechart_marriageAndConstructionRate
    })
    output$linechart_marriageAndDivorceRate <- renderPlotly({
      plotly_linechart_marriageAndDivorce
    })
    output$linechart_marriageRateByAge <- renderPlotly({
      plotly_linechart_marriageRateByAge
    })
    output$piechart_marriageRateByAge <- renderPlotly({
      plotly_piechart_marriageRateByAge
    })
    output$animatedchart_marriageRateByAge <- renderPlotly({
      animated_plotly_linechart_marriageRateByAge
    })
    observeEvent(input$jumpToP2, {
      updateNavbarPage(session, "inTabset",
                        selected = "P2")
    })
    observeEvent(input$jumpToP3, {
      updateNavbarPage(session, "inTabset",
                       selected = "P3")
    })
    observeEvent(input$jumpToP4, {
      updateNavbarPage(session, "inTabset",
                       selected = "P4")
    })
    observeEvent(input$jumpToP1, {
      updateNavbarPage(session, "inTabset",
                       selected = "P1")
    })
    output$proposalpng <-
      renderText({
        c(
          '<img height="250px" src="',
          "https://cdn2.iconfinder.com/data/icons/marriage-life/500/Proposal-512.png",
          '">'
        )
      })
    shinyjs::hide(id="toLove-text-1")
    shinyjs::hide(id="toLove-text-2")
    shinyjs::hide(id="toLove-text-3")
    observeEvent(input$toLove, {
      if(input$toLove %% 2 == 1){
        shinyjs::show(id="toLove-text-1")
        shinyjs::show(id="toLove-text-2")
        shinyjs::show(id="toLove-text-3")
      } else {
        shinyjs::hide(id="toLove-text-1")
        shinyjs::hide(id="toLove-text-2")
        shinyjs::hide(id="toLove-text-3")
      }
    })
    shinyjs::hide(id="toInvest-text-1")
    shinyjs::hide(id="toInvest-text-2")
    shinyjs::hide(id="toInvest-text-3")
    observeEvent(input$toInvest, {
      if(input$toInvest %% 2 == 1){
        shinyjs::show(id="toInvest-text-1")
        shinyjs::show(id="toInvest-text-2")
        shinyjs::show(id="toInvest-text-3")
      } else {
        shinyjs::hide(id="toInvest-text-1")
        shinyjs::hide(id="toInvest-text-2")
        shinyjs::hide(id="toInvest-text-3")
      }
    })
  }
)

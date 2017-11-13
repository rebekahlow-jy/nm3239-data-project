library(shiny)
library(plotly)
library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(bsplus)
library(rsconnect)

shinyApp(
  ui = fluidPage(theme = shinytheme("lumen"),
    navbarPage(
      "The Love Shack",
      id="inTabset",
      tabPanel("The Dilemma",
               style = "overflow:hidden;",
               value="P1",
               fluidPage(
                 style = "background-image: url('https://static.vecteezy.com/system/resources/previews/000/102/689/non_2x/free-cityscape-vector.png'); background-repeat: no-repeat; background-position: bottom; height: 720px;",
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
                                       style = "background-color: #E75A7C; color: #fff; height: 50px; font-size: 18px; width: 200px;"
                                       ),
                          br(),
                          br(),
                          wellPanel(
                            id="toLove-text",
                            style="width: 200px; background-color: #FFF7F3;",
                            h4("I found a love for me"),
                            h4("Darling just dive right in"),
                            h4("Follow my lead"),
                            h4("Well I found a girl beautiful and sweet"),
                            h4("I never knew you were the someone waiting for me")
                          ),
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
                          htmlOutput("proposalimage"),
                          br(),
                          br(),
                          br(),
                          br(),
                          actionButton("jumpToP2", "Next", class="btn-primary", style="height: 50px; font-size: 18px; width: 200px;"),
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
                                       style = "background-color: #2BA84A; color: #fff; height: 50px; font-size: 18px; width: 200px;"
                          ),
                          br(),
                          br(),
                          wellPanel(
                            id="toInvest-text",
                            style="width: 200px; background-color: #EFF8EF",
                            h4("Step 1: BTO"),
                            h4("Step 2: ???"),
                            h4("Step 3: Profit")
                          )
                   )
                 )
               )
      ),
      tabPanel("Infographics, Infographics on the Wall",
               value="P2",
               fluidPage(
                 fluidRow(
                   column(3, align="center",
                          br()
                          ),
                   column(6, align="center",
                     style = "background-image: url('https://static.vecteezy.com/system/resources/previews/000/057/265/non_2x/flat-monitor-screen-vector.jpg'); background-repeat: no-repeat; background-position: center; background-size: 810px;",
                     br(),
                     br(),
                     bs_carousel(id="infographics_carousel") %>%
                       bs_set_data(interval = FALSE) %>%
                       bs_append(content=bs_carousel_image(src="http://www.thelocalsociety.com/wp-content/uploads/2016/01/12439036_10153746909230923_7462206031122330888_n.png", style="height: 405px")) %>%
                       bs_append(content=bs_carousel_image(src="https://www.areyouready.sg/YourInfoHub/PublishingImages/Pages/Views-Heres-How-CPF-Housing-Grants-Will-Affect-Your-HDB-Flat-Purchase-MoneySmart/Heres%20How%20CPF%20Housing%20Grants%20Will%20Affect%20Your%20HDB%20Flat%20Purchase%202.png", style="height: 405px")) %>%
                       bs_append(content=bs_carousel_image(src="https://www.areyouready.sg/YourInfoHub/PublishingImages/Pages/Views-Heres-How-CPF-Housing-Grants-Will-Affect-Your-HDB-Flat-Purchase-MoneySmart/Heres%20How%20CPF%20Housing%20Grants%20Will%20Affect%20Your%20HDB%20Flat%20Purchase%201.png", style="height: 405px")) %>%
                       bs_append(content=bs_carousel_image(src="https://i.pinimg.com/736x/2e/ff/e0/2effe0f64fc5b5be3028086a45ccd234--infographics-knowledge.jpg", style="height: 405px")),
                       br(),
                       br(),
                       br(),
                       br(),
                       br(),
                       br()
                   ),
                   column(3, align="center",
                          br()
                   ),
                   br(),
                   br(),
                   fluidRow(
                     column(12, align="center",
                            h1("We'll be rich in 5 years."),
                            br(),
                            actionButton("jumpToP3", "Next", class="btn-primary", style="height: 50px; font-size: 18px; width: 200px;")
                     )
                   )
                 )
               )
      ),
      tabPanel("Number Crunching", 
               value="P3",
               fluidPage(
                 br(),
                 column(12, align="center",
                        h1("Aren't we buying for love?"),
                        br()
                 ),
                 tabsetPanel(
                   tabPanel("When Do We Say 'I Do'?",
                            fluidRow(
                              column(12, align="center",
                                br(),
                                br(),
                                withSpinner(plotlyOutput("animatedchart_marriageRateByAge")),
                                br(),
                                br(),
                                h4("Insert Explanation, Phenomeon and Future Implications"),
                                br(),
                                br(),
                                withSpinner(plotlyOutput("piechart_marriageRateByAge")),
                                br(),
                                br(),
                                h4("Insert Explanation, Phenomeon and Future Implications"),
                                br(),
                                br()
                              )
                            )
                   ),
                   tabPanel("More Flat, More Marriages?",
                            fluidRow(
                              column(12, align="center",
                                br(),
                                br(),
                                withSpinner(plotlyOutput("linechart_marriageAndConstructionRate")),
                                br(),
                                br(),
                                h4("Insert Explanation, Phenomeon and Future Implications"),
                                br(),
                                br()
                              )
                            )
                   ),
                   tabPanel("How Much Will It Cost?",
                            fluidRow(
                              column(12, align="center",
                                br(),
                                br(),
                                withSpinner(plotlyOutput("barchart_grants")),
                                br(),
                                br(),
                                h4("Insert Explanation, Phenomeon and Future Implications"),
                                br(),
                                br()
                              )
                            )
                   ),
                   tabPanel("Will Our Marriage Last?",
                            fluidRow(
                              column(12, align="center",
                                br(),
                                br(),
                                withSpinner(plotlyOutput("linechart_marriageAndDivorceRate")),
                                br(),
                                br(),
                                h4("Insert Explanation, Phenomeon and Future Implications"),
                                br(),
                                br(),
                                actionButton("jumpToP4", "Next", class="btn-primary", style="height: 50px; font-size: 18px; width: 200px;"),
                                br(),
                                br()
                              )
                            )
                   )
                 )
               )
      ),
      tabPanel("Does Love Trumps All?", 
               value="P4",
               fluidPage(
                 fluidRow(
                   br(),
                   column(12, align="center",
                          br(),
                          br(),
                          htmlOutput("hugimage"),
                          h1("The house may go but we'll still be together."),
                          br(),
                          h4("Insert Conclusion"),
                          br(),
                          br(),
                          actionButton("jumpToP1", "Replay", class="btn-primary", style="height: 50px; font-size: 18px; width: 200px;")
                        
                   )
                 )
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
      plotly_linechart_marriageAndDivorceRate
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
    output$proposalimage <-
      renderText({
        c(
          '<img height="180px" src="',
          "https://cdn2.iconfinder.com/data/icons/marriage-life/500/Proposal-512.png",
          '">'
        )
      })
    shinyjs::hide(id="toLove-text")
    observeEvent(input$toLove, {
      if(input$toLove %% 2 == 1){
        shinyjs::show(id="toLove-text")
      } else {
        shinyjs::hide(id="toLove-text")
      }
    })
    shinyjs::hide(id="toInvest-text")
    observeEvent(input$toInvest, {
      if(input$toInvest %% 2 == 1){
        shinyjs::show(id="toInvest-text")
      } else {
        shinyjs::hide(id="toInvest-text")
      }
    })
    output$hugimage <-
      renderText({
        c(
          '<img height="180px" src="',
          "https://image.freepik.com/free-icon/couple-in-love-dancing_318-29507.jpg",
          '">'
        )
      })
  }
)

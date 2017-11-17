library(shiny)
library(plotly)
library(shinythemes)
library(shinycssloaders)
library(shinyjs)
library(bsplus)
library(rsconnect)
library(dplyr)
library(tidyverse)
library(rvest)
library(stringr)
library(plotly)
library(RColorBrewer)

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
                                hr(),
                                br(),
                                br(),
                                withSpinner(plotlyOutput("piechart_marriageRateByAge")),
                                br(),
                                br(),
                                h4("The age groups of 25 - 29 Years and 30 - 34 Years emerged dominant from the other age ranges. 
                                   These 2 age ranges (25- 29 Years & 30 - 34 Years) were consistently the ages 
                                   that most people got married every year."),
                                br(),
                                br()
                              )
                            )
                   ),
                   tabPanel("More Marriages, More Flats?",
                            fluidRow(
                              column(12, align="center",
                                br(),
                                br(),
                                withSpinner(plotlyOutput("linechart_marriageAndConstructionRate")),
                                br(),
                                br(),
                                h4("There is a positive correlation between the number of marriages 
                                    per 1000 residents and the number of flats being constructed. However, 
                                   there were years that showed an inverse relationship between the 2 observations."),
                                h3("Between 1986-1989"),
                                h4("There seem to be an inverse relationship between number of
                                    marriages and flats being built which go against our assumption that people are 
                                    marrying for the flat."),
                                h3("1986"),
                                h4("The government recognised that its past policy - ‘Stop at Two’, 
                                   was too successful at curbing the birth rates during the postwar baby boom, 
                                   fearing that it might put a strain on the developing economy. This affected the 
                                   marriage rates as one would often need to get married first before raising a child."),
                                h3("1987"),
                                h4("Goh Chok Tong, along with the government, rolled out ‘Have Three or More’ to promote 
                                   a bigger family for married couples who are financially-abled to handle. This is in 
                                   line with HDB’s ‘Third Child Priority Scheme’, which aims helps families with 
                                   more than 2 children and encourages the formation of larger families"),
                                h3("More Marriage, Not More Flats Bought"),
                                h4("This scheme should influence both the marriage and flat construction graph positively. 
                                   However, there is a decrease in the number of flat constructed."),
                                h3("1997-1999"),
                                h4("Singapore’s economy was greatly affected by the Asian Financial Crisis. It was triggered
                                   by the Thai government’s decision to seize intervention on the Thai Baht causing a sharp 
                                   depreciation of the Thai Baht against United State (US) dollar. This brought about frenzy 
                                   amongst investors as they lose confidence in the strength of the currencies in Asia. 
                                   Singapore’s economy inevitably faced a slump, falling from 8% growth to 1.5% in 1998"),
                                h4("Singapore’s labour market took a toll, it was inevitable for the unemployment rate to go up, 
                                   affecting people’s purchasing power. Furthermore, the pessimism in the economy, 
                                   with drop in purchasing power, would likely trigger a decrease in demand for 
                                   housing as people are more conservative with spendings"),
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
                                h4("There was a net amount of marriages since 1980 before it equalised at 
                                   about 1999/2000. After 2000, the disparity between marriages
                                   and divorces grew, resulting in a net divorce."),
                                br(),
                                br(),
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
                                     br(),
                                     actionButton("jumpToP4", "Next", class="btn-primary", style="height: 50px; font-size: 18px; width: 200px;"),
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
                          h1("So looking through this, do you believe that couples purchase a HDB for love, or for an investment?"),
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
    csv_crudeMarriageRate <- read.csv("./csv/crude-marriage-rate.csv")
    csv_femaleAgeSpecificMarriageRate <- read.csv("./csv/female-age-specific-marriage-rate.csv")
    csv_maleAgeSpecificMarriageRate <- read.csv("./csv/male-age-specific-marriage-rate.csv")
    csv_femaleGeneralMarriageRate <- read.csv("./csv/female-general-marriage-rate.csv")
    csv_maleGeneralMarriageRate <- read.csv("./csv/male-general-marriage-rate.csv")
    csv_totalDivorcesByDurationOfMarriage <- read.csv("./csv/total-divorces-by-duration-of-marriage-annual.csv")
    csv_flatsConstructedByHDB <- read.csv("./csv/flats-constructed-by-housing-and-development-board-annual.csv")
    
    url_grants <- "http://www.hdb.gov.sg/cs/infoweb/residential/buying-a-flat/new/first-timer-and-second-timer-couple-applicants"
    webpage_grants <- read_html(url_grants)
    grant_amount <- html_nodes(webpage_grants, 'table')[2] %>% html_node("tbody") %>% html_nodes("tr") %>% html_nodes("td:last-child") %>% html_text() 
    grant_amount <- grant_amount[-c(1)]
    grant_amount <- str_replace_all(grant_amount, "[$,]", "") %>% as.numeric()
    income_level <- html_nodes(webpage_grants, 'table')[2] %>% html_node("tbody") %>% html_nodes("tr") %>% html_nodes("td:first-child") %>% html_text() 
    income_level <- income_level[-c(1)]
    income_level <- str_replace_all(income_level, "[\t\n\r\v\f]", "") 
    df_grants <- data.frame(income_level=income_level, grant_amount=grant_amount)
    df_grants$income_level <- factor(df_grants$income_level, levels = df_grants$income_level)
    df_ageSpecificMarriageRate <- data.frame(year=csv_femaleAgeSpecificMarriageRate$year, 
                                             value=((csv_femaleAgeSpecificMarriageRate$value+csv_maleAgeSpecificMarriageRate$value)/2), 
                                             age_group=csv_femaleAgeSpecificMarriageRate$level_2
    )
    df_numMarriagesFemaleByAge <- group_by(csv_femaleAgeSpecificMarriageRate, age_group=level_2) %>% 
      summarise(number=sum(value))
    df_numMarriagesMaleByAge <- group_by(csv_maleAgeSpecificMarriageRate, age_group=level_2) %>% 
      summarise(number=sum(value))
    df_numMarriagesByAge <- data.frame(age_group=df_numMarriagesFemaleByAge$age_group,
                                       number=((df_numMarriagesFemaleByAge$number+df_numMarriagesMaleByAge$number)/2)
    )
    df_flatsConstructedByHDB <- subset(csv_flatsConstructedByHDB, year>=1980)
    df_ageSpecificMarriageRate_f <- subset(df_ageSpecificMarriageRate, 
                                           (age_group==('25 - 29 Years') | age_group==('30 - 34 Years'))
    )
    df_numMarriagesByYear_f <- group_by(df_ageSpecificMarriageRate_f, year=year) %>% 
      summarise(number=sum(value))
    df_numDivorces_f <- subset(csv_totalDivorcesByDurationOfMarriage, 
                               (level_2==('5-9 Years'))
    )
    
    accumulate_by <- function(dat, var) {
      var <- lazyeval::f_eval(var, dat)
      lvls <- plotly:::getLevels(var)
      dats <- lapply(seq_along(lvls), function(x) {
        cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
      })
      dplyr::bind_rows(dats)
    }
    
    accumulated_ageSpecificMarriageRate <- df_ageSpecificMarriageRate %>%
      accumulate_by(~year)
    
    animated_plotly_linechart_marriageRateByAge <- accumulated_ageSpecificMarriageRate %>%
      plot_ly(
        x=~year, 
        y=~value,
        split=~age_group,
        frame=~frame, 
        type='scatter',
        mode='lines', 
        line=list(simplyfy = F),
        hoverinfo='text', 
        text=~paste('Age Group:', age_group, 
                    '<br> Year:', year, 
                    '<br> Marriages per 1,000 Residents:', value
        )
      ) %>% 
      layout(
        title='Marriage Rate by Age Group', 
        xaxis = list(
          title = "Years",
          zeroline = F
        ),
        yaxis = list(
          title = "Marriages per 1,000 Residents",
          zeroline = F
        )
      ) %>% 
      animation_opts(
        frame = 100, 
        transition = 0, 
        redraw = FALSE
      ) %>%
      animation_slider(
        currentvalue = list(
          prefix = "Year: "
        )
      ) 
    
    
    plotly_linechart_marriageRateByAge <- plot_ly(
      data=df_ageSpecificMarriageRate, 
      x=~df_ageSpecificMarriageRate$year, 
      y=~df_ageSpecificMarriageRate$value, 
      type='scatter',
      mode='lines', 
      color=~df_ageSpecificMarriageRate$age_group, 
      hoverinfo='text', 
      text=~paste('Age Group:', age_group, 
                  '<br> Year:', year, 
                  '<br> Marriages per 1,000 Residents:', value
      )
    ) %>% layout(
      title='Marriage Rate by Age Group', 
      xaxis=list(title='Years'), 
      yaxis=list(title='Marriages per 1,000 Residents')
    )
    
    plotly_piechart_marriageRateByAge <- plot_ly(df_numMarriagesByAge, 
                                                 labels = ~df_numMarriagesByAge$age_group, 
                                                 values = ~df_numMarriagesByAge$number, 
                                                 type = 'pie',
                                                 marker = list(colors=brewer.pal(7,'Set3')),
                                                 textposition = 'inside',
                                                 textinfo = 'label+percent',
                                                 insidetextfont = list(color = c('#595959')),
                                                 hoverinfo = 'text',
                                                 text = ~paste(number, 'Marriages per 1,000 Residents')
    ) %>% layout(
      title='Marriage Rate by Age Group', 
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
    
    plotly_linechart_marriageAndConstructionRate <- plot_ly() %>%
      add_lines(x=df_numMarriagesByYear_f$year, 
                y=df_numMarriagesByYear_f$number,
                name="Marriage Rate by 25 - 34 Years",
                type="scatter", 
                mode="lines",
                line=list(color = '#E7298A'),
                hoverinfo='text', 
                text=~paste('Year:', df_numMarriagesByYear_f$year, 
                            '<br> Marriages per 1,000 Residents:', df_numMarriagesByYear_f$number
                )) %>%
      add_lines(x=df_flatsConstructedByHDB$year, 
                y=df_flatsConstructedByHDB$flats_constructed, 
                name="Flats Constructed", 
                yaxis="y2",
                type="scatter", 
                mode="lines",
                line=list(color = '#E6AB02'),
                hoverinfo='text', 
                text=~paste('Year:', df_flatsConstructedByHDB$year, 
                            '<br> Number of Flats:', df_flatsConstructedByHDB$flats_constructed
                )) %>%
      layout(
        title="Marriage and Flats Construction Rate", 
        yaxis=list(
          title="Marriages per 1,000 Residents"
        ),
        yaxis2=list(
          title="Number of Flats",
          overlaying = "y",
          side = "right"
        ),
        xaxis=list(title="Year", ticks=df_numMarriagesByYear_f$year)
      )
    
    plotly_linechart_marriageAndDivorceRate <- plot_ly() %>%
      add_lines(x=df_numMarriagesByYear_f$year, 
                y=df_numMarriagesByYear_f$number,
                name="Marriage Rate by 25 - 34 Years",
                type="scatter", 
                mode="lines",
                hoverinfo='text', 
                line=list(color = '#E7298A'),
                text=~paste('Year:', df_numMarriagesByYear_f$year, 
                            '<br> Marriages per 1,000 Residents:', df_numMarriagesByYear_f$number
                )) %>%
      add_lines(x=df_numDivorces_f$year, 
                y=round(df_numDivorces_f$value/500, 2), 
                name="Divorces within 5-9 Years", 
                yaxis="y2",
                type="scatter", 
                mode="lines",
                line=list(color = '#666666'),
                hoverinfo='text', 
                text=~paste('Year:', df_numDivorces_f$year, 
                            '<br> Divorces per 1,000 Residents:', round(df_numDivorces_f$value/500, 2)
                )) %>%
      layout(
        title="Marriage and Divorce Rate", 
        yaxis=list(
          title="Marriages per 1,000 Residents"
        ),
        yaxis2=list(
          title="Divorces per 1,000 Residents",
          overlaying="y",
          side="right"
        ),
        xaxis=list(title="Year", ticks=df_numMarriagesByYear_f$year)
      )
    
    plotly_barchart_grants <- plot_ly(df_grants, 
                                      y=~grant_amount, 
                                      type='bar',
                                      color=~income_level, 
                                      hoverinfo='text', 
                                      text=~paste('Income:', income_level, 
                                                  '<br> Grant Amount:', grant_amount
                                      )
    ) %>% layout(
      title = "Grants by Income Level",
      xaxis = list(title = "Half of Average Monthly Household Income* Over 12 Months", showticklabels = FALSE),
      yaxis = list(title = "Grant Amount (S$)")
    )
    
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

library(shiny)

source('info.R')
source('help_func.R')

shinyUI(fluidPage(
  
  titlePanel("Vergleich US Krankenhäuser"),
  
  sidebarLayout(
    sidebarPanel(
      
#     Dropdown outcome
  
      selectInput(inputId = "outcome",
                  h4("Ranking nach"),
                  choices = outcomes),
#     Dropdown states
      selectInput(inputId = "state",
                  h4("Auswahl States"),
                  choices = states),  

#     Slider für Ergebnisraum  
      
      sliderInput(inputId = "range",
                  h4("Ranks"),
                  min = 1,
                  max = 100,
                  value = c(1, 20)),


#     Checkboxes für weitere Spalten
#     checkboxGroupInput
      checkboxGroupInput("fields",
                         h4("Fields"),
                         choices = spalten)
    ),

    mainPanel(
      tabsetPanel(type = "tabs", selected = "Info",
                  # das object info ist eine liste (info.R)
                  
                  tabPanel("Info", info),
                  tabPanel('Tabelle',
                           h3(textOutput('outcome')),
                           tableOutput("filtered")),
                  
                  tabPanel('Plot ggplot', plotOutput('barplot'))
                 
      )
    )
  )
))
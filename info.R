url.data <- 'https://data.medicare.gov/data/hospital-compare'
url.sourcecode <- 'dummy url'

info <- list(
  br(),
  h4('Zwischenpraesentation RUFIT - ShinyApp'),
  p('Funktionsweise:'),
  br(),
  p('Es koennen US Krankenhaeuser nach "mortality und readmission rates" verglichen werden.',
    'Dies koennen zum Beispiel heart failure, pneumonia, heart disease, und viele weitere sein.',
    'Die Ergebnisse koennen nach US-States gefiltert werden.'),
  hr(),
  br(),

  tag('ul', list(
    
    tag('li', list('Daten', a(href=url.data, url.data))),
    tag('li', list('zu finden unter', strong('CSV Flat Files - Revised'))) #,

  )),
  br(),
  p('Diese shiny-App wurde im Rahmen des Projektseminars SS15 an Universitaet Wuerzburg entwickelt '),
  #p('link zu Sourcecode - GitHub:'),
  #p(a(url.sourcecode, href=url.sourcecode)),
  hr(),
  p('Diese Seite basiert auf', a('Shiny RStudio', href='http://shiny.rstudio.com/'))
)

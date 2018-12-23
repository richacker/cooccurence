shinyUI(fluidPage(
  
  # Application title
  tags$head(
    tags$style(
      ".title {margin: auto; width: 800px}"
    )
  ),
  tags$div(class="title", titlePanel("ISB TABA Co-occurence Assignment")),
  hr(),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("txtFile", "Choose Text File",
                multiple = FALSE,
                accept = c(".txt", ".TXT")),
      # Input: Select a file ----
      fileInput("modelFile", "Choose Model File",
                multiple = FALSE,
                accept = c( ".udpipe")),
      checkboxGroupInput("checkbox", label = h3("Part-Of-Speech Tags"), 
                         choices = list("Adjective" = "ADJ", "Noun" = "NOUN", "Proper Noun" = "PROPN", "Adverb" = "ADV", "Verb" = "VERB"),
                         selected = list("Adjective" = "ADJ", "Noun" = "NOUN", "Proper Noun" = "PROPN"))
      
    ),
    
    # Show a plot of the generated distribution
  
    mainPanel(
      
      tabsetPanel(type = "tabs",   # builds tab struc
                  
                  tabPanel("Overview",   # leftmost tab
                           
                           h4(p("Data input")),
                           
                           p("This app supports only text file (.txt) data file.", align="justify"),
                           
                           p("Please refer to the link below for sample txt file."),
                           a(href="https://github.com/sudhir-voleti/sample-data-sets/blob/master/Segmentation%20Discriminant%20and%20targeting%20data/ConneCtorPDASegmentation.csv"
                             ,"Sample data input file"),   
                           
                           br(),
                           
                           h4('How to use this App'),
                           
                           p('To use this app, click on', 
                             span(strong("Upload data (csv file with header)")),
                             'and uppload the csv data file. You can also change the number of clusters to fit in k-means clustering')),
                  
                  tabPanel("Co-occurence Graph", 
                           plotOutput('plot'),
                           textOutput("txt")),
                          
                  
                  tabPanel("Word Cloud",
                           plotOutput('wcloud', width = "100%")),
                  
                  tabPanel("Data",
                           dataTableOutput('clust_data'))
                  
      ) # end of tabsetPanel
    )# end of main panel
  )
))
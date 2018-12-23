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
                           
                           p("This app supports only text file (.txt) data file and udpipe model file (.udpipe)", align="justify"),
                           
                           p("Please refer to the link below for sample txt file and english udpipe model file."),
                           a(href="https://github.com/richacker/cooccurence/blob/master/review.txt"
                             ,"Sample data input file"),   
                           br(),
                           a(href="https://github.com/richacker/cooccurence/blob/master/english-ud-2.0-170801.udpipe"
                             ,"Sample udpipe model file"),   
                           
                           br(),
                           
                           h4('How to use this App'),
                           
                           p('To use this app, click on', 
                             span(strong("Upload text file")),
                             'and udpipe model file. You can also change the POS tags for different results')),
                  
                  tabPanel("Co-occurence Graph", 
                           plotOutput('plot'),
                           textOutput("txt")),
                          
                  
                  tabPanel("Word Cloud",
                           plotOutput('wcloud', width = "100%")),
                  
                  tabPanel("Data",
                           dataTableOutput('datatable'))
                  
      ) # end of tabsetPanel
    )# end of main panel
  )
))
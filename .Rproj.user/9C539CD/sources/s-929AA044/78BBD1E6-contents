shinyUI(fluidPage(
  
  # Application title
  titlePanel("Co-occurences App"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "Choose text File",
                multiple = FALSE,
                accept = c("text/plain", ".txt"))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
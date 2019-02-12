library(shiny)
library(rsconnect)
source('loading.R')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Facebook Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
       selectInput("variable", "Boxplot variable: ",list("Komentarze"="comment",
                                                 "Polubienia"="like",
                                                 "Udostepnenia"="share",
                                                 "Interakcje"="Total.Interactions"
                                                 )),
       sliderInput("PostHourInput", "Post.Hour", 0, 24, c(0, 6)),
       selectInput("Reg.Output","Dependent variable:", list("Komentarze"="comment",
                                                            "Polubienia"="like",
                                                            "Udostepnenia"="share",
                                                            "Interakcje"="Total.Interactions"
       )),
       selectInput("Reg.Input","Independent variable:", names(Facedata), multiple = TRUE)
       
    ),
    
    mainPanel(
      h3(textOutput("caption")),
      plotOutput("Plot"),
      h3(textOutput("caption2")),
      h6(verbatimTextOutput("caption3")),
      plotOutput("Plot2")
      
  )
)))

library(shiny)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  options(shiny.sanitize.errors = FALSE)
  output$contents <- renderTable({
    
     #input$file1 will be NULL initially. After the user selects
     #and uploads a file, head of that data file by default,
     #or all rows if selected, will be shown.
    
    req(input$file1)
    
    Facedata <- read.csv(input$file1$datapath,
                  header = input$header,
                  sep = input$sep,
                  quote = input$quote)
    
    })
    
    
  
    
    formulaText <- reactive({
    req(input$file1)
    paste(input$variable, " ~ Post.Hour")})
    
    
    formulaText2 <- reactive ({
      req(input$Reg.Input != '')
      req(input$file1)
      a = paste (input$Reg.Input, collapse = " + ")
      paste(input$Reg.Output, a, sep = "~")
    })
    
    FormulaText3 <- reactive ({
      req (input$file1)
      fit2 <- lm(as.formula(formulaText2()),data=Facedata)
      summary(fit2)
    })
    
    output$caption <- renderText({
      formulaText()
    })
    
    output$caption2 <- renderText({
      formulaText2()
    })
   
    output$Plot <- renderPlot({
      req (input$file1)
      filtered <- 
        Facedata %>%
        filter (Post.Hour >= input$PostHourInput[1],
                Post.Hour <= input$PostHourInput[2])
      
      boxplot(as.formula(formulaText()), 
              data = filtered)
    })
    
    output$Plot2 <- renderPlot({
      req (input$file1)
      fit1 <- lm(as.formula(formulaText2()),data=Facedata)
      par(mfrow=c(2,2));
      plot (fit1)
    })
    
    output$caption3 <- renderPrint({
      FormulaText3()
    })
    
    
    
    
  
})

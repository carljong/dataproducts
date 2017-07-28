#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(sqldf)
library(mgcv)

function(input, output) {
  
  alldata <- read_csv('data/alldata.csv')
  
  dataset <- reactive({
    if ( input$year != 'All') {
      alldatasub<-alldata[alldata$year==input$year,]
    } else if ( input$manufacturer1 !='All' && input$year != 'All') {
      alldatasub2<-alldatasub[alldatasub$mfr==input$manufacturer1,]
   # } else if ( test_expression3) {
  #    statement3
    } else
      alldata
    
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
  
}



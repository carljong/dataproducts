#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(sqldf)
library(mgcv)

library(readr)
alldata <- read_csv('data/alldata.csv')

dataset <- alldata

pageWithSidebar(
  
  headerPanel("Cars"),
  
  sidebarPanel(
    
    h2("Notes:"),
    
    h4("This app uses data from www.fueleconomy.gov"),
    
    h4("Suggestions: Use mfrid on the X axis to see the car company"),
    h4("FE stands for Fuel Economy, GHG stands for Greenhouse Gas"),
    
    selectInput('year', 'Year', c('All','2014','2015','2016','2017','2018')),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth')
    
    
    
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)

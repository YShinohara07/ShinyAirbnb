library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(googleVis)
library(leaflet)
library(leaflet.extras)
library(corrplot)
library(RColorBrewer)


# load file
raw = read.csv('airbnb_nyc.csv',stringsAsFactors = F)

#Correlation
cor_raw = raw %>% 
  select(price,
         Price.Night = price_night,
         Min.Night = minimum_nights,
         Review.Month = reviews_per_month,
         Availability = availability_365) %>% cor()

# Average and median price/night for each boro
boro_prices_n = raw %>% 
  group_by(boro) %>%  
  summarise(Average=mean(price_night), Median=median(price_night))



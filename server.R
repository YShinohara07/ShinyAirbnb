function(input, output) {
    #Welcome Screen
    observeEvent('',{
        showModal(modalDialog(
            includeHTML('intro.html'),
            easyClose = T))
    })
    
    #Graph 1 = brough overview
    output$graph1 = renderGvis(
        {gvisColumnChart(boro_prices_n,
                      options = list(width='auto', height='500', fontSize = '24',
                                     title='Price Differences for each Borough',
                                     vAxes='[{title:"Prices / Night (USD)"}]' ) 
                      )}
    )
    
    #cor = correlation
    output$cor = renderPlot({
    corrplot(cor_raw, method = 'pie',type = 'lower', order = 'hclust', 
             col=brewer.pal(n=8, name="RdYlBu"))
    })
    
    #Graph 2 = price range plot -----
    
    #Price Range
    reactive_raw <- reactive({
        raw %>% filter( (price_night >= input$slider[1]) & (price_night <= input$slider[2]) ) }
    )
    
    output$graph2 = renderPlot({
        ggplot(reactive_raw(), aes(x=price_night) )+  
        geom_density(aes(color = boro) )+  
        labs(color = "Borough")
                  
    })
    
    #Maps -----

    #Desired Price and nights
    reactive_price = reactive({
        raw %>% filter( (price <= input$num.price+10) & (price >= input$num.price-10), 
            minimum_nights == input$min.nights)
    })
    
    
    #Heat map and marker map
    output$map = renderLeaflet({
    reactive_price() %>% select(latitude, longitude) %>% 
        leaflet() %>% addTiles() %>%
            addHeatmap(lng = ~longitude, lat = ~latitude, radius = 8)
    })
    
    #About me ---

    output$photo = renderImage({
        
        return(list(src='self.jpg',
                    filetype='image/jpeg',
                    alt='photo'))
    }, deleteFile = F
    )
}

shinyUI(
    dashboardPage(

        # Dashboard Skin ---------
        skin = 'red', dashboardHeader( title = "Airbnb NYC 2019"),
        dashboardSidebar(

          # Menu Options ----------
            sidebarMenu(
                menuItem('Borough Overview',tabName = 'graph1',icon = icon("chart-bar") ),
                menuItem('Correlation', tabName = 'cor', icon = icon('hand-holding-usd')),
                menuItem('Price Range',tabName = 'graph2',icon = icon("chart-line") ),
                menuItem('Heat Map',tabName = 'map',icon = icon("map") ),
                menuItem('About Me',tabName = 'about', icon = icon('address-card'))
                )
        ),
        
        dashboardBody(
            tabItems(
                
                # Graphs Average and Median of the Boroughs using Google Vis
                tabItem( tabName = 'graph1',
                    fluidRow(
                      box(
                        htmlOutput('graph1'), 
                        width = 12, 
                        height = 500) 
                      ) 
                    ),

                # Correlation of Variables
                tabItem( tabName = 'cor', 
                        
                        # Title
                        class = 'text-center',
                        tags$h1('Confirming Variables using Correlation',
                        tags$head(
                          tags$style(
                            "{font-size: 20px;
                              font-style: italic; }") )
                        ),

                        # Info Boxes
                        fluidRow(
                            valueBox('0.089', 'minimum night : availability', 
                                     color = 'purple', icon = icon("bed"), width = 3),
                            valueBox('0.061', '$/night : availability', 
                                     color = 'green', icon = icon('dollar-sign'), width = 3),
                            valueBox('-0.064', 'reveiw/month : price',
                                     color = 'red', icon = icon('calendar'), width = 3),
                            valueBox('-0.065', 'review/month : availability',
                                     color = 'orange', icon = icon('calendar-check'), width = 3)
                        ),
                        
                        # Correlation Visual Graph
                        fluidRow(plotOutput('cor')
                                 )
                        ),

                # Density Graph of price/night for each borough
                tabItem(tabName = 'graph2',
                        
                        # Title
                        class = 'text-center',
                        tags$h1('Proportion Outlook between Borough and Price/Night',
                                tags$head(
                                  tags$style(
                                    "{font-size: 16px;
                                     font-style: italic; }") )
                        ),

                        # Graph Visual
                        plotOutput('graph2'),


                        # Sliding Widget
                        sliderInput(
                          "slider", 
                          label = h3("Price Range"), 
                          min = 0, 
                          max = 1000, 
                          value = c(0, 500) 
                          )

                        ),

                # Heat Map
                tabItem(tabName = 'map',

                        # Title
                        tags$h1('Targeted Airbnb Locations',
                                tags$head(tags$style("{font-size: 16px;
                                     font-style: italic; }") )
                        ),

                        # Option boxes
                        fluidRow(box(numericInput("num.price", 
                                                  label = h4("Desired Price"), 
                                                  value = 50 ),
                                     width = 2),
                                 box(numericInput("min.nights",
                                                  label = h4('Mininum Stay'),
                                                  value = 1),
                                     width = 2)
                                 ),

                        # Leaflet Map
                        fluidRow(
                          box(
                            leafletOutput('map'), 
                            width = 10))

                        ),

                # About Me
                tabItem(tabName = 'about', 

                        # Myself
                        box(title = 'About me',
                            status = 'info',
                            width = 6,
                            includeHTML('AboutMe.html'),
                            imageOutput('photo'),
                            ),

                        # Next Steps
                        box(title = 'Next Steps',
                            status = 'info',
                            width = 6,
                            includeHTML('NextSteps.html') )
                    )
                )
                
            )
        )
) 

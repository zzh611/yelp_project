shinyUI(
    fluidPage(theme = shinytheme("simplex"),

    # Application title
    titlePanel(fluidPage(
        column(img(src="yelp.png",width="200px"),width=2),
        column(br(),"BBQ Restaurant Analysis",width=8)
    )
    ),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                  radioButtons("inputway", "Find Your BBQ Restaurant:",
                               list("Business Name" = "bname",
                                    "Business ID" = "bid")),
                  conditionalPanel(condition="input.inputway=='bid'",
                                   textInput("id","Business ID:",value = "")),
                  conditionalPanel(condition="(input.inputway=='bname')",
                                   uiOutput("selectstate")),
                  conditionalPanel(condition="(input.inputway=='bname')",
                                   uiOutput("selectcity")),
                  conditionalPanel(condition="(input.inputway=='bname')",
                                   uiOutput("selectname")),
                  conditionalPanel(condition="(input.inputway=='bname')",
                                   uiOutput("selectid")),
                  actionButton("submit", "Submit"),
                  tags$hr(),
                  helpText("If there are any problems, feel free to contact us.")
),
        # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("Info",h2(strong(textOutput("nametitle"))),
                     conditionalPanel(condition="input.submit",
                     fluidRow(column(6,
                                     fluidRow(column(4,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("star"),
                                                     HTML("</div>")),
                                              column(5,div(textOutput("reviewcount")))),
                                     h3("Location"),
                                     h5(textOutput("address")),
                                     tags$hr(),
                                     h3("Amenities"),
                                     fluidRow(column(2,img(src="Takeout.PNG",height="20px")),
                                              div(textOutput("takeout")),
                                              br(),
                                              column(2,img(src="Delivery.PNG",height="20px")),
                                              div(textOutput("delivery")),
                                              br(),
                                              column(2,img(src="Parking.PNG",height="20px")),
                                              div(textOutput("parking")),
                                              br(),
                                              column(2,img(src="Outdoor.PNG",height="20px")),
                                              div(textOutput("outdoorseating"))
                                              ),
                                     tags$hr(), 
                                     h3("Other Attributes"), 
                                     h4("Noise"), h5(textOutput("noise")),
                                     tags$hr(),
                                     h4("Alcohol"), h5(textOutput("alcohol"))
                                     
                                     ),column(6,leafletOutput("map",height=400)))
            )),
            tabPanel("Like",
                     fluidRow(
                         column(12,align="center",HTML("<div style='height: 60px;'>"),
                                conditionalPanel(condition="input.submit",h3(strong("Positive Reviews"))),
                                HTML("</div>"),
                                wordcloud2Output('pos')))),
            tabPanel("Dislike",
                     fluidRow(
                         column(12,align="center",HTML("<div style='height: 60px;'>"),
                                conditionalPanel(condition="input.submit",h3(strong("Negative Reviews"))),
                                HTML("</div>"),
                                wordcloud2Output('neg')))),
            tabPanel("Suggestions",
                     fluidRow(
                         column(12,align="center",HTML("<div style='height: 40px;'>"),
                                conditionalPanel(condition="input.submit",h3(strong("Suggestions for Business Owner"))),
                                HTML("</div>"))),
                     h4(textOutput("generalsuggestion")),
                     tags$hr(), 
                     h4(uiOutput("suggestion")))
        
            
        )
    )
    
)))

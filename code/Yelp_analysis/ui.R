shinyUI(fluidPage(
    includeCSS("www/bootstrap.css"),

    # Application title
    titlePanel("Yelp BBQ Analysis"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                  radioButtons("inputway", "Find Your BBQ Restaurant:",
                               list("Business ID" = "bid",
                                    "Business Name" = "bname")),
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
                                     fluidRow(column(3,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("star"),
                                                     HTML("</div>")),
                                              column(5,div(textOutput("reviewcount")))),
                                     h3("Location"),
                                     h5(textOutput("address"),style = "color:grey"),
                                     tags$hr(),
                                     h3("Amenities"),
                                     fluidRow(column(1,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("takeouticon"),
                                                     HTML("</div>")),
                                              div(textOutput("takeout")),
                                              br(),
                                              column(1,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("deliveryicon"),
                                                     HTML("</div>")),
                                              div(textOutput("delivery")),
                                              br(),
                                              column(1,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("parkingicon"),
                                                     HTML("</div>")),
                                              div(textOutput("parking")),
                                              br(),
                                              column(1,HTML("<div style='height: 20px;'>"),
                                                     imageOutput("outdoorseatingicon"),
                                                     HTML("</div>")),
                                              div(textOutput("outdoorseating"))
                                              ),
                                     
                                     tags$hr(),
                                     h3("Other Attributes"),
                                     h4("Noise"),
                                     h5(textOutput("noise"),style = "color:grey"),
                                     tags$hr(),
                                     h4("Alcohol"),
                                     h5(textOutput("alcohol"),style = "color:grey"),
                                     
                                     ))
            )),
            tabPanel("Compare"),
            tabPanel("Good & Bad")
            
        )
    )
    
)))

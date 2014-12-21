library(shiny)
shinyUI(fluidPage(
#fluid layout will adjust display to users web window         
        titlePanel(
        h3(("Course Project: Shiny Application"), br(), strong("Iris Species Prediction"), br(), h4(em("by M. Krajewska"))),
        ("Iris Species Prediction")),
        sidebarLayout(
                sidebarPanel(
                        h4("Enter variables of your prediction here"),
                        br(),
                        helpText("Predict the species of an Iris flower based on two variables:", br(), strong("Sepal"), "Length and Width
                                 or", br(), strong("Petal"), "Length and Width"),
                        br(),
                        selectInput("var", label = "Choose the main variable", choices = c("Sepal", "Petal")),
                        br(),
                        uiOutput("ui"),
                        br()
                        
                ),
mainPanel(
        tabsetPanel(type = "tabs",            
                tabPanel("Prediction",
                        h4(("Results of Prediction"), br()),
                        h4('You entered'), verbatimTextOutput("inputValue"),
                        
                        h4('Which resulted in a prediction of '),verbatimTextOutput("prediction")),
                tabPanel("Summary", verbatimTextOutput("summary")),
                tabPanel("About", fluidRow(
                        column(6,
                               includeMarkdown("about.md")
                        ),
                        column(3,
                               tags$img(src= "Iris_barbata_elatior.png"),
                               br(),
                               tags$small(
                                       "Iris barbata elatior 'Barocco', by"),
                                       a(href="http://commons.wikimedia.org/wiki/User:Jebulon",
                                         "User: Jebulon"))))
        )
        )   
        )
))
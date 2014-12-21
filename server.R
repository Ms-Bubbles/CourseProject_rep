library(randomForest)
library(caret)
data(iris)
iris.ds <- iris

iris.ds.Sepal <-  iris.ds[, c("Sepal.Length", "Sepal.Width", "Species")]
iris.ds.Petal <- iris.ds[, c("Petal.Length", "Petal.Width", "Species")]

iris.model.Sepal <- randomForest(Species ~ Sepal.Length + Sepal.Width, data=iris.ds.Sepal)
iris.model.Petal <- randomForest(Species ~ Petal.Length + Petal.Width, data=iris.ds.Petal)

shinyServer(function(input, output) {
        
        output$ui <- renderUI({
                switch(input$var,
                       "Sepal" = c(sliderInput("x", "Sepal.Length", min=4.3 , max= 7.9, value=7.9, step = 0.1), 
                                   sliderInput("y", "Sepal.Width", min=2 , max= 4.4, value = 2, step = 0.1)),      
                       
                       "Petal" = c(sliderInput("x", "Petal.Length", min=1 , max= 6.9, value = 6.9, step = 0.1), 
                                   sliderInput("y", "Petal.Width", min=0.1 , max= 2.5, value = 0.1, step = 0.1))
                )                 
                
        })
        
        output$prediction <-renderPrint({
                user.ds.Sepal <- data.frame(as.numeric(input$x), as.numeric(input$y))
                names(user.ds.Sepal) <- c("Sepal.Length", "Sepal.Width")     
                
                user.ds.Petal <- data.frame(as.numeric(input$x), as.numeric(input$y))
                names(user.ds.Petal) <- c("Petal.Length", "Petal.Width")     
                
                if(input$var== "Sepal") {
                        iris.predict <- predict(iris.model.Sepal, user.ds.Sepal) 
                }
                else if(input$var== "Petal") {
                        iris.predict <- predict(iris.model.Petal, user.ds.Petal)
                } 
                iris.predict
        })
                
        
        output$inputValue <- renderText({
                c(input$x, input$y)})
        output$summary <- renderPrint({
                summary(iris)})
        
})          

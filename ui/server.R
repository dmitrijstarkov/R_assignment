library(shiny);
library(datasets);
library(ggplot2)

df<-airquality

shinyServer(
  function(input,output){
    output$histplot<-renderPlot({
    Selected_Variable <- df[, input$plot]
    p1 <- ggplot(df, aes(x = Selected_Variable)) + 
            geom_histogram(alpha=0.5, color="red", binwidth = 3) + 
      xlab(as.character(input$plot))
    print(p1)
    })
    
    output$prediction<-renderPlot({

        if (input$varx == "Solar.R") {
           p <- ggplot(data=df, aes(x=Wind, y = Ozone) )
           p <- p + xlab("Solar R (lang)") + ylab("Ozone (ppb)")
        }
        else {
           if (input$varx == "Wind") {
               p <- ggplot(data=df, aes(x=Temp, y = Ozone) )
               p <- p + xlab("Wind (mph)") + ylab("Ozone (ppb)")
           }
           else {
              if (input$varx == "Temp") {
                  p <- ggplot(data=df, aes(x=Solar.R, y = Ozone) )
                  p <- p + xlab("Temperature (degree F)") + ylab("Ozone (ppb)")
              }
           }
        }

        p <- p + geom_jitter()
        p <- p + geom_smooth(method = "lm")
        
        print(p)
    })
    
  }
)
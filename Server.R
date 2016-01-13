library(caret)
library(ggplot2)
library(lattice)
library(Rmisc)
library(plyr)
library(randomForest)
library(e1071)
data(iris)
set.seed(12345)
modfit<-train(Species~.,data=iris,method="rf")
p1<-ggplot(data=iris,aes(x=Sepal.Length,y=Sepal.Width))
p1<-p1+geom_point(aes(colour=Species),size=1.5)
p2<-ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Width))
p2<-p2+geom_point(aes(colour=Species),size=1.5)
p3<-ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length))
p3<-p3+geom_point(aes(colour=Species),size=1.5)
p4<-ggplot(data=iris,aes(x=Sepal.Width,y=Petal.Width))
p4<-p4+geom_point(aes(colour=Species),size=1.5)
p5<-ggplot(data=iris,aes(x=Sepal.Width,y=Petal.Length))
p5<-p5+geom_point(aes(colour=Species),size=1.5)
p6<-ggplot(data=iris,aes(x=Petal.Length,y=Petal.Width))
p6<-p6+geom_point(aes(colour=Species),size=1.5)


shinyServer(  
  function(input, output) {    
    
    test_df<-reactive(data.frame(Sepal.Length=input$sepal_length,
                                Sepal.Width=input$sepal_width,
                                Petal.Length=input$petal_length,
                                Petal.Width=input$petal_width,
                                Species=as.factor("unknown")))

    output$prediction_outcome_text<-renderPrint({
#      browser()
      as.character(predicted)
    })       


#    predicted<-as.factor("unknown")
    output$newPlot <- renderPlot({      
##      browser()
      p1_1<-p1+geom_point(data=test_df(), aes(x=Sepal.Length,y=Sepal.Width, color='unknown'),size=3)
      p1_1<-p1_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
      
      p2_1<-p2+geom_point(data=test_df(), aes(x=Sepal.Length,y=Petal.Width, color='unknown'),size=3)
      p2_1<-p2_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
      
      p3_1<-p3+geom_point(data=test_df(), aes(x=Sepal.Length,y=Petal.Length, color='unknown'),size=3)
      p3_1<-p3_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
      
      p4_1<-p4+geom_point(data=test_df(), aes(x=Sepal.Width,y=Petal.Width, color='unknown'),size=3)
      p4_1<-p4_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))

      p5_1<-p5+geom_point(data=test_df(), aes(x=Sepal.Width,y=Petal.Length, color='unknown'),size=3)
      p5_1<-p5_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))

      p6_1<-p6+geom_point(data=test_df(), aes(x=Petal.Length,y=Petal.Width, color='unknown'),size=3)
      p6_1<-p6_1+scale_colour_manual(values=c("lightpink2", "red2", "steelblue2", "mediumorchid2"))
      
      multiplot(p1_1,p2_1,p3_1,p4_1,p5_1,p6_1,cols=2)
#      multiplot(p1_1,cols=1)
#      print(p1_1)
      df<-data.frame(
        Sepal.Length=isolate(input$sepal_length),
        Sepal.Width=isolate(input$sepal_width),
        Petal.Length=isolate(input$petal_length),
        Petal.Width=isolate(input$petal_width)
      )
      predicted<-predict(modfit, df)
      output$prediction_outcome_text<-renderText({as.character(predicted)})
    })      
  }
)
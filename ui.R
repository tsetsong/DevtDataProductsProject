shinyUI(
  pageWithSidebar(  

    headerPanel("Prediction of Flower Species"),  
    
    sidebarPanel(    
      sliderInput('sepal_length', 'Sepal Length',value = 6.0, min = 4,   max = 8,    step = 0.05), 
      sliderInput('sepal_width',  'Sepal Width', value = 3.0, min = 1.8, max = 4.6,  step = 0.01), 
      sliderInput('petal_length', 'Petal Length',value = 3.5, min = 0.8, max = 7.0,  step = 0.05), 
      sliderInput('petal_width',  'Petal Width', value = 1.2, min = 0.05, max = 2.6, step = 0.01),   
      submitButton('Submit')
    ),
    mainPanel(    
      h5("Please change the values of the sepals and petals on the left panel and click the <Submit> Button. 
          The charts and the prediction results will be updated. The set of values being predicted is marked 
          on the charts with a red dot and named \"unknown\"."),
      plotOutput('newPlot'), 
      h2('Prediction Outcome:'),
      h2(textOutput('prediction_outcome_text'))
    )
  )
)
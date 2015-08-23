library(shiny)
library(UsingR)


shinyUI(fluidPage(
    titlePanel(
        h1("Custom binning of continuous variables")
                ),
    
    sidebarLayout(
        sidebarPanel( 
        h3("Binning parameters:"),
        radioButtons('dataset','Select dataset',c("MLBattend"),selected = "MLBattend", inline = FALSE),
        selectInput('fieldToBin','Select variable to bin'
                     ,colnames(MLBattend)[sapply(MLBattend, class)=="numeric"][2:6],selected = "attendance"),
        sliderInput('buckets', 'Select the number of equally sized buckets te create:', min = 2, max = 10,value = 7, step = 1),
 #       sliderInput("bins","Number of histogram bins to display:",min = 5,max = 50,value = 30,step=5),
        h5("Customizing binning cutoffs:"),
        HTML("<i>When  customized binning cutoffs are not used, 
             the binning code is based on the exact cutoffs as presented in the table at your right </i>"),
        h5(" "),
        numericInput("cutoff1","1st cutoff (boundary between bin 1 and bin 2)",value=NA),
        numericInput("cutoff2","2nd cutoff (bin 2 <> bin 3)",value=NA),
        numericInput("cutoff3","3rd cutoff (bin 3 <> bin 4)",value=NA),
        numericInput("cutoff4","4th cutoff (bin 4 <> bin 5)",value=NA),
        numericInput("cutoff5","5th cutoff (bin 5 <> bin 6)",value=NA),
        numericInput("cutoff6","6th cutoff (bin 6 <> bin 7)",value=NA),
        numericInput("cutoff7","7th cutoff (bin 7 <> bin 8)",value=NA),
        numericInput("cutoff8","8th cutoff (bin 8 <> bin 9)",value=NA),
        numericInput("cutoff9","9th cutoff (bin 9 <> bin 10)",value=NA),
        h5(" "),
        HTML("<i>App created with Shiny </i>"),
        img(src="bigorb.png", height = 40, width = 40)
        
        ),
        mainPanel(
            HTML("<i> In many data analysis tasks, transforming continuous variables into binned variables with equally sized bins can be of great value. 
             Using percentile cutoffs, the variable can be split, however this approach often results in awkward cutoffs the user would like to customize.
             This Shiny tool enables the user to evaluate the distribution of a selected variable in the data set and
              determine for a selected number of bins (2-10)  where the exact cutoffs between bins are located. 
              The  user can then devitate from exact cutoffs to have more insightful bin boundaries. 
              The R code to derive the binned version is presented to the user and can be copy-pasted to the users R script. </i>"),
            plotOutput('myHist'),
            tableOutput('myTable'),
            h5("code to bin selected variable:"),
            HTML(paste("<pre>",textOutput('myText'),"</pre>"))
        )
    )
))



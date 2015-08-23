
library(shiny)
library(UsingR)
library(datasets)


shinyServer(
    function(input, output) {
        quantiles<-reactive({quantile(MLBattend[,input$fieldToBin],probs = (1:input$buckets)/input$buckets,na.rm = TRUE)})

            output$myHist <- renderPlot({
            hist(MLBattend[,input$fieldToBin],
                 xlab=paste("Fieldname: ",
                 input$fieldToBin, sep=" "),
                 col="skyblue",
                 main=paste('Histogram of ',input$fieldToBin,sep = ''),
#                 breaks = input$bins, 
                 breaks = 40, 
                 border = 'white'
                    )
            for (i in 1:(input$buckets-1)) {
                lines(c({quantiles()}[i],{quantiles()}[i]),c(0,300),col='red',lwd=3)

            }
        })
        output$myTable <- renderTable({
            data.frame(cbind("bin"=1:input$buckets,
                             "bin start"=c(0,{quantiles()}[1:input$buckets-1]),
                             "bin end"={quantiles()},
                             "customized bin start"=c(0,input$cutoff1,input$cutoff2,input$cutoff3,input$cutoff4,input$cutoff5,input$cutoff6,input$cutoff7,input$cutoff8)[1:input$buckets],
                             "customized bin end"=c(input$cutoff1,input$cutoff2,input$cutoff3,input$cutoff4,input$cutoff5,input$cutoff6,input$cutoff7,input$cutoff8,input$cutoff9)[1:(input$buckets)]
            )
            )
            
        },include.rownames=FALSE)
        output$myText<-renderText({ 
            paste("# COPY THIS CODE  TO YOUR R SCRIPT TO CREATE BINNED VARIABLE:",
                  "",
                  paste(input$fieldToBin,"_binned <- ",input$buckets,sep=''),
                  if(input$buckets ==10) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff9)){round({quantiles()}[9],2)} else{round(input$cutoff9,0)},'] <- 9',sep='')},       
                  if(input$buckets >=9) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff8)){round({quantiles()}[8],2)} else{round(input$cutoff8,0)},'] <- 8',sep='')},
                  if(input$buckets >=8) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff7)){round({quantiles()}[7],2)} else{round(input$cutoff7,0)},'] <- 7',sep='')},
                  if(input$buckets >=7) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff6)){round({quantiles()}[6],2)} else{round(input$cutoff6,0)},'] <- 6',sep='')},
                  if(input$buckets >=6) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff5)){round({quantiles()}[5],2)} else{round(input$cutoff5,0)},'] <- 5',sep='')},
                  if(input$buckets >=5) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff4)){round({quantiles()}[4],2)} else{round(input$cutoff4,0)},'] <- 4',sep='')},              
                  if(input$buckets >=4) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff3)){round({quantiles()}[3],2)} else{round(input$cutoff3,0)},'] <- 3',sep='')},      
                  if(input$buckets >=3) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff2)){round({quantiles()}[2],2)} else{round(input$cutoff2,0)},'] <- 2',sep='')},
                  if(input$buckets >=2) {paste(input$fieldToBin,"_binned[",input$dataset,'$',input$fieldToBin,'<=',
                                        if(is.na(input$cutoff1)){round({quantiles()}[1],2)} else{round(input$cutoff1,0)},'] <- 1',sep='')},
                  sep='\n')
        })
    }
)




# David López

# Paquetes
library(shiny)
library(plotly)
library(shinydashboard)


# Funciones

obtieneValores <- function(semilla,n,var,media) {
  set.seed(semilla)
  offset.sesgo <- offset
  n.real <- n
  valores.n <- rnorm(n=n.real,mean=media,sd = sqrt(var))
  list(n,media,valores.n)
}


# UI
ui <- dashboardPage(

   dashboardHeader(title= "Momentos Estadísticos"),

   dashboardSidebar(
        textInput('semilla','Semilla:',value='97364712'),
        textInput('n','Número de Muestras:',value='100'),
        textInput('bins','Número de Bins (Buckets):',value='50'),
         sliderInput("media","Media:",min = -4,max = 4,value = 0),
         sliderInput("varianza","Varianza:",min = 0,max = 15,value = 1)
      ),

      dashboardBody(
        fluidRow(
          valueBoxOutput('valBoxMedia',width = 3),
          valueBoxOutput('valBoxVarianza',width = 3),
          valueBoxOutput('valBoxSesgo',width = 3),
          valueBoxOutput('valBoxKurtosis',width = 3)
          ),
        plotlyOutput("histMomentos")
      )
)

# Globales
offset.sesgo <- 4

# Server
server <- function(input, output) {
  
  output$valBoxMedia <- renderValueBox({
    valueBox(input$media,'Media',icon = icon("list"),color = "green",width = 3)
  })
  output$valBoxVarianza <- renderValueBox({
    valueBox(input$varianza,'Varianza',icon = icon("list"),color = "blue",width = 3)
  })
  output$valBoxSesgo <- renderValueBox({
    valores <- obtieneValores(input$semilla,as.numeric(input$n),input$varianza,input$media)
    val.completos <- c(valores[[3]])
    print(val.completos)
    valueBox(round(moments(x=val.completos[3]),2),'Sesgo',icon = icon("list"),color = "purple",width = 3)
  })
  output$valBoxKurtosis <- renderValueBox({
    valores <- obtieneValores(input$semilla,as.numeric(input$n),input$varianza,input$media)
    val.completos <- c(valores[[3]])
    valueBox(round(moments(x=val.completos[4]),2),'Kurtosis',icon = icon("list"),color = "orange",width = 3)
  })
   
   output$histMomentos <- renderPlotly({
     valores <- obtieneValores(input$semilla,as.numeric(input$n),input$varianza,input$media)
      n <- valores[[1]]
      media <- valores[[2]]
      val.n <- valores[[3]]
      datos <- data.frame(valor=c(val.n))
      ggplot(datos) + geom_histogram(aes(x=valor),fill='blue',color='gray',bins = input$bins) + scale_x_continuous(limits=c(-10,10),breaks = seq(-10,10))
      #bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      #hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)





################################################################################################
################################################################################################
################################################################################################


# ui <- fluidPage(
#    
#    titlePanel("Momentos Estadísticos"),
#    
#    sidebarLayout(
#       sidebarPanel(
#         textInput('semilla','Semilla:',value='97364712'),
#         textInput('n','Número de Muestras:',value='100'),
#         textInput('bins','Número de Bins (Buckets):',value='50'),
#          sliderInput("media","Media:",min = -4,max = 4,value = 0),
#          sliderInput("varianza","Varianza:",min = 0,max = 15,value = 1),
#         sliderInput("sumaSesgoIzq","Añadir Sesgo Izq (pct. muestras):",min = 0,max = 40,value = 0),
#         sliderInput("sumaSesgoDer","Añadir Sesgo Der (pct. muestras):",min = 0,max = 40,value = 0)
#       ),
#       
#       # Show a plot of the generated distribution
#       mainPanel(
#         fluidRow(
#           valueBoxOutput('valBoxMedia')
#           ),
#          plotlyOutput("histMomentos")
#       )
#    )
# )

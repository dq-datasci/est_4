library(shiny)
source("R/stats.R")

ui <- fluidPage(
  titlePanel("Simulación de Muestra Simple"),
  sidebarLayout(
    sidebarPanel(
      # Semilla para la generación de la población (Semilla 1)
      numericInput("seed_poblacion", "Semilla Población", 123, min = 1, max = 1000),
      # Semilla para el proceso de muestreo (Semilla 2)
      numericInput("seed_muestra", "Semilla Muestra", 456, min = 1, max = 1000),
      # Resto de parámetros
      numericInput("n_poblacion", "Tamaño población", 1000, min = 100, max = 10000),
      numericInput("p_real", "Proporción real", 0.5, min = 0.1, max = 0.9, step = 0.1),
      numericInput("n_muestra", "Tamaño muestra", 100, min = 10, max = 500),
      actionButton("generar", "Generar Muestra")
    ),
    mainPanel(
      h4("Resultados de la Muestra"),
      verbatimTextOutput("resultado"),
      tableOutput("tabla")
    )
  )
)

server <- function(input, output) {
  
  observeEvent(input$generar, {
    # Generar población con la Semilla Población
    poblacion <- generar_poblacion(input$seed_poblacion, input$n_poblacion, input$p_real)
    
    # Tomar muestra con la Semilla Muestra, asegurando la reproducibilidad del sampling
    muestra <- tomar_muestra(poblacion, input$n_muestra, input$seed_muestra)
    
    # Calcular proporción muestral
    p_muestral <- calcular_proporcion(muestra)
    
    # Mostrar resultados
    output$resultado <- renderPrint({
      cat("Proporción real:", input$p_real, "\n")
      cat("Proporción muestral:", round(p_muestral, 4), "\n")
      cat("Diferencia:", round(p_muestral - input$p_real, 4), "\n")
      cat("Tamaño muestra:", input$n_muestra, "\n")
    })
    
    # Corregido: Asegurar la sintaxis correcta del vector 'Conteo'
    output$tabla <- renderTable({
      data.frame(
        Categoria = c("0", "1", "Total"),
        Conteo = c(
          sum(muestra == 0),
          sum(muestra == 1),
          length(muestra)
        )
      )
    })
  })
}

shinyApp(ui, server)
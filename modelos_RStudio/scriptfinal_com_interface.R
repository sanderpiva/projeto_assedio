library(shiny)
library(dplyr)

ui <- fluidPage(
  fileInput("data_file", "Carregar arquivo CSV:"),
  actionButton("load_button", "Carregar"),
  actionButton("split_button", "Dividir e Treinar"),
  actionButton("predict_button", "Prever"),
  actionButton("summary_button", "Resumo do Modelo"),
  dataTableOutput("result_table"),
  dataTableOutput("data_table"), # Added for data visualization
  verbatimTextOutput("data_summary"),
  verbatimTextOutput("model_summary")
)

server <- function(input, output) {
  data <- reactive({
    req(input$data_file)
    read.csv(input$data_file$datapath)
  })
  
  observeEvent(input$load_button, {
    data()
  })
  
  train_data <- reactive({
    req(data())
    sample_frac(data(), 0.7) # 70% dos dados para treinamento
  })
  
  test_data <- reactive({
    req(data())
    dplyr::anti_join(data(), train_data(), by = colnames(data())) # O restante para teste
  })
  
  output$data_table <- renderDataTable({
    req(data())
    data()
  })
  
  output$data_summary <- renderPrint({
    req(input$split_button, data(), train_data(), test_data())
    total_data <- nrow(data())
    train_data_count <- nrow(train_data())
    test_data_count <- nrow(test_data())
    
    cat("Número total de dados:", total_data, "\n")
    cat("Quantidade de dados de treino:", train_data_count, "\n")
    cat("Quantidade de dados de teste:", test_data_count, "\n")
  })
  
  model <- reactive({
    req(train_data())
  
    lm(X14 ~ X15 + X17 + X10 + X6 + X9 + X11 + X1 + X2 + X5, data = train_data())
  })
  
  output$result_table <- renderDataTable({
    req(input$predict_button, train_data(), test_data(), model())
    
    test_features <- test_data()
    test_labels <- test_features$X14 # Coluna com os rótulos reais
    test_predictions <- predict(model(), newdata = test_features)
    
    result_df <- data.frame(
      Real = test_labels,
      Previsto = test_predictions
    )
    
    result_df
  })
  
  output$model_summary <- renderPrint({
    req(input$summary_button, model())
    summary(model())
  })
}

shinyApp(ui, server)

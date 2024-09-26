grafico <- function(modelo, tipo) {
  # verificar se a classe do modelo inserido pelo usuário é "modelo_linear":
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }
  # Gráfico de Valores Preditos vs Observados (pvo)
  if (tipo == "pvo") {
    result <- plot(modelo$dados[, 1], modelo$ajustados,
                   xlab = "Valores Observados",
                   ylab = "Valores Preditos",
                   main = "Valores Preditos vs Observados",
                   pch = 19, col = "blue")
    #abline(a = 0, b = 1, col = "red", lwd = 2) 
  }
  # Gráfico de Resíduos vs Ordem de coleta (rvo)
  else if (tipo == "rvo") {
    result <- plot(modelo$dados[,2], modelo$residuos,
                   xlab = "Ordem",
                   ylab = "Resíduos",
                   main = "Resíduos vs Ordem",
                   pch = 19, col = "blue")
    #abline(h = 0, col = "red", lwd = 2)
  }
  # Qualquer outro tipo
  else {
    stop("Erro: tipo de gráfico inválido. Use 'pvo' para preditos vs observados ou 'rvo' para resíduos vs ordem de coleta.")
  }
  
  return(result)
}

#Coloquei as funções que estavam em regressão.linear.R em arquivos separados, e comecei a fazer a documentação da função reg_linear.

summary(modelolara)
grafico(modelolara, tipo = "pvo")


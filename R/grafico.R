#' @title Gráficos de resíduos
#' @description
#' \code{grafico} Função utilizada para criação de gráficos de resíduos em regressão linear. Válida também para regressão linear múltipla.
#'
#'
#' @param modelo Modelo de regressão linear simples ou múltipla. Deve ser, obrigatoriamente, da classe \code{"modelo_linear"}.
#' Deve conter os elementos \code{dados}, \code{residuos} (ou seja, os resíduos do modelo) e \code{ajustados} (ou seja, os valores ajustados (preditos) pelo modelo). 
#' O modelo fornecido deve ter a classe "modelo_linear", caso contrário, a função gerará um erro. 
#' @param tipo É uma string que especifica o tipo de gráfico desejado. Os valores aceitos são:
#' \describe{
#'   \item{rvp}{Gera gráficos de Resíduos vs Preditoras.}
#'   \item{rva}{Gera um gráfico de Resíduos vs Valores Ajustados.}
#'   \item{normres}{Gera um Gráfico QQPlot para avaliar a normalidade dos resíduos.}
#' }
#' 
#'
#' @examples
#' grafico(modelo, "rvp")      # Gráfico de Resíduos vs Preditoras
#' grafico(modelo, "rva")      # Gráfico de Resíduos vs Valores Ajustados
#' grafico(modelo, "normres")  # Gráfico Q-Q de Normalidade dos Resíduos
#'
#'
#'
#' @export
grafico <- function(modelo, tipo) {
  # verificar se a classe do modelo inserido pelo usuário é "modelo_linear":
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }
  # Gráfico de Resíduos vs Preditoras (rvp)
  if (tipo == "rvp") {
    colunas_preditoras <- colnames(modelo$dados[-1])
    for (coluna_preditora in colunas_preditoras) {
      plot(modelo$dados[,coluna_preditora], modelo$residuos,
                     xlab = coluna_preditora,
                     ylab = "Resíduos",
                     main = "Resíduos vs Preditoras",
                     pch = 19, col = "black")
      abline(h = 0, col = "red", lwd = 2, lty = 5)
    }
  }
  # Gráfico de Resíduos vs Valores Ajustados (rva)
  else if (tipo == "rva") {
    plot(modelo$ajustados, modelo$residuos,
                   xlab = "Valores Preditos",
                   ylab = "Resíduos",
                   main = "Resíduos vs Preditos",
                   pch = 19, col = "black")
    abline(h = 0, col = "red", lwd = 2, lty = 5) 
  }
  # Gráfico de Normalidade dos Resíduos (normres)
  else if (tipo == "normres") {
      qqnorm(modelo$residuos) 
      qqline(modelo$residuos, col = "red")
      xlab = "Quantis Teóricos"
      ylab = "Quantis Amostrais"
  }
  # Qualquer outro tipo
  else {
    stop("Erro: tipo de gráfico inválido. Use 'rvp' para resíduos vs preditoras, 'rva' para resíduos vs ajustados, ou 'normres' para normalidade dos resíduos.")
  }
  
}


#' @title Função de Predição para Modelos Lineares
#' @description
#' A função \code{predicao} realiza predições a partir de um modelo de regressão linear ajustado. Ela utiliza o modelo fornecido e aplica os preditores fornecidos para calcular os valores preditos.
#' A função pode ser aplicada tanto em modelos de regressão simples quanto multivariada.
#'
#' @param modelo Um modelo de regressão linear da classe \code{"modelo_linear"}. Caso contrário, a função irá gerar um erro.
#' @param preditores Uma matriz ou data frame contendo os valores preditores. O número de preditores deve ser compatível com o modelo ajustado.
#'
#' @return Retorna um objeto da classe \code{"predicao"}, contendo:
#' \item{preditores}{Os preditores utilizados na predição (incluindo a coluna de intercepto).}
#' \item{preditos}{Os valores preditos calculados pelo modelo.}
#'
#' @examples
#' # Carregando o conjunto de dados do pacote
#' data(rl_dataset)
#'
#' # Ajustando o modelo de regressão linear com o rl_dataset
#' modelo_exemplo <- reg_linear(rl_dataset[, c("Preditora.1", "Preditora.2", "Preditora.3", "Preditora.4")],
#'                              rl_dataset[, c("Resposta.1", "Resposta.2")])
#'
#' # Fazendo predições com novos valores de preditores
#' novos_preditores <- matrix(c(3, 4, 5, 2, 1, 6, 7, 3), nrow = 2, byrow = TRUE)
#' resultado_predicao <- predicao(modelo_exemplo, novos_preditores)
#' resultado_predicao$preditos
#'
#' @export


predicao <- function(modelo, preditores) {
  # Verificar se o modelo é da classe "modelo_linear"
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }

  preditores <- as.matrix(preditores)
  preditores <- cbind(1, preditores)  # Adiciona uma coluna de 1 para o intercepto

  # Verificar se o número de preditores é compatível com os coeficientes do modelo
  if (ncol(preditores) != nrow(modelo$coeficientes)) {
    stop("Erro: o número de preditores não corresponde ao número de coeficientes no modelo.")
  }


  result <- list(
    preditores = preditores,
    preditos = preditores %*% as.matrix(modelo$coeficientes)
  )

  class(result) <- "predicao"
  return(result)
}

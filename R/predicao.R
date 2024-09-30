predicao <- function(modelo, preditores) {
  # Verificar se o modelo é da classe "modelo_linear"
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }
  preditores <- as.matrix(preditores)
  preditores <- cbind(1, preditores)

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

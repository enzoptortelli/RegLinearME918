predicao <- function(modelo, preditores) {
  # testar se modelo e da classe "modelo_linear"

  preditores <- as.matrix(preditores)
  preditores <- cbind(1, preditores)

  result <- list(
    preditores = preditores,
    preditos = preditores %*% as.matrix(modelo$coeficientes)
  )

  class(result) <- "predicao"
  return(result)
}

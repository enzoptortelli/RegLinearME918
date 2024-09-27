#' @title Ajuste de Modelos Lineares
#' @description
#' \code{reg_linear} deve ser usada pra criar modelo de regressão lineares, incluindo multivariados.
#'
#' @param x Variáveis preditores do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matrix pela função \code{as.matrix}.
#' @param y Variáveis respostas do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matrix pela função \code{as.matrix}.
#'
#' @returns \code{reg_linear} retorna uma lista da classe "modelo_linear". Essa lista possui os seguintes dados:
#'\describe{
#'   \item{coeficientes}{os valores estimados dos coeficientes do modelo.}
#'   \item{dados}{os dados utilizados para se criar o modelo.}
#'   \item{residuos}{os resíduos; ou seja, o valor da resposta menos o valor ajustado}
#'   \item{ajustados}{os valores de ajuste do modelo; ou seja, os valores de \code{x} aplicados à função de regressão.}
#' }
#'
#' FALTA EXEMPLO
#'
#'
#' @export
reg_linear <- function(x, y){
  x <- as.matrix(x)
  y <- as.matrix(y)
  # filtrar matriz data.frame ou vetor
  if (!is.numeric(x) || !is.numeric(y)) {
    stop("Erro: a variável preditora (x) e a variável resposta (y) precisam ser variáveis contínuas")
  }

  # Verificar se x e y possuem o mesmo tamanho no banco de dados:
  if (!all(sapply(x, length) != length(y))) {
    stop("Erro: a variável preditora (x) e a variável resposta (y) precisam ter o mesmo número de observações")
  }
  # Criando a matriz X (matriz de delineamento ou matriz de regressão):
  mx <- cbind(1, x)
  # Estimando os coeficientes betas na forma matricial beta_hat = (X'X)^-1 X'Y (%*% é o símbolo de multiplicação matricial):
  # Cálculo de X'X (%*% é o símbolo de multiplicação matricial):
  mxx <- t(mx) %*% mx
  # Cálculo da inversa de X'X: [1/det(mxx)] * matriz adjacente
  inv_mxx <- solve(mxx)
  # Cálculo de X'Y:
  mxy <- t(mx) %*% y
  # Logo, os betas serão:
  betas <- inv_mxx %*% mxy
  # Cálculo dos valores preditos (y_chapéu):
  y_hat <- mx %*% betas
  # Cálculo dos resíduos (e):
  e <- y - y_hat

  rownames(betas)[1] <- 'Intercepto'

  result <- list(coeficientes = betas,
                 residuos = e,
                 ajustados = y_hat,
                 dados = data.frame(y, x)
  )

  class(result) <- "modelo_linear"


  return(result)
}

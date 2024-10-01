#' @title Ajuste de Modelos Lineares
#' @description
#' A função \code{reg_linear} deve ser usada para ajustar modelos de regressão linear, incluindo modelos multivariados.
#'
#' @param x Variáveis preditoras do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matriz pela função \code{as.matrix}.
#' @param y Variáveis respostas do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matriz pela função \code{as.matrix}.
#'
#' @returns \code{reg_linear} retorna uma lista da classe \code{"modelo_linear"} contendo os seguintes componentes:
#' \describe{
#'   \item{coeficientes}{Os valores estimados dos coeficientes do modelo.}
#'   \item{dados}{Os dados utilizados para criar o modelo.}
#'   \item{residuos}{Os resíduos, ou seja, a diferença entre o valor observado da resposta e o valor ajustado pelo modelo.}
#'   \item{ajustados}{Os valores ajustados do modelo; ou seja, os valores preditos de \code{y} com base nos preditores \code{x}.}
#' }
#'
#' @details
#' A função ajusta um modelo de regressão linear com base nos preditores e na variável resposta fornecidos. Ela utiliza a forma matricial da regressão linear para calcular os coeficientes de ajuste.
#'
#' @examples
#' # Carregando o conjunto de dados do pacote
#' data(rl_dataset)
#'
#' # Ajustando um modelo de regressão linear simples
#' modelo_simples <- reg_linear(rl_dataset[, "Preditora.1"], rl_dataset[, "Resposta.1"])
#' modelo_simples$coeficientes
#'
#' # Ajustando um modelo de regressão linear múltipla
#' modelo_multiplo <- reg_linear(rl_dataset[, c("Preditora.1", "Preditora.2", "Preditora.3", "Preditora.4")],
#'                               rl_dataset[, c("Resposta.1", "Resposta.2")])
#' modelo_multiplo$coeficientes
#'
#' # Ajustando um modelo com o dataset iris
#' modelo_iris <- reg_linear(iris[, 1], iris[, 2])
#' modelo_iris$coeficientes
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

  # Atribuindo nomes aos coeficientes (se possível)
  if (!is.null(colnames(x))) {
    rownames(betas) <- c("Intercepto", colnames(x))
  } else {
    rownames(betas) <- c("Intercepto", paste0("X", 1:(ncol(x))))
  }

  result <- list(coeficientes = betas,
                 residuos = e,
                 ajustados = y_hat,
                 dados = data.frame(y, x)
  )

  class(result) <- "modelo_linear"


  return(result)
}





#' Conjunto de dados simulados
#'
#' Este é um conjunto de dados de exemplo incluído no pacote.
#'
#' @format Um data frame com 1000 observações, 3 variáveis preditoras, uma variável resposta.
#' \describe{
#'   \item{Resposta}{Valores gerados da seguinte forma: \code{Resposta = 0.8*Preditora.1 + 3*Preditora.2 + 1.5*Preditora.3 + 3.6 + rnorm(1000,0,1)}}
#'   \item{Preditora.1}{Valores gerados a partir de uma distribuição normal, com média = 3 e desvio-padrão = 1}
#'   \item{Preditora.2}{Valores gerados a partir de uma distribuição poisson, com lambda = 5}
#'   \item{Preditora.3}{Valores gerados a partir de uma distribuição normal, com média = 4 e desvio-padrão = 1}
#' }
#' @source Gerado artificialmente para fins de exemplo no pacote.
"meu_dataset"

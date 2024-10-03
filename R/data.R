#' Conjunto de dados simulados
#'
#' Este é um conjunto de dados de exemplo incluído no pacote, gerado artificialmente para fins ilustrativos.
#'
#' @format Um data frame simulando tempos de inicialização e preços de computadores com 1000 observações, 3 variáveis preditoras e 2 variáveis resposta.
#' \describe{
#'   \item{price ($)}{Valores gerados da seguinte forma: \code{price = 100 * gpu_benchmark + 50 * cpu_benchmark + 50 * ram_qty + 50 + rnorm(1000,0,1)}}
#'   \item{boot_speed (s)}{Valores gerados da seguinte forma: \code{boot_speed = 40 - gpu_benchmark * 0.4 - cpu_benchmark * 0.8- ram_qty * 0.5 + rnorm(1000, 0, 1)}}
#'   \item{cpu_benchmark}{Valores gerados a partir de uma distribuição normal, com média = 18 e desvio-padrão = 4}
#'   \item{gpu_benchmak}{Valores gerados a partir de uma distribuição normal, com média = 18 e desvio-padrão = 4}
#'   \item{ram_qty}{Valores gerados a partir de uma distribuição uniforme discreta, com possíveis valores = (4,6,8,12,16)}
#' }
#' @source Gerado artificialmente para fins de exemplo no pacote.
"rl_dataset"

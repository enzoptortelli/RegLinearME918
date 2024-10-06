#' @title Função de Predição para Modelos Lineares
#' @description
#' A função \code{predicao} realiza predições a partir de um modelo de regressão linear da classe \code{modelo_linear}.
#' A função pode ser aplicada tanto em modelos de regressão simples quanto multivariada. No caso multivariado, os intervalos resultantes têm nível de confiança simultâneo \eqn{(1 - \alpha)}.
#'
#' @param modelo Um modelo de regressão linear da classe \code{modelo_linear}.
#' @param preditores Uma matriz, data frame ou vetor contendo os valores a serem preditos.
#' @param alpha Um valor entre 0 e 1 para indicar o nível de confiança desejado nos intervalos (seja ele o de confiança ou de predição).
#' @param tipo Uma string indicando o tipo de predição. Os valores possíves são \code{"pontual"}, \code{"confianca"} e \code{"predicao"}.
#'
#' @return Retorna uma lista contendo a predição desejada e o preditor associado.
#'
#' @examples
#' # Carregando o conjunto de dados do pacote
#' data(rl_dataset)
#'
#' # Ajustando o modelo de regressão linear com o rl_dataset
#' modelo_exemplo <- reg_linear(rl_dataset[, 3:5], rl_dataset[, 1:2])
#'
#' # Fazendo predições com novos valores de preditores
#' novos_preditores <- rl_dataset[1:3, 3:5]
#' resultado_predicao <- predicao(modelo_exemplo, novos_preditores, tipo = 'confianca')
#' resultado_predicao
#'
#' @export


predicao <- function(modelo, preditores, alpha = 0.05, tipo = 'pontual') {
  # Verificar se o modelo é da classe "modelo_linear"
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }

  if(is.vector(preditores)) {
    preditores <- matrix(preditores, nrow = 1)
  } else if(!is.matrix(preditores)) {
    preditores <- as.matrix(preditores)
  }

  if(!(tipo %in% c('pontual', 'confianca', 'predicao'))) {
    stop('Erro: o valor do parâmetro tipo não é suportado.')
  }

  # Verificar se o número de preditores é compatível com os coeficientes do modelo
  if (ncol(preditores) != (nrow(modelo$coeficientes) - 1)) {
    stop("Erro: o número de preditores não corresponde ao número de coeficientes no modelo.")
  }

  coeficientes <- as.matrix(modelo$coeficientes)


  preditores <- cbind(1, preditores)  # Adiciona uma coluna de 1 para o intercepto

  if(tipo == 'pontual') {
    result <- apply(preditores, MARGIN = 1, function(preditor) {
      list(
        'preditor' = preditor[-1],
        preditores %*% coeficientes
      )
    })
    names(result) <- sapply(1:nrow(preditores), function(i) {
      return(paste('predicao_', i, sep = ''))
    })
    return(result)
  }

  result <- apply(preditores, MARGIN = 1, simplify = FALSE, function(preditor) {
    preditor <- matrix(preditor, ncol = 1)

    m <- ncol(modelo$coeficientes) # número de var. respostas
    r <- nrow(modelo$coeficientes) - 1 # número de var. preditoras
    n <- nrow(modelo$dados) # número de obs.
    Z <- as.matrix(modelo$dados[, -(1:m)]) # variáveis preditoras
    Z <- cbind(1, Z)
    sigma_chapeu <- t(modelo$residuos) %*% modelo$residuos/(n-r-1)
    intervalos <- list()

    ys_chapeu <- t(preditor) %*% coeficientes

    if(tipo == 'confianca') {
      for(i in 1:m) {
        limite <- sqrt(
          ((m*(n-r-1))/(n-r-m)) * qf(1 - alpha, m, n-r-m)
        ) *
          sqrt(
            (t(preditor) %*% solve(t(Z) %*% Z) %*% preditor) * ((n/(n-r-1)) * sigma_chapeu[i, i])
          )
        intervalos <- append(intervalos, list(c('pontual' = ys_chapeu[i], 'li' = ys_chapeu[i] - limite, 'ls' = ys_chapeu[i] + limite)))
      }
    } else if (tipo == 'predicao') {
      for(i in 1:m) {
        limite <- sqrt(
          ((m*(n-r-1))/(n-r-m)) * qf(1 - alpha, m, n-r-m)
        ) *
          sqrt(
            (1 + (t(preditor) %*% solve(t(Z) %*% Z) %*% preditor)) * ((n/(n-r-1)) * sigma_chapeu[i, i])
          )
        intervalos <- append(intervalos, list(c('pontual' = ys_chapeu[i], 'li' = ys_chapeu[i] - limite, 'ls' = ys_chapeu[i] + limite)))
      }
    }

    names(intervalos) <- colnames(modelo$coeficientes)
    intervalos <- append(intervalos, list('preditor' = as.vector(preditor)[-1]))

    return(intervalos)

  })
  names(result) <- sapply(1:nrow(preditores), function(i) {
    return(paste('predicao_', i, sep = ''))
  })

  return(result)
}


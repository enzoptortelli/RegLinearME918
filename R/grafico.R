#' @title Gráficos de verificação do modelo linear
#' @description
#' A função \code{grafico} é utilizada para criação de gráficos para verificação do modelo linear resultante. Válida tanto para regressão linear simples quanto para regressão linear multivariada. Ela permite visualizar o ajuste do modelo e verificar os pressupostos dos resíduos.
#'
#' @param modelo Modelo de regressão linear. Deve ser, obrigatoriamente, da classe \code{"modelo_linear"}. Caso contrário, a função gerará um erro.
#' @param tipo Vetor do tipo \code{char} que especifica os tipos de gráficos desejados. Os valores aceitos são:
#' \describe{
#'   \item{pvo}{Gráfico de valores preditos x valores observados.}
#'   \item{rvp}{Gráfico de resíduos x preditora.}
#'   \item{qqplot}{QQ-plot dos resíduos.}
#' }
#'
#' @examples
#' # Carregando o conjunto de dados do pacote
#' data(rl_dataset)
#'
#' # Ajustando o modelo de regressão linear com o rl_dataset
#' modelo_exemplo <- reg_linear(rl_dataset[, c("Preditora.1", "Preditora.2", "Preditora.3", "Preditora.4")],
#'                              rl_dataset[, c("Resposta.1", "Resposta.2")])
#'
#' # Gerando gráficos de verificação do modelo ajustado
#' # Gráfico de Valores Preditos x Observados
#' grafico(modelo_exemplo, tipo = "pvo")
#'
#' # Gráfico de Resíduos x Preditoras
#' grafico(modelo_exemplo, tipo = "rvp")
#'
#' # QQ-plot dos Resíduos
#' grafico(modelo_exemplo, tipo = "qqplot")
#'
#' @import ggplot aes theme_classic tidyeval labs geom_point geom_hline geom_qq geom_qq_line
#' @export

grafico <- function(modelo, tipo = c('pvo', 'rvp', 'qqplot')) {
  # verificar se a classe do modelo inserido pelo usuário é "modelo_linear":
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }

  result <- list()
  pvo_list <- list()
  rvp_list <- list()
  qq_list <- list()

  var_respostas <- colnames(modelo$coeficientes)
  var_preditoras <- rownames(modelo$coeficientes)[-1]


  getPlot <- function(dados, x, y) {
    return(ggplot(dados, aes(x = .data[[x]], y = .data[[y]])) +
             theme_classic())
  }

  # Gráfico de Valores Preditos vs Observados (pvo)
  if("pvo" %in% tipo) {
    for(var_resposta in var_respostas) {
      temp_dado <- data.frame(modelo$ajustados[, var_resposta], modelo$dados[, var_resposta])
      temp_colnames <-c(paste(var_resposta, "ajustado", sep = '_'),
                        paste(var_resposta, "observado", sep = '_'))

      colnames(temp_dado) <- temp_colnames

      grafico <- getPlot(temp_dado, x = temp_colnames[2], y = temp_colnames[1]) +
        geom_point() +
        labs(
          title = paste('Valores preditos x observados (', var_resposta, ')'),
          x = 'Observados',
          y = 'Preditos'
        )

      pvo_list <- append(pvo_list,  list(grafico))
    }
    names(pvo_list) <- var_respostas
  }

  # Gráfico de Resíduos vs Preditoras (rvp)
  if('rvp' %in% tipo) {
    temp_nomes_list <- c()
    for(var_preditora in var_preditoras) {
      for(var_resposta in var_respostas) {
        temp_dado <- data.frame(modelo$residuos[, var_resposta], modelo$dados[, var_preditora])
        temp_colnames <-c('residuos',
                          paste(var_resposta, "observado", sep = '_'))
        colnames(temp_dado) <- temp_colnames

        grafico <- getPlot(temp_dado, y = temp_colnames[1], x = temp_colnames[2]) +
          geom_point() +
          geom_hline(yintercept = 0, color = 'red') +
          labs(
            title = paste('Resíduos (', var_resposta, ') x  preditora (', var_preditora, ')'),
            y = 'Resíduos',
            x = 'Preditora'
          )
        rvp_list <- append(rvp_list, list(grafico))
        temp_nomes_list <- c(paste(var_resposta, var_preditora, sep = '_'), temp_nomes_list)

      }
    }
    names(rvp_list) <- temp_nomes_list
  }

  # QQ-plot dos resíduos
  if('qqplot' %in% tipo) {
    for(var_resposta in var_respostas) {
      temp_dado <- data.frame(modelo$residuos[, var_resposta])
      colnames(temp_dado) <- var_resposta

      grafico <- ggplot(temp_dado, aes(sample = .data[[var_resposta]])) +
        geom_qq() +
        geom_qq_line() +
        labs(title = paste('QQ-plot resíduos de', var_resposta),
             x = 'Quantil teórico',
             y = 'Quantil amostral'
        ) +
        theme_classic()

      qq_list <- append(qq_list, list(grafico))
    }
    names(qq_list) <- var_respostas
  }


  result <- list('pvo' = pvo_list,
                 'rvp' = rvp_list,
                 'qqplot' = qq_list)
  return(result)
}





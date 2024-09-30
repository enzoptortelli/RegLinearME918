grafico <- function(modelo, tipo) {
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

  # Gráfico de Resíduos vs Ordem de coleta (rvo)

  # if('rvo' %in% tipo) {
  #   temp_dado <- as.data.frame(modelo$residuos)
  #   grafico <- ggplot(data = temp_dado, aes(y = V1, x = 1:length(modelo$residuos))) +
  #     geom_point() +
  #     labs(
  #       title = 'Resíduos x Ordem dos dados',
  #       y = 'Resíduos',
  #       x = 'Ordem dos dados'
  #     )
  # }



  # Qualquer outro tipo
  # else {
  #   stop("Erro: tipo de gráfico inválido. Use 'pvo' para preditos vs observados ou 'rvo' para resíduos vs ordem de coleta.")
  # }

  result <- list('pvo' = pvo_list,
                 'rvp' = rvp_list,
                 'qqplot' = qq_list)
  return(result)
}

grafico(reg_linear(iris[, c(1, 3)], iris[, c(2, 4)]), tipo = c('pvo', 'rvp', 'qqplot'))

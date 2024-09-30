grafico <- function(modelo, tipo) {
  # verificar se a classe do modelo inserido pelo usuário é "modelo_linear":
  if (!"modelo_linear" %in% class(modelo)) {
    stop("Erro: o objeto fornecido não é um modelo linear válido.")
  }

  result <- list()
  pvo_list <- list()
  rvp_list <- list()

  var_respostas <- colnames(modelo$coeficientes)
  var_preditoras <- rownames(modelo$coeficientes)[-1]

  salvar_plot <- function(dados, nome_var) {
    ggplot(dados, aes())
  }


  # Gráfico de Valores Preditos vs Observados (pvo)
  if("pvo" %in% tipo) {
    for(var_resposta in var_respostas) {
      temp_dado <- as.data.frame(cbind(modelo$ajustados[, var_resposta], modelo$dados[, var_resposta]))
      grafico <- ggplot(data = temp_dado,
                        aes(x = temp_dado[, 2], y = temp_dado[, 1])) +
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
    for(var_preditora in var_preditoras) {
      temp_dado <- as.data.frame(cbind(modelo$residuos, modelo$dados[, var_preditora]))
      grafico <- ggplot(data = temp_dado,
                        aes(x = temp_dado[, 2], y = temp_dado[, 1])) +
        geom_point() +
        labs(
          title = paste('Resíduos x preditora (', var_preditora, ')'),
          x = 'Resíduos',
          y = 'Preditora'
        )

      rvp_list <- append(rvp_list, list(grafico))

    }
    names(rvp_list) <- var_preditoras
  }

  # Gráfico de Resíduos vs Ordem de coleta (rvo)
  if('rvo' %in% tipo) {
    temp_dado <- as.data.frame(modelo$residuos)
    grafico <- ggplot(data = temp_dado, aes(y = V1, x = 1:length(modelo$residuos))) +
      geom_point() +
      labs(
        title = 'Resíduos x Ordem dos dados',
        y = 'Resíduos',
        x = 'Ordem dos dados'
      )
    rvo_list <- append(rvo_list, list(grafico_rvo))
  }
  # Qualquer outro tipo
  # else {
  #   stop("Erro: tipo de gráfico inválido. Use 'pvo' para preditos vs observados ou 'rvo' para resíduos vs ordem de coleta.")
  # }

  result <- list('pvo' = pvo_list,
                 'rvp' = rvp_list,
                 'rvo' = rvo_list)
  return(result)
}

#Coloquei as funções que estavam em regressão.linear.R em arquivos separados, e comecei a fazer a documentação da função reg_linear.

summary(modelolara)
grafico(modelolara, tipo = "pvo")


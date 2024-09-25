grafico <- function(modelo, tipo) {
  # verificar classe do modelo

  # predito vs observado (pvo)
  # residuos vs ordem (rvo)
  # ...
  if(tipo == "pvo") {
    result <- plot(modelo$dados[, 1], modelo$ajustados)
  }
  else if(tipo == "rvo") {
    result <- plot(modelo$residuos)
  }

  return(result)
}

#Coloquei as funções que estavam em regressão.linear.R em arquivos separados, e comecei a fazer a documentação da função reg_linear.

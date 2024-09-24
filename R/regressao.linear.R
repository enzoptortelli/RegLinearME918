################################################################
# Modelo de regressao linear simples, sem usar função lm:
################################################################

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
  
  result <- list(coeficientes = betas,
                 residuos = e,
                 fitted = y_hat,
                 dados = data.frame(y, x)
                 
  )
  
  class(result) <- "modelo_linear"
  
  
  return(result)
}


str(iris)
modelo <- reg_linear(c(iris$Petal.Length, iris$Petal.Width), iris$Sepal.Width)
modelo

#Conferindo os betas:

lm(iris$Petal.Width ~ iris$Petal.Length)


##############################################################################
# Predições: ABANDONAR ESTE (POR ENQUANTO)
##############################################################################


#predicao1 <- function(modelo, novos_x, nivel_confianca = 0.95){
  y <- modelo$dados[, 1]
  x <- modelo$dados[, -1]
  
  # Verificando se os novos dados estão fora da amplitude de X:
  xmin <- min(x)
  xmax <- max(x)
  if (any(novos_x < xmin | novos_x > xmax)) {
   stop("Erro: os novos valores estão fora da amplitude dos dados")
   }
  
  #Criando um novo df:
  df_pred <- data.frame(novo.x = numeric(0), estimativa.pontual = numeric(0), intervalo.inf = numeric(0), intervalo.sup = numeric(0))
  
  # Loop sobre os valores de novos_x
  for (valor in novos_x) {
    provisorio <- data.frame(novo.x = valor)
    if (valor %in% x) {
      #Estimando a resposta média e IC para os valores comuns:
      provisorio$estimativa.pontual <- valor * (modelo$betas)
      intervalo1 <- predict(modelo, valor, interval = "confidence", level = nivel_confianca)
      #Intervalos:
      provisorio$intervalo.inf <- intervalo1[1,"lwr"]
      provisorio$intervalo.sup <- intervalo1[1,"upr"]
    } else {
      # Prevendo uma nova observação (se os novos dados não aparecem na amostra, mas estão dentro da amplitude):
      provisorio$estimativa.pontual <- valor * (modelo$betas)
      intervalo2 <- predict(modelo, valor, interval = "prediction", level = nivel_confianca)
      provisorio$intervalo.inf <- intervalo2[1,"lwr"]
      provisorio$intervalo.sup <- intervalo2[1,"upr"]
    }
    
    
    df_pred <- rbind(df_pred, provisorio)
  }
  
  return(df_pred)
}




##### Função Predição ############################
##################################################
predicao <- function(modelo, preditores) {
  # testas se modelo e da classe "modelo_linear""
  
  preditores <- as.matrix(preditores)
  preditores <- cbind(1, preditores)
  
  result <- list(
      preditores = preditores,
      preditos = preditores %*% as.matrix(modelo$coeficientes)
    )
    
    class(result) <- "predicao"
    return(result)
}



################################ Gráfico ##########
######################################################

grafico <- function(modelo, tipo) {
  # verificar classe do modelo
  
  # predito vs observado (pvo)
  # residuos vs ordem (rvo)
  # ...
  if(tipo == "pvo") {
    result <- plot(modelo$dados[, 1], modelo$fitted)
  }
  else if(tipo == "rvo") {
    result <- plot(modelo$residuos)
  }
  
  return(result)
}



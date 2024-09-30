############################################################
# Testes unitários para a função reg_linear()
############################################################
# O que acontece se uma coluna de X (além do intercept) é constante?
# Criando um novo conjunto de dados, apenas para teste:
library(testthat)

test_that("A função reg_linear() lida com colunas constantes", {
  x.1 <- rep(2, 150)  # Coluna constante
  x.2 <- iris[, 2]
  x.3 <- iris[, 3]
  y.resposta <- x.1 + 3 * x.2 + 2 * x.3
  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2, "Preditora.3" = x.3)
  expect_error(reg_linear(df.teste[, 2:4], df.teste[, 1]))
})


test_that("A função reg_linear() lida com matrizes de posto incompleto", {
  # Criar uma matriz com colinearidade
  x.1 <- iris[, 2]
  x.2 <- iris[, 2] * 5  # Multiplo perfeito de x.1
  y.resposta <- 3 * x.1 + 2 * iris[, 3]

  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2)
  expect_error(reg_linear(df.teste[, 2:3], df.teste[, 1]))

})

test_that("A função reg_linear() lida com ajustes perfeitos", {
  # Criar um modelo onde Y é perfeitamente descrito por X
  x.1 <- iris[, 2]
  x.2 <- iris[, 3]
  y.resposta <- 3 * x.1 + 2 * x.2

  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2)

  modelo.teste <- reg_linear(df.teste[, 2:3], df.teste[, 1])

  expect_true(all(abs(modelo.teste$residuos) < 1e-10))
})


# Testes para garantir que não são usadas strings
test_that("Não é string", {
  df <- data.frame(x1 = c(1, 2, 3), x2 = c(4, 5, 6), y = c(7, 8, 9))
  expect_error(reg_linear(df[, c("x1", "x2")], "y"))
  expect_error(reg_linear("df", df$y))
})

# Testes para garantir que os vetores de predições e resíduos tenham o mesmo comprimento
test_that("Vetores de mesmo comprimento", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  expect_length(modelo$residuos, length(modelo$ajustados))
})

# Teste para garantir que a função retorna uma lista

test_that("Retorna uma lista", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  expect_type(reg_linear(df[, c("x1", "x2")], df$y), "list")
})

# Teste para garantir que o resultado da predição seja uma lista
test_that("Predição retorna uma lista", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(7, 6), nrow = 1, byrow = TRUE)
  expect_type(predicts(modelo, valores), "list")
})

#Teste para garantir que um erro seja lançado quando houver valores incompletos em predições
test_that("Valores incompletos na predição", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(1, 5, 2), nrow = 3, byrow = TRUE)  # Dimensões erradas
  expect_error(predicts(modelo, valores), "Número incorreto de preditores")
})

# Teste para garantir que a predição retorne o número correto de valores
test_that("Predição completa", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), x3 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2", "x3")], df$y)
  valores <- matrix(c(1, 5, 2, 6, 3, 7, 4, 9, 8), nrow = 3, byrow = TRUE)
  expect_length(predicts(modelo, valores)$preditos, nrow(valores))
})




############################################################
#Testes unitários para a função grafico()
############################################################

# Verificação de que os gráficos são realmente gerados (verificando tipo de objeto gráfico)
test_that("A função grafico() gera gráficos do tipo correto", {
  modelo <- reg_linear(iris[, 1:2], iris[, 3])

  # Gráfico predito vs observado (pvo)
  grafico_pvo <- grafico(modelo, "pvo")
  expect_silent(grafico_pvo)
  expect_s3_class(grafico_pvo, "ggplot")  # Ou "plot" dependendo do tipo de gráfico

  # Gráfico resíduos vs ordem (rvo)
  grafico_rvo <- grafico(modelo, "rvo")
  expect_silent(grafico_rvo)
  expect_s3_class(grafico_rvo, "ggplot")  # Ou "plot" dependendo do tipo de gráfico
})

# Verificação do comportamento com um gráfico inválido
test_that("A função grafico() lança erro para tipo de gráfico inválido", {
  modelo <- reg_linear(iris[, 1:2], iris[, 3])
  expect_error(grafico(modelo, "invalido"), "tipo de gráfico inválido")
})



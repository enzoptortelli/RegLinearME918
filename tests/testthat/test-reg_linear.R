# Teste 1: Verifica se os coeficientes do modelo estão corretos para uma regressão linear simples
test_that("Teste 1 reg_linear()", {
  set.seed(1234567)
  x1 <- rnorm(100)
  x2 <- rnorm(100)
  y <- 3 * x1 + 2 * x2 + rnorm(100)
  modelo <- reg_linear(cbind(x1, x2), y)
  expect_equal(modelo$coeficientes[1:3], c(0.06225996, 3.12601472, 2.23795002))
})

# Teste 2: Verifica se os coeficientes estão corretos para um modelo multivariado
test_that("Teste 2 reg_linear()", {
  x_1 <- iris[, 1]
  x_2 <- iris[, 2]
  x_3 <- iris[, 3]
  y_1 <- 1.5 * x_1 - 0.8 * x_3 + 2.1 * x_2
  y_2 <- -0.8 * x_1 + 1.7 * x_2 + 0.2 * x_3
  df.teste <- data.frame("Resposta 1" = y_1, "Resposta 2" = y_2, "Preditora 1" = x_1, "Preditora 2" = x_2, "Preditora 3" = x_3)
  modelo <- reg_linear(df.teste[, 3:5], df.teste[, 1:2])
  coeficientes <- unname(c(modelo$coeficientes[, 1], modelo$coeficientes[, 2]))
  expect_equal(coeficientes, c(-1.307399e-12, 1.500000e+00, 2.100000e+00, -8.000000e-01, 0, -0.8, 1.7, 0.2))
})

# Teste 3: Verifica se a função lida corretamente com colunas constantes
test_that("Teste 3 reg_linear()", {
  x.1 <- rep(2, 150)  # Coluna constante
  x.2 <- iris[, 2]
  x.3 <- iris[, 3]
  y.resposta <- x.1 + 3 * x.2 + 2 * x.3
  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2, "Preditora.3" = x.3)
  expect_error(reg_linear(df.teste[, 2:4], df.teste[, 1]))
})

# Teste 4: Verifica se a função lida corretamente com matrizes de posto incompleto
test_that("Teste 4 reg_linear()", {
  x.1 <- iris[, 2]
  x.2 <- iris[, 2] * 2  # Múltiplo perfeito de x.1
  y.resposta <- 3 * x.1 + 2 * iris[, 3]
  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2)
  expect_error(reg_linear(df.teste[, 2:3], df.teste[, 1]))
})

# Teste 5: Verifica se a função lida corretamente com ajustes perfeitos
test_that("Teste 5 reg_linear()", {
  x.1 <- iris[, 2]
  x.2 <- iris[, 3]
  y.resposta <- 3 * x.1 + 2 * x.2
  df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2)
  modelo.teste <- reg_linear(df.teste[, 2:3], df.teste[, 1])
  expect_true(all(abs(modelo.teste$residuos) < 1e-10))
})

# Teste 6: Garante que a função não aceita strings como entrada
test_that("Teste 6 reg_linear()", {
  df <- data.frame(x1 = c(1, 2, 3), x2 = c(4, 5, 6), y = c(7, 8, 9))
  expect_error(reg_linear(df[, c("x1", "x2")], "y"))
  expect_error(reg_linear("df", df$y))
})

# Teste 7: Verifica se os vetores de predições e resíduos têm o mesmo comprimento
test_that("Teste 7 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  expect_equal(length(modelo$residuos), length(modelo$fitted))
})

# Teste 8: Verifica se a função retorna uma lista
test_that("Teste 8 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  expect_type(reg_linear(df[, c("x1", "x2")], df$y), "list")
})

# Teste 9: Verifica se a predição retorna uma lista
test_that("Teste 9 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(7, 6), nrow = 1, byrow = TRUE)
  expect_type(predicao(modelo, valores), "list")
})

# Teste 10: Verificar erro com número incorreto de preditores
test_that("Teste 10 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(5), nrow = 1, byrow = TRUE)  # Apenas 1 preditor
  expect_error(predicao(modelo, valores), "Erro: o número de preditores não corresponde ao número de coeficientes no modelo.")
})


# Teste 11: Verifica se a predição retorna o número correto de valores
test_that("Teste 11 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), x3 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2", "x3")], df$y)
  valores <- matrix(c(1, 5, 2, 6, 3, 7, 4, 9, 8), nrow = 3, byrow = TRUE)
  expect_length(predicao(modelo, valores)$preditos, nrow(valores))
})

# Teste 12: Verifica se a função lida com valores faltantes (NA)
test_that("Teste 12 reg_linear()", {
  df <- data.frame(x1 = c(1, 2, NA, 4), x2 = c(2, 4, 5, 6), y = c(5, NA, 7, 9))
  expect_error(reg_linear(df[, c("x1", "x2")], df$y), regexp = "contêm valores NA")
})


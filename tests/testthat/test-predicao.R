set.seed(1234567)

# Teste 1: Verifica se a predição retorna uma lista
test_that("Teste 9 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(7, 6), nrow = 1, byrow = TRUE)
  expect_type(predicao(modelo, valores), "list")
})


# Teste 2: Verifica se a predição retorna o número correto de valores
test_that("Teste 11 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), x3 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2", "x3")], df$y)
  valores <- matrix(c(1, 5, 2, 6, 3, 7, 4, 9, 8), nrow = 3, byrow = TRUE)
  expect_length(predicao(modelo, valores)$preditos, nrow(valores))
})

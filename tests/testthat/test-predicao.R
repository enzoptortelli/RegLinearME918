set.seed(1234567)

# Teste 1: Verifica se a predição retorna uma lista
test_that("Teste 9 reg_linear()", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100), y = rnorm(100))
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix(c(7, 6), nrow = 1, byrow = TRUE)
  expect_type(predicao(modelo, valores), "list")
})


# Teste 2: teste exato para verificar se o valor obtido é igual ao esperado.
test_that("Teste predicao()", {
  set.seed(1234567)
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  df$y <- df$x1 + df$x2*2 + rnorm(100)
  modelo <- reg_linear(df[, c("x1", "x2")], df$y)
  valores <- matrix (c(7,6), nrow = 1, byrow = TRUE)
  expect_equal(predicao(modelo, valores)$predicao_1[[2]][[1]], 21.372063)
})

# Teste 3: verifica se tenta predizer uma resposta a partir de variáveis não-numéricas.
test_that("Teste string", {
  df <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
  df$y <- df$x1 + df$x2*2 + rnorm(100)
  modelo <- reg_linear(df[, c("x1","x2")], df$y)
  expect_error(predicao(modelo,c("string1","string2")))
})


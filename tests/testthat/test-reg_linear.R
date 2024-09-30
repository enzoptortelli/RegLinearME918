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
  x.2 <- iris[, 2] * 2  # Multiplo perfeito de x.1
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



test_that("Teste 1 reg_linear()",{
  set.seed(1234567)
  x1 <- rnorm(100)
  x2 <- rnorm(100)
  y <- 3 * x1 + 2 * x2 + rnorm(100)
  modelo <- reg_linear(cbind(x1, x2), y)

  expect_equal(modelo$coeficientes[,1],c(0.06225996,3.12601472,2.23795002))
})

test_that("Teste 2 reg_linear()",{
  x_1 <- iris[,1]
  x_2 <- iris[,2]
  x_3 <- iris[,3]
  y_1 <- 1.5*x_1 - 0.8*x_3 + 2.1*x_2
  y_2 <- -0.8*x_1 + 1.7*x_2 + 0.2*x_3
  df.teste <- data.frame("Resposta 1" = y_1, "Resposta 2" = y_2, "Preditora 1" = x_1, "Preditora 2" = x_2, "Preditora 3" = x_3)
  modelo <- reg_linear(df.teste[,3:5],df.teste[,1:2])
  coeficientes <- unname(c(modelo$coeficientes[,1],modelo$coeficientes[,2]))
  expect_equal(coeficientes,c(-1.307399e-12,1.500000e+00,2.100000e+00,-8.000000e-01 ,0,-0.8,1.7,0.2 ))
})

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


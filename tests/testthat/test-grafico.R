set.seed(1234567)

c1 <- rnorm(100)
c2 <- rnorm(100)
c3 <- 5*c1 - 4*c2 + rnorm(100)
c4 <- -c1 + 2*c2 + rnorm(100)

modelo <- reg_linear(x = cbind(c1, c2), y = cbind(c3, c4))
graficos <- grafico(modelo)

test_that("Retorna uma lista", {
  expect_type(graficos, "list")
})

test_that("Retorna os gráficos esperados", {
  expect_length(graficos$pvo, 2)
  expect_length(graficos$rvp, 4)
  expect_length(graficos$qqplot, 2)
})


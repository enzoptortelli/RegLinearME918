mod_linear <- reg_linear(iris[, c(1, 3)], iris[, c(2, 4)])
grafico_resultado <- grafico(mod_linear)

test_that("retorna os gráficos esperados", {
  expect_length(grafico_resultado$pvo, 2)
  expect_length(grafico_resultado$rvp, 4)
  expect_length(graf_resultado$qqplot, 2)
})

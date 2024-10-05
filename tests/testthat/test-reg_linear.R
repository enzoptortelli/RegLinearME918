set.seed(1234567)

c1 <- rnorm(100)
c2 <- rnorm(100)
c3 <- 5*c1 - 4*c2 + rnorm(100)
c4 <- -c1 + 2*c2 + rnorm(100)

modelo <- reg_linear(x = cbind(c1, c2), y = cbind(c3, c4))

# Teste 2: Verifica se os coeficientes estão corretos para o modelo
test_that("Teste 2 reg_linear()", {
  coeficientes <- unname(c(modelo$coeficientes[, 1], modelo$coeficientes[, 2]))
  expect_equal(coeficientes, c(0.06225996, 5.12601472, -3.76204998, 0.02562696, -1.00216792, 2.01136900))
})

# Teste 3: Verifica se a função gera erro com coluna constante como preditora
test_that("Teste 3 reg_linear()", {
  col_constante <- rep(5, 100)
  expect_error(reg_linear(x = cbind(c1, c2, col_constante), y = cbind(c3, c4)))
})

# Teste 4: Verifica se a função gera erro com matrizes de posto incompleto
test_that("Teste 4 reg_linear()", {
  expect_error(reg_linear(x = cbind(c1, 2*c1), y = cbind(c3, c4)))
})

# Teste 5: Verifica se a função lida corretamente com ajustes perfeitos
test_that("Teste 5 reg_linear()", {
  expect_true(all(abs(reg_linear(x = cbind(c1, c2), y = cbind(c1+c2))$residuos) < 1e-10))
})

# Teste 6: Garante que a função não aceita strings como entrada
test_that("Teste 6 reg_linear()", {
  expect_error(reg_linear(x = cbind(c1, c2), y = rep('this should not be here', 100)))
  expect_error(reg_linear(x = rep('this should not be here', 100), y = cbind(c3, c4)))
})

# Teste 7: Verifica se os vetores de predições e resíduos têm o mesmo comprimento
test_that("Teste 7 reg_linear()", {
  expect_equal(length(modelo$residuos), length(modelo$ajustados))
})

# Teste 8: Verifica se a função retorna uma lista
test_that("Teste 8 reg_linear()", {
  expect_type(modelo, "list")
})

# Teste 9: Verifica se a função retorna um objeto da classe 'modelo_linear'
test_that("Teste 9 reg_linear()", {
  expect_contains(class(modelo), 'modelo_linear')
})

# Teste 10: Verifica se a função lida com valores faltantes (NA)
test_that("Teste 12 reg_linear()", {
  c1[5] <- NA
  expect_error(reg_linear(x = cbind(c1, c2), y = cbind(c3, c4)))
  expect_error(reg_linear(x = cbind(c2, c3), y = cbind(c1, c4)))
})


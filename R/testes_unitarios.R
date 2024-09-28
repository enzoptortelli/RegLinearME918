############################################################
# Testes unitários para a função reg_linear()
############################################################
# O que acontece se uma coluna de X (além do intercept) é constante?
# Criando um novo conjunto de dados, apenas para teste:
x.1 <- rep(2, 150) 
x.2 <- iris[,2]
x.3 <- iris[,3]
y.resposta <- x.1 + 3*x.2 + 2*x.3
df.teste <- data.frame("Resposta" = y.resposta, "Preditora.1" = x.1, "Preditora.2" = x.2, "Preditora.3" = x.3)
df.teste

modelo.teste <- reg_linear(df.teste[,2:4], df.teste[,1]) #NAO RODOU!!!!: SERIA DEVIDO A COLUNA X.1 SER CONSTANTE?

testthat::test_that("A função reg_linear() funciona", {
  expect_equal()
})





#O que acontece se a matriz não tem posto completo?

#O que acontece quando o vetor Y pode ser descrito perfeitamente como Xβ para algum β? (Resíduos todos iguais a zero).



############################################################
#Testes unitários para a função grafico()
############################################################




iris

x_1 = rnorm(1000, 3, 1)
x_2 = rpois(1000, 5)
x_3 = rnorm(1000, 4, 1)

Y = 0.8*x_1 + 3*x_2 + 1.5*x_3 + 3.6 + rnorm(1000,0,1)

meu_dataset = data.frame("Resposta" = Y, "Preditora 1" = x_1, "Preditora 2" = x_2, "Preditora 3" = x_3)
meu_dataset


# Adicionar os dados no pacote
usethis::use_data(meu_dataset)

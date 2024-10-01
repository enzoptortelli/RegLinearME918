# Gerando os dados conforme especificado
x_1 <- rnorm(1000, 3, 1)
x_2 <- rpois(1000, 5)
x_3 <- rnorm(1000, 4, 1)
x_4 <- rbinom(1000, 100, 0.37)

Y_1 <- 0.8 * x_1 + 3 * x_2 + 1.5 * x_3 + 0.3 * x_4 + 3.6 + rnorm(1000, 0, 1)
Y_2 <- 1 * x_2 - 3.1 * x_1 + 0.4 * x_3 - 0.9 * x_4 + 2 + rnorm(1000, 0, 1)

# Criando o data frame
rl_dataset <- data.frame(
  "Resposta 1" = Y_1,
  "Resposta 2" = Y_2,
  "Preditora 1" = x_1,
  "Preditora 2" = x_2,
  "Preditora 3" = x_3,
  "Preditora 4" = x_4
)

# Adicionando os dados ao pacote
usethis::use_data(rl_dataset, overwrite = TRUE)

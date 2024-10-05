set.seed(42)

# Gerando os dados conforme especificado
ram_qty = sample(c(4,6,8,12,16),1000, replace = TRUE)
cpu_benchmark = rnorm(1000, 18, 4)
gpu_benchmark = rnorm(1000, 18, 4)

price = gpu_benchmark*100 + cpu_benchmark*50 + ram_qty*50 + 50 + rnorm(1000, 0, 1)
boot_speed = 40 - gpu_benchmark*0.4 - cpu_benchmark*0.8-ram_qty*0.5 + rnorm(1000, 0, 1)

# Criando o data frame
rl_dataset <- data.frame(
  "price" = price,
  "boot_speed" = boot_speed,
  gpu_benchmark,
  cpu_benchmark,
  ram_qty)

# Adicionando os dados ao pacote
usethis::use_data(rl_dataset, overwrite = TRUE)


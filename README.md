# Pacote de Regressão Linear

Este pacote foi desenvolvido para fornecer ferramentas para ajuste de modelos de regressão linear e predições a partir desses modelos. Ele é útil para realizar análises de regressão linear simples e múltipla de forma rápida e eficiente.

## Instalação

Você pode instalar o pacote diretamente a partir do GitHub usando o seguinte comando no R:

```r
# Primeiro, instale o pacote 'devtools' caso ainda não tenha:
# install.packages("devtools")

# Depois, instale o pacote diretamente do GitHub:
devtools::install_github("")
```

## Exemplo de Uso
Aqui está um exemplo simples de como usar o pacote para ajustar um modelo de regressão linear e fazer predições:
```r
# Carregando o pacote
library(pacote_regressao_linear)

# Gerando dados simulados
x1 <- rnorm(100)
x2 <- rnorm(100)
y <- 3 * x1 + 2 * x2 + rnorm(100)

# Ajustando o modelo de regressão linear
modelo <- reg_linear(cbind(x1, x2), y)

# Exibindo os coeficientes do modelo
print(modelo$coeficientes)

# Fazendo predições com novos valores de preditores
novos_preditores <- matrix(c(1, 5, 2, 6, 3, 7), nrow = 3, byrow = TRUE)
predicoes <- predicao(modelo, novos_preditores)

# Exibindo os valores preditos
print(predicoes$preditos)
```

## Visualizando Gráficos
Você também pode visualizar gráficos, como por exemplo a relação entre uma variável preditora e a variável resposta:
```r
plot(x1, y, main = "Relação entre x1 e y", xlab = "x1", ylab = "y")
abline(lm(y ~ x1), col = "red")
```

## Funções Principais
reg_linear(): Ajusta um modelo de regressão linear. Aceita uma matriz de variáveis preditoras e uma variável resposta e retorna os coeficientes, resíduos e valores ajustados.
predicao(): Gera predições a partir de um modelo ajustado com reg_linear() e uma nova matriz de preditores.

## Licença
Este pacote está disponível sob a licença MIT

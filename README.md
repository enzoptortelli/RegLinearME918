# Reg_Linear_ME918

Este pacote foi desenvolvido para fornecer ferramentas para ajuste de modelos de regressão linear e predições a partir desses modelos. Ele é útil para realizar análises de regressão linear simples, múltipla e multivariada de forma rápida e eficiente. O pacote também fornece um conjunto de dados, chamado rl_dataset, que pode ser usado para ilustrar o uso das funções.

## Instalação

Você pode instalar o pacote diretamente a partir do GitHub usando o seguinte comando no R:

```r
# Primeiro, instale o pacote 'devtools' caso ainda não tenha:
# install.packages("devtools")

# Depois, instale o pacote diretamente do GitHub:
devtools::install_github("enzoptortelli/ME918A2024S2trabalho2")
```

## Exemplo de Uso
Aqui está um exemplo simples de como usar o pacote utilizando o conjunto de dados rl_dataset para ajustar um modelo de regressão linear e fazer predições:
```r
# Carregando o pacote
library(pacote_regressao_linear)

# Carregando os dados do pacote
data(meu_dataset)

# Ajustando o modelo de regressão linear
modelo_exemplo <- reg_linear(meu_dataset[, 3:6], meu_dataset[, 1:2])

# Exibindo os coeficientes do modelo
modelo_exemplo$coeficientes

# Fazendo predições com novos valores de preditores
novos_preditores <- matrix(c(1, 5, 2, 6, 3, 7, 4, 9), nrow = 2, byrow = TRUE)
predicoes <- predicao(modelo_exemplo, novos_preditores)
predicoes$preditos

```
## Gráficos Disponíveis
A função grafico() permite criar três tipos de gráficos para verificar o desempenho do modelo de regressão ajustado. Esses gráficos são úteis para avaliar a qualidade do ajuste e a adequação dos resíduos:

Tipos de Gráficos:
- Valores Preditos vs Observados (pvo): Compara os valores preditos pelo modelo com os valores observados no conjunto de dados. Este gráfico ajuda a verificar se o modelo está ajustando corretamente os dados.
Exemplo de uso:
```r
grafico(modelo_exemplo, tipo = "pvo")  
```

-Resíduos vs Preditora (rvp): Plota os resíduos do modelo (diferença entre os valores observados e preditos) em relação a uma variável preditora. Isso ajuda a identificar padrões nos resíduos que possam indicar problemas no modelo.
Exemplo de uso:
```r
grafico(modelo_exemplo, tipo = "rvp")  
```

- QQ-plot dos Resíduos (qqplot): Um gráfico quantil-quantil (QQ-plot) dos resíduos, que ajuda a verificar se os resíduos seguem uma distribuição normal, um dos principais pressupostos da regressão linear.
Exemplo de uso:
```r
grafico(modelo_exemplo, tipo = "qqplot")  
```

## Licença

Este pacote está disponível sob a licença **GNU General Public License**. Para mais detalhes, consulte o arquivo LICENSE.


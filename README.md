# Pacote RegLinearME918

Este pacote foi desenvolvido por Enzo Putton Tortelli de Souza, Eric Pavarim Lima, Lara Maria Herrera Drugowick e Luiz Felipe de Oliveira Barbosa Nunes, como parte das atividades realizadas na disciplina de ME918-2S-2014 (Produto de Dados) do curso de Estatística da Unicamp.

Com este pacote, fornecemos ferramentas simples para ajustes de modelos de regressão linear simples, múltipla e multivariada, realização de predições a partir desses modelos e construção de gráficos de diagnósticos. O pacote também fornece um conjunto de dados, chamado `rl_dataset`, que pode ser usado para ilustrar o uso das funções.

## Regressão Linear
Apesar de não sermos videntes e não conseguirmos prever o futuro, fazer predições é importante para entendermos comportamentos do ambiente ao nosso redor. A regressão linear simples nos possibilita, a partir de uma variável preditora, prever algum evento resposta de nosso interesse. Um exemplo poderia ser prever o preço de computadores a partir da quantidade (em gigabytes) de memória RAM disponível.

A ideia pode ser extendida quando quisermos prever esse custo levando em conta não somente a quantidade de memória RAM, mas também a performance das placas de vídeo (GPU) responsáveis por processarem as imagens nos computadores. Nessa situação, saímos de um modelo linear simples para um com múltiplos preditores (regressão múltipla). Uma outra possibilidade seria não apenas prever o custo dos computadores, mas também o tempo de inicialização dos mesmos, a partir de um conjunto de variáveis preditoras como as performances das placas de vídeo (GPU), dos processadores (CPU) e a quantidade de memória RAM. Estamos diante, portanto, de uma regressão multivariada.

Explore o pacote RegLinearME918 e encontre o modelo que melhor descreva seus dados! Utilize o conjunto de dados disponibilizado por nós ou qualquer dataset do seu interesse!

## Instalação

Você pode instalar o pacote diretamente a partir do GitHub usando o pacote `devtools` e executando o seguinte comando no R:

```{r}
# Primeiro, instale o pacote 'devtools' caso ainda não tenha:
# install.packages("devtools")

# Depois, instale o pacote RegLinearME918 diretamente do GitHub:
devtools::install_github("enzoptortelli/RegLinearME918")
```

Quando você carregar o pacote `RegLinearME918`, o pacote `ggplot2` será instalado automaticamente.

## Exemplo de Uso

Aqui está um exemplo simples de como usar o pacote `RegLinearME918` utilizando o conjunto de dados `rl_dataset` para ajustar um modelo de regressão linear e fazer predições:
```{r}
# Carregando o pacote
library(RegLinearME918)

# Carregando os dados do pacote
data(rl_dataset)

# Ajustando o modelo de regressão linear
modelo_exemplo <- reg_linear(rl_dataset[, 3:5], rl_dataset[, 1:2])

# Exibindo os coeficientes do modelo
modelo_exemplo$coeficientes

# Fazendo predições com novos valores de preditores (valores contidos no banco de dados)
novos_preditores <- rl_dataset[1:5, 3:5]
resultado_predicao <- predicao(modelo_exemplo, novos_preditores, tipo = 'confianca')
resultado_predicao

# Fazendo predições com novos valores de preditores (valores que não estão contidos no banco de dados, porém estão dentro da amplitude dos dados)
novos_preditores <- matrix(c(21.731307, 21.645257, 5, 
                             22.697230, 20.559285, 7), nrow = 2, byrow = TRUE)
resultado_predicao <- predicao(modelo_exemplo, novos_preditores, tipo = 'predicao')
resultado_predicao
```

## Gráficos Disponíveis
A função `grafico()` permite criar três tipos de gráficos para verificar o desempenho do modelo de regressão ajustado. Esses gráficos são úteis para avaliar a qualidade do ajuste e a adequação dos resíduos:

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


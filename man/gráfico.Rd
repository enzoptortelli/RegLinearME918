\name{grafico}
\alias{grafico}
\title{Gráficos de verificação do modelo linear}
\description{
  \code{grafico} Função utilizada para criação de gráficos para verificação do modelo linear resultante. Válida também para regressão linear multivariada.
}
\usage{
grafico(modelo, tipo = c("pvo", "rvp", "qqplot"))
}
\arguments{
  \item{modelo}{Modelo de regressão linear. Deve ser, obrigatoriamente, da classe \code{"modelo_linear"}. Caso contrário, a função gerará um erro.}

  \item{tipo}{É um vetor do tipo \code{char} que especifica os tipos de gráficos desejados. Os valores aceitos são:
    \describe{
      \item{pvo}{Valores preditos x valores observados.}
      \item{rvp}{Resíduos x preditora.}
      \item{qqplot}{QQPlot dos resíduos.}
    }
  }
}
\examples{
# Exemplo de uso da função grafico
# Ajustando um modelo de regressão linear
modelo_exemplo <- reg_linear(meu_dataset[, 3:6], meu_dataset[, 1:2])

# Gerando gráficos de verificação do modelo
grafico(modelo_exemplo, tipo = c("pvo", "rvp", "qqplot"))
}
\keyword{gráficos}
\export

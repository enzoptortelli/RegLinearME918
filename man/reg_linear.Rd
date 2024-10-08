% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reg_linear.R
\name{reg_linear}
\alias{reg_linear}
\title{Ajuste de Modelos Lineares}
\usage{
reg_linear(x, y)
}
\arguments{
\item{x}{Variáveis preditoras do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matriz pela função \code{as.matrix}.}

\item{y}{Variáveis respostas do modelo. Deve ser um objeto do tipo \code{numeric} que seja coercível a uma matriz pela função \code{as.matrix}.}
}
\value{
\code{reg_linear} retorna uma lista da classe \code{"modelo_linear"} contendo os seguintes componentes:
\describe{
\item{coeficientes}{Os valores estimados dos coeficientes do modelo.}
\item{dados}{Os dados utilizados para criar o modelo.}
\item{residuos}{Os resíduos, ou seja, a diferença entre o valor observado da resposta e o valor ajustado pelo modelo.}
\item{ajustados}{Os valores ajustados do modelo; ou seja, os valores preditos de \code{y} com base nos preditores \code{x}.}
}
}
\description{
A função \code{reg_linear} deve ser usada para ajustar modelos de regressão linear, incluindo modelos multivariados.
}
\details{
A função ajusta um modelo de regressão linear com base nos preditores e nas variáveis respostas fornecidas. Ela utiliza a forma matricial da regressão linear para calcular os coeficientes de ajuste.
}
\examples{
# Carregando o conjunto de dados do pacote
data(rl_dataset)

# Ajustando um modelo de regressão linear simples
modelo_simples <- reg_linear(rl_dataset[, 3:5], rl_dataset[, 1])
modelo_simples$coeficientes

# Ajustando um modelo de regressão linear múltipla
modelo_multiplo <- reg_linear(rl_dataset[, 3:5], rl_dataset[, 1:2])
modelo_multiplo$coeficientes

}

# Abrir .Renviron no RStudio (cria se não existir)
usethis::edit_r_environ()

# ===================================
# Teste para avaliar se as KEYS foram
# carregadas adequadamente.
# ===================================
Sys.getenv("OPENAI_API_KEY")
Sys.getenv("ANTHROPIC_API_KEY")

# Pacotes necessários
install.packages(c(
  "gptstudio",    # Interface para ChatGPT no RStudio
  "chattr",       # Interface para múltiplos LLMs
  "httr2",        # Cliente HTTP moderno (para APIs)
  "jsonlite",      # Trabalhar com JSON
  "shiny"
))

# Verificar instalação
library(gptstudio)
library(chattr)
library(httr2)
library(jsonlite)
library(shiny)
library(tidyverse)
library(ellmer)
library(chattr)

#
# Mostra os modelos OpenAI disponiveis
models_openai()

#
# Mostra os modelos Anthropic disponiveis
models_anthropic()

#
# Escolho modelo
my_chat <- ellmer::chat_anthropic()
# my_chat <- ellmer::chat_anthropic(model = 'claude-opus-4-1-20250805')

# my_chat <- ellmer::chat_openai()
# my_chat <- ellmer::chat_openai(model = 'gpt-5.1-codex-mini')

#
# Preparo o Rstudio para o usar o modelo
# escolhido
chattr_use(my_chat)

# Abre o chat no painel lateral do RStudio
chattr_app(as_job = TRUE)

# Criar um vetor numérico em R
chattr("Como criar um vetor em R?")

# Explicar conceitos
chattr("O que é um data.frame?")

# Gerar código
chattr("Crie uma função que calcule média e desvio padrão")

# Debugging
chattr("Por que este código dá erro: mean(NA)")


# Selecione este código e peça explicação
dados %>%
  filter(!is.na(valor)) %>%
  group_by(categoria) %>%
  summarize(
    n = n(),
    media = mean(valor),
    dp = sd(valor)
  ) %>%
  arrange(desc(media))

chattr("Explique este codigo: dados %>%
  filter(!is.na(valor)) %>%
  group_by(categoria) %>%
  summarize(
    n = n(),
    media = mean(valor),
    dp = sd(valor)
  ) %>%
  arrange(desc(media))")
# Este código usa o pipe %>% para encadear operações no data.frame dados

# dados %>%
# Começa com o data.frame 'dados' e passa para a próxima função

# filter(!is.na(valor)) %>%
# Remove linhas onde 'valor' é NA (missing/ausente)
# is.na() identifica NAs, ! inverte (mantém apenas não-NAs)

# group_by(categoria) %>%
# Agrupa os dados pela coluna 'categoria'
# Operações seguintes serão feitas dentro de cada grupo

# summarize(
# Cria um resumo estatístico para cada grupo

#   n = n(),
# Conta o número de observações em cada grupo

#   media = mean(valor),
# Calcula a média de 'valor' para cada grupo

#   dp = sd(valor)
# Calcula o desvio padrão de 'valor' para cada grupo

# ) %>%

# arrange(desc(media))
# Ordena o resultado pela média em ordem decrescente (maior para menor)
# desc() = descendente

# Resultado final: tabela com categoria, n, media e dp, ordenada por media



# Código com erro
dados <- data.frame(x = 1:5, y = c(2, 4, NA, 8, 10))
mean(dados$y)  # Retorna NA

# Prompt para ChatGPT:
chattr("Por que mean(dados$y) retorna NA? Como corrigir?")
# mean() retorna NA quando há valores ausentes (NA) no vetor
# Por padrão, R não ignora NAs automaticamente

# Exemplo do problema
dados <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(10, 20, NA, 40, 50)
)

mean(dados$y)
# Retorna NA

# SOLUÇÃO 1: usar argumento na.rm = TRUE (remove NAs)
mean(dados$y, na.rm = TRUE)

# SOLUÇÃO 2: remover NAs antes com filter (tidyverse)
library(dplyr)

dados %>%
  filter(!is.na(y)) %>%
  summarize(media = mean(y))

# SOLUÇÃO 3: usar na.omit() para remover linhas com NA
mean(na.omit(dados$y))

# Verificar quantos NAs existem
sum(is.na(dados$y))

# Ver onde estão os NAs
which(is.na(dados$y))

# A forma mais comum e recomendada é usar na.rm = TRUE
)



# Função verbosa
calcular <- function(x, y) {
  resultado1 <- x + y
  resultado2 <- x * y
  resultado3 <- x / y
  output <- list()
  output$soma <- resultado1
  output$produto <- resultado2
  output$divisao <- resultado3
  return(output)
}

# Prompt:
# Armazene o código em uma variável primeiro
codigo <- 'calcular <- function(x, y) {{
  resultado1 <- x + y
  resultado2 <- x * y
  resultado3 <- x / y
  output <- list()
  output$soma <- resultado1
  output$produto <- resultado2
  output$divisao <- resultado3
  return(output)
}}'

chattr(paste("Refatore esta função para ser mais concisa e clara:", codigo))
# Versão refatorada - mais concisa e clara

calcular <- function(x, y) {
  list(
    soma = x + y,
    produto = x * y,
    divisao = x / y
  )
}

# Melhorias aplicadas:
# 1. Removidas variáveis intermediárias desnecessárias
# 2. Criação direta da lista com nomes
# 3. Return implícito (última expressão é retornada automaticamente)
# 4. Código mais legível e compacto

# Teste da função
calcular(10, 5)

# Versão alternativa com tibble (tidyverse)
library(tibble)

calcular_tidy <- function(x, y) {
  tibble(
    operacao = c("soma", "produto", "divisao"),
    resultado = c(x + y, x * y, x / y)
  )
}

calcular_tidy(10, 5)


#
# Criar um data.frame que contem dados de um experimento com dois tratamentos
# em DIC em bovinos leitiros para avaliar se existe diferença estatistica na
# producao de leite de vacas alimentadas com duas dietas diferentes.
prompt <- "Criar um data.frame que contem dados de um experimento com dois 
           tratamentos em DIC em bovinos leitiros para avaliar se existe 
           diferença estatistica na producao de leite de vacas alimentadas 
           com duas dietas diferentes."

chattr(prompt)
# Experimento em DIC (Delineamento Inteiramente Casualizado)
# Dois tratamentos: Dieta A e Dieta B
# Variável resposta: Produção de leite (litros/dia)

library(tibble)
library(dplyr)

# Criar dados do experimento
set.seed(123)

experimento <- tibble(
  animal = 1:40,
  tratamento = rep(c("Dieta_A", "Dieta_B"), each = 20),
  producao_leite = c(
    rnorm(20, mean = 25, sd = 3),
    rnorm(20, mean = 28, sd = 3)
  )
)

# Visualizar dados
print(experimento)

# Estatísticas descritivas por tratamento
experimento %>%
  group_by(tratamento) %>%
  summarize(
    n = n(),
    media = mean(producao_leite),
    dp = sd(producao_leite),
    mediana = median(producao_leite),
    minimo = min(producao_leite),
    maximo = max(producao_leite)
  )

# Teste t para comparar os dois tratamentos
teste_t <- t.test(producao_leite ~ tratamento, data = experimento)
print(teste_t)

# Alternativa: ANOVA
modelo_anova <- aov(producao_leite ~ tratamento, data = experimento)
summary(modelo_anova)

# Visualização
library(ggplot2)

ggplot(experimento, aes(x = tratamento, y = producao_leite)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.5) +
  labs(
    title = "Produção de Leite por Tratamento",
    x = "Tratamento",
    y = "Produção de Leite (L/dia)"
  ) +
  theme_minimal()
)

chattr('Adicione cores nos boxplots por classe de tratamento')
# Adicionar cores nos boxplots por tratamento

library(ggplot2)

ggplot(experimento, aes(x = tratamento, y = producao_leite, fill = tratamento)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.5) +
  labs(
    title = "Produção de Leite por Tratamento",
    x = "Tratamento",
    y = "Produção de Leite (L/dia)"
  ) +
  theme_minimal()

# Versão com cores personalizadas
ggplot(experimento, aes(x = tratamento, y = producao_leite, fill = tratamento)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.1, alpha = 0.5) +
  scale_fill_manual(values = c("Dieta_A" = "#E69F00", "Dieta_B" = "#56B4E9")) +
  labs(
    title = "Produção de Leite por Tratamento",
    x = "Tratamento",
    y = "Produção de Leite (L/dia)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Versão com paleta viridis
ggplot(experimento, aes(x = tratamento, y = producao_leite, fill = tratamento)) +
  geom_boxplot(alpha = 0.8) +
  geom_jitter(width = 0.1, alpha = 0.5) +
  scale_fill_viridis_d() +
  labs(
    title = "Produção de Leite por Tratamento",
    x = "Tratamento",
    y = "Produção de Leite (L/dia)"
  ) +
  theme_minimal()


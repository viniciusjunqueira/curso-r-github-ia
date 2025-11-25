# ============================================
# OPERADORES RELACIONAIS EM MELHORAMENTO
# ============================================

# Avaliação de um reprodutor
dep_leite <- 850 # DEP (Diferença Esperada na Progênie) para leite em kg
acuracia <- 0.85 # Acurácia da avaliação genética
idade_meses <- 36

# Verificações básicas
dep_leite > 500 # TRUE - DEP positiva e alta?

acuracia >= 0.70 # TRUE - avaliação confiável?
idade_meses <= 48 # TRUE - ainda jovem?
dep_leite == 850 # TRUE - exatamente 850 kg?
acuracia != 1.0 # TRUE - não tem acurácia perfeita

# Avaliando múltiplos animais
deps_peso <- c(15, 22, 8, 30, 18) # DEPs para peso ao desmame (kg)
deps_peso >= 20 # FALSE  TRUE FALSE  TRUE FALSE
sum(deps_peso >= 20) # 2 animais atingem o critério

# Critérios para touro elite
dep_leite <- 950
dep_gordura <- 35
dep_proteina <- 28
confiabilidade <- 0.88
consanguinidade <- 0.03

# Touro elite: DEP leite > 800 E gordura > 30 E proteína > 25
touro_elite <- (dep_leite > 800) & (dep_gordura > 30) & (dep_proteina < 25)
print(touro_elite)

# Seleção para inseminação artificial
fertilidade_campo <- 0.65
libido <- "alta"
saude_andrológica <- TRUE
dep_habilidade_materna <- 5L

# Apto para IA se: fertilidade > 0.60 E libido adequada E saúde OK
apto_ia <- fertilidade_campo > 0.60               &
           (libido == "alta" | libido == "média") &
            saude_andrológica
print(apto_ia) # TRUE


# Plantel de vacas leiteiras
rebanho <- data.frame(
  animal_id = c("V001", "V002", "V003", "V004", "V005"),
  dep_leite = c(850, 650, 920, 550, 780),
  dep_gordura = c(32, 28, 38, 25, 30),
  acuracia = c(0.85, 0.75, 0.90, 0.60, 0.80),
  idade_anos = c(4, 6, 3, 8, 5),
  consanguinidade = c(0.02, 0.06, 0.01, 0.08, 0.03),
  n_partos = c(2, 4, 1, 6, 3)
)
rebanho

# 1. VACAS SUPERIORES para mães de touros
# Critérios: DEP leite > 800, DEP gordura > 30, acurácia > 0.80
maes_touros <- rebanho$dep_leite > 800   &
               rebanho$dep_gordura > 30  &
               rebanho$acuracia > 0.80
print("Candidatas a mães de touros:")
print(rebanho[maes_touros, ])
print(rebanho[maes_touros]) # ERRADO!

# 2. VACAS EM RISCO de descarte
# Critérios: idade > 7              OU 
#            consanguinidade > 0.07 OU 
#            DEP leite < 600
risco_descarte <- rebanho$idade_anos > 7         |
                  rebanho$consanguinidade > 0.07 |
                  rebanho$dep_leite < 600

print("\nAnimais em risco de descarte:")
print(rebanho[risco_descarte, ])

# ============================================
# ÍNDICE DE SELEÇÃO COMPOSTO
# ============================================
# Cálculo de índice para gado de corte
dep_peso_desmame <- 25 # kg
dep_ganho_pos_desmame <- 18 # kg
dep_aol <- 2.5 # área de olho de lombo (cm²)
dep_eg <- -1.2 # espessura de gordura (mm) - negativo é bom!

# Pesos econômicos (exemplo)
peso_pd <- 2.0
peso_gpd <- 1.5
peso_aol <- 3.0
peso_eg <- -1.0

# Cálculo do índice
indice <- (dep_peso_desmame * peso_pd) +
          (dep_ganho_pos_desmame * peso_gpd) +
          (dep_aol * peso_aol) +
          (dep_eg * peso_eg)
print(paste("Índice de seleção:", indice))




# ============================================
# LOOP FOR - EXEMPLOS BÁSICOS
# ============================================
# Exemplo 1: Calcular DEPs padronizadas
deps_peso <- c(25, 18, 32, 15, 28, 22, 8, 30)
animal_ids <- paste0("A", sprintf("%03d", 1:length(deps_peso)))
media <- mean(deps_peso)
dp <- sd(deps_peso)

cat("DEPs PADRONIZADAS\n")
cat("=================\n\n")

for(i in 1:length(deps_peso)){
  print(
    round(
      c(i, deps_peso[i], media, dp, (deps_peso[i] - media) / dp),
      2)
    )
}

for(i in c(1,4,10)) {
  print(i)
}


x <- c(1,2,3,4)
sum(x)

val <- 0
for(i in 1:length(x)){
  val <- val + x[i]
  print(c(x[i], val))
}


# SYNTAX: for (contador das iteracoes) {operacoes}
for (i in 1:length(deps_peso)) {
  dep_padronizada <- (deps_peso[i] - media) / dp
  
  cat("Animal", animal_ids[i], "- DEP:", deps_peso[i],
      "| Padronizada:", round(dep_padronizada, 2), "\n")
}






# ============================================
# LOOP REPEAT - MÚLTIPLOS CRITÉRIOS DE PARADA
# ============================================
set.seed(123)
populacao_size <- 100
dep_media <- 500
geracao <- 0
max_geracoes <- 50
meta_dep <- 700
sem_melhoria <- 0
max_sem_melhoria <- 10
cat("ALGORITMO GENÉTICO\n")
cat("==================\n\n")

repeat {
  geracao <- geracao + 1
  deps_populacao <- rnorm(populacao_size, mean = dep_media, sd = 50)
  deps_selecionados <- sort(deps_populacao, decreasing = TRUE)[1:20]
  nova_media <- mean(deps_selecionados)
  
  if (abs(nova_media - dep_media) < 1) {
    sem_melhoria <- sem_melhoria + 1
  } else {
    sem_melhoria <- 0
  }
  
  dep_media <- nova_media
  if (geracao %% 5 == 0) { # Numero divisivel por 5
    cat("Geração", geracao, "- DEP:", round(dep_media, 1), "kg\n")
  }
  # Múltiplos critérios de parada
  if (dep_media >= meta_dep) {
    cat("\n META ATINGIDA!\n")
    break
  }
  if (geracao >= max_geracoes) {
    cat("\n Máximo de gerações\n")
    break
  }
  if (sem_melhoria >= max_sem_melhoria) {
    cat("\n Sem melhoria há", max_sem_melhoria, "gerações\n")
    break
  }
}


library(dplyr)
library(palmerpenguins) # dataset

# Remover linhas com NAs nas colunas essenciais
View(penguins)
dim(penguins) # Avalia as dimensoes da tabela
colnames(penguins) # Colunas da tabela

peng <- penguins |>
  filter(!is.na(species),
         !is.na(bill_length_mm),
         !is.na(bill_depth_mm),
         !is.na(flipper_length_mm),
         !is.na(body_mass_g))
dim(peng)

# Selecionar só o que precisamos
peng_sel <- peng |>
  select(species, island, bill_length_mm)
dim(peng_sel)

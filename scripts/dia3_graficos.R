library(readr)
library(here)

here("data", "raw", "dados.csv")

# Ler CSV com separador vírgula (padrão internacional)
dados <- read_csv(file = here("data", "raw", "dados.csv"))

# Criar dados de exemplo
dados_exemplo <- tibble(
  id = 1:5,
  nome = c("Ana", "Bruno", "Carla", "Diego", "Elena"),
  nota = c(8.5, 7.0, 9.0, 6.5, 8.0)
)

# Salvar como CSV (UTF-8)
dir.create(here('output','tables'), recursive = TRUE) # Cria todas as pastas

write_csv(dados_exemplo, here("output", "tables", "notas.csv"))

# Salvar como CSV com separador ponto-e-vírgula
write_csv2(dados_exemplo, here("output", "tables", "notas.csv"))

# Salvar como Excel (requer writexl)
library(writexl)
write_xlsx(dados_exemplo, here("output", "tables", "notas.xlsx"))

# Salvar como RDS (formato nativo R - preserva tipos)
saveRDS(dados_exemplo, here("output", "tables", "notas.rds"))

# Ler RDS
dados <- readRDS(here("output", "tables", "notas.rds"))

# ============================
# GGPLOT2
# ============================
View(penguins)
install.packages('ggplot2')
library('ggplot2')

ggplot(data = penguins,  # Apenas especifica os dados
  aes(x = flipper_length_mm, # eixo x
      y = body_mass_g, # eixo y
      color = species, # cor por espécie
      size = bill_length_mm) # tamanho por comprimento do bico
) + 
  geom_point() +
  geom_smooth()

# Adicionar forma por ilha
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm,
                     color = species, shape = island)) +
  geom_point(size = 3, alpha = 0.7)


# Barras lado a lado
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "dodge")


# Adicionar pontos individuais
ggplot(penguins, aes(x = species, y = body_mass_g, 
                     fill = species)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.3, size = 1)


# Com pontos
ggplot(penguins, aes(x = body_mass_g, 
                     y = flipper_length_mm)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "blue", size = 3)


# Ajustar número de bins
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 15, fill = "steelblue", alpha = 0.7)

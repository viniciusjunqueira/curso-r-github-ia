#
# Conferir o local atual
getwd()

#
# Copia e cola no TERMINAL
git clone https://github.com/viniciusjunqueira/curso-r-github-ia.git

#
# Executa no Rscript
system("git clone https://github.com/viniciusjunqueira/curso-r-github-ia.git")

#
# Mudar o diretorio de trabalho
setwd("/Users/viniciusjunqueira/Library/CloudStorage/OneDrive-Pessoal/Cursos/curso-r-github-ia/")

#
# Variável inteira (integer)
x_int <- 2
x_int2 <- 2L

class(x_int)
class(x_int2)

# Infinito positivo. Significa que o valor tende ao infinito positivo.
a <- 1 / 0
a
# Infinito negativo. Significa que o valor tende ao infinito negativo.
b <- -1 / 0
b
# Not a Number (NaN). Indica uma operação indefinida matematicamente.
c <- 0 / 0
c
# Valor ausente (NA). Representa um valor desconhecido ou faltante.
d <- c(2, 4, NA, 8)
d

f <- c("2", "4", NA, "8")
f

g <- c("2", "4", NA, "8", 1L)
g

# -------------------------------------------------------------
# Testando os tipos de valores
# -------------------------------------------------------------
is.infinite(a) # TRUE
is.nan(c) # TRUE
is.na(d) # TRUE para o elemento ausente
is.na(NaN) # TRUE — NaN é considerado um tipo especial de NA
is.finite(a) # FALSE — porque Inf não é finito
is.finite(10) # TRUE — número normal é finito

v <- c(10, 20, 30, 40, 50)
v
length(v)
mean(v)
sum(v)

mean(v) / sum(v)

# 1.  2.  3.  4.  5. 
c(10, 20, 30, 40, 50)

v[1]
v[2:4]
v[1:5]
v[-1]

sel <- v > 25
sel

v[sel]

v
v[2:4]
v[c(2:4)]
v[-c(2:4)]

#
#
# 1.  2.  3.  4.  5. 
c(10, 20, 30, 40, 50)
names(v) <- c("a","b","c","d","e")
# names(v) <- letters[1:5]
# Mostrando o vetor com nomes
v
#
Acessando um elemento pelo nome
v["a"]


# Criando uma lista com diferentes tipos de objetos
info <- list(
  nome = "Ana"
  , idade = 25
  , notas = c(8.5, 9.0, 7.5)
#  , aprovado = TRUE
  )

# Visualizando a lista completa
info
str(info)

# Lista: tipos mistos
lst <- list(id = 1, 
            nome = "Ana", 
            #aprovado = TRUE
            )
lst$nome

# Data frame
alunos <- data.frame(
  id = 1:4,
  nome = c("Ana", "Bruno", "Caio", "Dani"),
  nota = c(8.5, 7.2, 9.1, 6.8),
  ativo = c(TRUE, TRUE, FALSE, TRUE),
  stringsAsFactors = FALSE
)
alunos

str(alunos)
nrow(alunos)   # Numero de linhas
ncol(alunos)   # Numero de colunas
names(alunos)  # Nomes do objeto
head(alunos, 2) # Primeiras 2 linhas
tail(alunos, 2) # Ultimas 2 linhas

# Acesso e novas colunas
alunos$nome
alunos$aprov <- ifelse(alunos$nota >= 7, "Aprovado", "Recuperação")
alunos

sexo <- factor(c("F", "M", "M", "F"), levels = c("F", "M"))
sexo
levels(sexo)

conceito <- factor(c("B", "A", "C", "A"), levels = c("C", "B", "A"), ordered = TRUE)
conceito
summary(conceito)




install.packages('psych')
install.packages('GPArotation')
install.packages("corrplot")
install.packages('ggplot2')
install.packages('carData')
install.packages('readxl')

library("readxl")
library(carData)
library("psych")
library(corrplot)
library(dplyr)
library(ggplot2)
#-------------------------------
#--Analise Fatorial (AFE) 

# 1- Carregando Dataframe 
#Base dados: arquivo '.csv' do diretorio

# 2- lendo arquivo
data_survey<-read_excel("BD_VIOLENCIA_MG_2022-3.xlsx")

describe(data_survey)
dAux<-data_survey            
#########
dim(dAux)
#describe(dAux)
summary(dAux)
head(dAux)
View(dAux)
#########

# 3- Matriz de correlação:

datamatrix <- cor(dAux)
corrplot(datamatrix, method="number")
#--------------

# 4- Teste validação KMO e Bartlett
dataX <- dAux
KMO(cor(dataX))
cortest.bartlett(dataX)
det(cor(dataX))
#-------------------


# 5- Número de fatores da A.F.
# Método Scree:
fafitfree <- fa(dataX,nfactors = ncol(dataX), rotate = "none")
n_factors <- length(fafitfree$e.values)
scree     <- data.frame(Factor_n =  as.factor(1:n_factors),Eigenvalue = fafitfree$e.values)
ggplot(scree, aes(x = Factor_n, y = Eigenvalue, group = 1)) +
  geom_point() + geom_line() +
  xlab("Number of factors") +
  ylab("Initial eigenvalue") +
  labs( title = "Scree Plot",
        subtitle = "(Based on the unreduced correlation matrix)")

# Técnica análise paralela para sequência de fatores com uma matriz de mesmo tamanho
parallel <- fa.parallel(dataX)

#vss(dataX)
#O metodo Scree e o VSS 
#nos da a entender dois fatores, ao contrario da analise paralela

#PCA do prof. no meu PC nao funcionou: deu 2 fatores
#pca.none <- principal(r=dataX, nfactors, residuals = FALSE, rotate="varimax", 
#                      +                       scores = TRUE, method = "regression")
#print(pca.none)


# IMPORTANTE! 'nfactors' recebe o nº fatores da analise paralela acima
# pode ser: 1, 2, 3, etc
# 6- Análise Fatorial usando a função ‘fa’ com o algoritmo dos eixos principais e rotação ‘Varimax’
fa.none <- fa(r=dataX,
              nfactors = 2,
              # covar = FALSE, SMC = TRUE,
              fm="pa", # type of factor analysis we want to use (“pa” is principal axis factoring)
              max.iter=100, # (50 is the default, but we have changed it to 100
              rotate="varimax") # none rotation
print(fa.none)

# 7- Grafo das matrizes com o fator carga:
fa.diagram(fa.none)
#-------------

# --- CONTINUAÇÃO DO SCRIPT ---
# APLICAÇÃO DE ANALISE FATORIAL E CLUSTERIZAÇÃO
# OBJETIVO? BASE DADOS FINAL PARA MODELO PREDITIVO

# 7.1 Isolamento do Alvo (Furto)
y_alvo <- dataX$X14
data_para_fatores <- dataX %>% select(-X14)

# 7.2 Execução da AF de Produção (Sem o X14)
# Note: usamos fm="pa" para Principal Axis Factoring
fa_final <- fa(r = data_para_fatores, 
               nfactors = 2, 
               fm = "pa", 
               rotate = "varimax", 
               scores = "regression")

# 7.3 Visualização para Definição de Nomes
# Este gráfico mostrará as setas e os coeficientes de cada X para os novos fatores
fa.diagram(fa_final, main = "Diagrama de Cargas Fatoriais (Sem X14)")

# Exibe as cargas no console para conferência numérica
print(fa_final$loadings, cutoff = 0.3) # O cutoff esconde valores baixos para facilitar a leitura

# Rodando a AF final com 2 fatores (conforme seu Scree Plot)
fa_final <- fa(r = data_para_fatores, nfactors = 2, rotate = "varimax", scores = "regression")

# 8. Criando o novo Dataset "Pronto para Machine Learning"
# Extraímos os scores (que agora representam a estrutura de criminalidade sem o X14)
df_modelagem <- as.data.frame(fa_final$scores)

names(df_modelagem)[1] <- "Indice_Violencia_e_Confronto_Geral" # Exemplo para PA1/MR1
names(df_modelagem)[2] <- "Indice_Vulnerabilidade_e_Furtos"  # Exemplo para PA2/MR2

# Adicionamos a variável alvo de volta
df_modelagem$Furto_X14 <- y_alvo

View(df_modelagem)


# 9. Adicionando Clusterização para enriquecer o CSV
# Vamos criar 3 grupos genéricos baseados nos fatores

#Cluster 1 

#Cluster 2 

#Cluster 3 

set.seed(123)
clusters <- kmeans(fa_final$scores, centers = 3)
df_modelagem$Perfil_Cidade <- as.factor(clusters$cluster)

View(df_modelagem)

# 9.1 Analisando os clusters gerados
# Estudando suas caracteríticas

# Ver a média de crimes por cluster
aggregate(df_modelagem[, 1:3], list(df_modelagem$Perfil_Cidade), mean)

# Qtd de cidades em relação a 
# media do indice de violencia e confrontos 
# e a media de furtos da variavel X14 (alvo)
perfil_clusters <- df_modelagem %>%
  group_by(Perfil_Cidade) %>%
  summarise(
    Qtd_Cidades = n(),
    Media_Violencia = mean(Indice_Violencia_e_Confronto_Geral),
    Media_Furtos_Real = mean(Furto_X14)
  )

print(perfil_clusters)


# Calcula a média do índice de vulnerabilidade para cada grupo
tapply(df_modelagem$Indice_Vulnerabilidade_e_Furtos, df_modelagem$Perfil_Cidade, mean)


# 10. Criando a coluna de rótulo baseada na interpretação das médias
df_modelagem <- df_modelagem %>%
  mutate(Categoria_Cidade = case_when(
    Perfil_Cidade == "1" ~ "Estável",
    Perfil_Cidade == "2" ~ "Crítica / Metrópole",
    Perfil_Cidade == "3" ~ "Vulnerabilidade Moderada",
    TRUE ~ "Não Classificado"
  ))

# Colocar alvo como ultima coluna da direita

df_modelagem <- df_modelagem %>%
  relocate(Furto_X14, .after = Categoria_Cidade)


# Verificando se os nomes batem com a realidade
View(df_modelagem)


#

# 11. Exportando o arquivo para a Interface Shiny
write.csv(df_modelagem, "BD_PROCESSADO_PARA_SHINY.csv", row.names = FALSE)

cat("Arquivo processado com sucesso! Use 'BD_PROCESSADO_PARA_SHINY.csv' no Shiny.")

# 12 Lendo novo dataset

dataInterface<-read.csv("BD_PROCESSADO_PARA_SHINY.csv")
View(dataInterface)



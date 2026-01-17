install.packages('psych')
install.packages('GPArotation')
install.packages("corrplot")
#estava com ""
install.packages('ggplot2')
install.packages('carData')
install.packages('readxl')
#estava com ""

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
fafitfree <- fa(dAux,nfactors = ncol(dataX), rotate = "none")
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

#
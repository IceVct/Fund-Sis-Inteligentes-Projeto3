# Script em R do projeto 3
# Alvaro Torres Vieira - 14/0079661
# Victor Araujo Vieira - 14/0032801

# Foi utilizado o R Studio
# Packages: dplyr, datasets, utils, randomForest
# Os arquivos train.csv e test.csv devem estar no mesmo path que o programa em R


# importando como data frames para variaveis locais
train <- as.data.frame(read.csv("train.csv"))
test <- as.data.frame(read.csv("test.csv"))

# remove a coluna 1 de ID do treino
train[1] <- NULL 

# chama algoritmo random forest para treino supervisionado
# argumento 1: coluna species é explicada por todas as outras 
# (species -> name of column; ~ -> explained by; "." -> all columns)
# argumento 2: seleciona a variavel local com o data frame
# argumento 3: insere o número de árvores de decisão a serem feitos. 
# Foi utilizado o mesmo número de variaveis de trieno
fit <- randomForest::randomForest(species ~ ., data = train, ntree = 990)

# predict com a arvore randomica e o data frame de teste
# pred é uma coluna de tamanho 594 com a predição dos nomes das espécies
pred <- as.data.frame(predict(fit, test))

# insere as ids das plantas retiradas do data frame usado para teste
pred[2] <- test$id

# modifica nome das colunas
colnames(pred) <- c("species", "id")

# cria uma variável de ambiente com a quantidade de aparição de cada especie
freq <- count(pred, species)

# modifica nome das colunas
colnames(freq) <- c("species", "frequency")

# cria uma variável de ambiente apenas com as espécies que apareceram 6 vezes 
# ou seja, aquelas que foram preditas com a quantidade esperada
pred_correct <- filter(freq, frequency == 6)

# cria uma variável de ambiente apenas com as espécies que apareceram diferente de 6 vezes 
# ou seja, aquelas que foram preditas com a quantidade errada
pred_wrong <- filter(freq, frequency != 6)

# salva em arquivos txt os resultados com separador de virgula
write.table(pred, "/Users/alvarovieira/Desktop/prediction.txt", sep=",", row.names = FALSE, quote = FALSE)
write.table(pred_wrong, "/Users/alvarovieira/Desktop/species_freq_wrong.txt", sep=",", quote = FALSE)
write.table(pred_correct, "/Users/alvarovieira/Desktop/species_freq_correct1.txt", sep=",", quote = FALSE)

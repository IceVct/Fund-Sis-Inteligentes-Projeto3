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
fit_10 <- randomForest::randomForest(species ~ ., data = train, ntree = 10)
fit_50 <- randomForest::randomForest(species ~ ., data = train, ntree = 50)
fit_100 <- randomForest::randomForest(species ~ ., data = train, ntree = 100)
fit_800 <- randomForest::randomForest(species ~ ., data = train, ntree = 800)
fit_1000 <- randomForest::randomForest(species ~ ., data = train, ntree = 1000)

# predict com a arvore randomica e o data frame de teste
# pred é uma coluna de tamanho 594 com a predição dos nomes das espécies
pred_10 <- as.data.frame(predict(fit_10, test))
pred_50 <- as.data.frame(predict(fit_50, test))
pred_100 <- as.data.frame(predict(fit_100, test))
pred_800 <- as.data.frame(predict(fit_800, test))
pred_1000 <- as.data.frame(predict(fit_1000, test))

# insere as ids das plantas retiradas do data frame usado para teste
pred_10[2] <- test$id
pred_50[2] <- test$id
pred_100[2] <- test$id
pred_800[2] <- test$id
pred_1000[2] <- test$id

# modifica nome das colunas
colnames(pred_10) <- c("species", "id")
colnames(pred_50) <- c("species", "id")
colnames(pred_100) <- c("species", "id")
colnames(pred_800) <- c("species", "id")
colnames(pred_1000) <- c("species", "id")

# cria uma variável de ambiente com a quantidade de aparição de cada especie
freq_10 <- count(pred_10, species)
freq_50 <- count(pred_50, species)
freq_100 <- count(pred_100, species)
freq_800 <- count(pred_800, species)
freq_1000 <- count(pred_1000, species)


# modifica nome das colunas
colnames(freq_10) <- c("species", "frequency")
colnames(freq_50) <- c("species", "frequency")
colnames(freq_100) <- c("species", "frequency")
colnames(freq_800) <- c("species", "frequency")
colnames(freq_1000) <- c("species", "frequency")


# cria uma variável de ambiente apenas com as espécies que apareceram 6 vezes 
# ou seja, aquelas que foram preditas com a quantidade esperada
pred_correct_10 <- count(filter(freq_10, frequency == 6))
pred_correct_50 <- count(filter(freq_50, frequency == 6))
pred_correct_100 <- count(filter(freq_100, frequency == 6))
pred_correct_800 <- count(filter(freq_800, frequency == 6))
pred_correct_1000 <- count(filter(freq_1000, frequency == 6))

# cria uma variável de ambiente apenas com as espécies que apareceram diferente de 6 vezes 
# ou seja, aquelas que foram preditas com a quantidade errada
pred_wrong_10 <- filter(freq_10, frequency != 6)
pred_wrong_50 <- filter(freq_50, frequency != 6)
pred_wrong_100 <- filter(freq_100, frequency != 6)
pred_wrong_800 <- filter(freq_800, frequency != 6)
pred_wrong_1000 <- filter(freq_1000, frequency != 6)


pred_wrong_general <- inner_join(pred_wrong_1000, pred_wrong_800)
pred_wrong_general <- left_join(pred_wrong_general, pred_wrong_100)
pred_wrong_general <- left_join(pred_wrong_general, pred_wrong_50)
pred_wrong_general <- left_join(pred_wrong_general, pred_wrong_100)



# salva em arquivos txt os resultados com separador de virgula
write.table(pred_wrong_10, "/home/alvaro/Documentos/gitviews/Fund-Sis-Inteligentes-Projeto3/pred_wrong_10.txt", sep=",", row.names = FALSE, quote = FALSE)
write.table(pred_wrong_50, "/home/alvaro/Documentos/gitviews/Fund-Sis-Inteligentes-Projeto3/pred_wrong_50.txt", sep=",", row.names = FALSE, quote = FALSE)
write.table(pred_wrong_100, "/home/alvaro/Documentos/gitviews/Fund-Sis-Inteligentes-Projeto3/pred_wrong_100.txt", sep=",", row.names = FALSE, quote = FALSE)
write.table(pred_wrong_800, "/home/alvaro/Documentos/gitviews/Fund-Sis-Inteligentes-Projeto3/pred_wrong_800.txt", sep=",", row.names = FALSE, quote = FALSE)
write.table(pred_wrong_1000, "/home/alvaro/Documentos/gitviews/Fund-Sis-Inteligentes-Projeto3/pred_wrong_1000.txt", sep=",", row.names = FALSE, quote = FALSE)

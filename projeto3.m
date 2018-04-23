%% Script principal do projeto 3
% Alvaro Torres Vieira - 
% Victor Araujo Vieira - 14/0032801


%% Le os arquivos csv que contem os dados de treino e teste
tabTreino = readtable('./TreinoTeste/train.csv');
tabTeste = readtable('./TreinoTeste/test.csv');

% A sintaxe para acessar os valores das tabelas geradas na leitura dos csv
% eh, por exemplo: treino{1, 3}, acesssando terceira coluna da primeira
% linha

% pegando os valores das tabelas e gerando variaveis para serem passadas
% nos modelos a serem treinados
labelsTreino = tabTreino{:, 2};
valoresTreino = tabTreino{:, 3:end};
valoresTeste = tabTeste{:, 2:end};
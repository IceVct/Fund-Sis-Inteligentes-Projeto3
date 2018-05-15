%% Script principal do projeto 3
% Alvaro Torres Vieira - 
% Victor Araujo Vieira - 14/0032801

close all;
clear all;
clc;

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

[n,p] = size(valoresTreino)
isLabels = unique(labelsTreino);
nLabels = numel(isLabels);
tabulate(categorical(labelsTreino));

%% SVM
firstTimeSVM = 1;
if(firstTimeSVM == 1)
    [modeloSVM, respostaSVM, rendimentoKFold] = svm(valoresTreino, labelsTreino, valoresTeste);
    save('modeloSVM.mat', 'modeloSVM');
    save('rendimentoKFold.mat', 'rendimentoKFold');
    save('respostaSVM.mat', 'respostaSVM');
else
    load('modeloSVM.mat');
    load('rendimentoKFold.mat');
    load('respostaSVM.mat');
end

%% Calculando o numero total de predicoes de cada classe
[a b c] = unique(respostaSVM);
histograma = hist(c,length(a));
fid = fopen('respostaSVMOvOLinear.txt', 'w');
fid2 = fopen('diferentesDe6OvOLinear.txt', 'w');
numDif6 = 0;
totalErros = 0;
for i = 1:length(a)
    fprintf(fid, '%s: %d\n', a{i, 1}, histograma(i));
    if(histograma(i) ~= 6)
        fprintf(fid2, '%s: %d\n', a{i, 1}, histograma(i));
        totalErros = totalErros + histograma(i);
        numDif6 = numDif6 + 1;
    end
end

fclose(fid);
fclose(fid2);
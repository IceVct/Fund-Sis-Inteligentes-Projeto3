function [modeloSVM, respostaSVM, rendimentoKFold] = svm(valoresTreino, labelsTreino, valoresTeste)
% Funcao que treina e testa o modelo SVM

rng(1);

%% Treino do modelo
t = templateSVM('Standardize', 1, 'KernelFunction', 'linear'); % normaliza os dados
CPU = 1;
if(CPU == 1)
    options = statset('UseParallel',true);
    modeloSVM = fitcecoc(valoresTreino, labelsTreino, 'Coding', 'onevsone', 'Learners', t, 'Options', options);
    modeloCV = crossval(modeloSVM, 'KFold', 10, 'Options', options);
else
    modeloSVM = fitcecoc(valoresTreino, labelsTreino, 'Coding','onevsall', 'Learners', t);
    modeloCV = crossval(modeloSVM, 'KFold', 10);
end


%% Crossvalidation do modelo
erroEstimado = kfoldLoss(modeloCV);
rendimentoKFold = 100 - 100*erroEstimado;

% Vendo as respostas do modelo com os dados de teste
respostaSVM = predict(modeloSVM, valoresTeste);

end


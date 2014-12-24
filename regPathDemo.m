tic;
clc;
clear all

data = load('housing.data');
X = data(:,1:end-1);
y = data(:,end);

% Standardize features to have mean of 0 and variance of 1
X = standardizeCols(X);

% Add bias variable
N = size(X,1);
X = [ones(N,1) X];
d = size(X,2);

lambdaValues = 2.^[16:-1:4];
for i = 1:length(lambdaValues)
    lambda = lambdaValues(i);
    w(:,i) = shooting(X,y,lambda)
end
plot(log2(lambdaValues),w);
title('Regularization Path');
xlabel('log2(lambda)');
ylabel('w coefficients');

toc;

function [w] = shooting(X,y,lambda)
% shooting(X,y,lambda)
%
% Description:
%       - Solves the L1-regularized Least Squares Algorithm (LASSO).
%
% lambda:
%       - This is the smoothing parameter.
%
% Author: Reza Asad (2014)

i = 0;
d = size(X,2);
rand('seed',4);
random_index = randperm(d,d);

% initial w
w = (X'*X + lambda*eye(d))\(X'*y);
error = 1;

% tolerance
epsilon = ones(d,1)*0.000001;

XX2 = 2*X'*X;
Xy2 = 2*X'*y;

while sum(error) > 0
    i = i+1;
    for j=1:d
        index = random_index(j);
        a_j = XX2(index,index);
        c_j = Xy2(index) - sum(XX2(index,:)*w) + XX2(index,index)*w(index);
        
        if c_j<-lambda
            w_j = (c_j+lambda)/a_j;
        elseif c_j>lambda
            w_j = (c_j-lambda)/a_j;
        else
            w_j = 0;
        end
        w(index) = w_j;
    end
    
    if i>1
        error = abs(w-w_old) > epsilon;
    end
    w_old = w;
end

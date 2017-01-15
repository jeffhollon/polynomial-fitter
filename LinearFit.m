function [ a b ] = LinearFit( X, Y )
%LINEARFIT
%y = a x + b
    
    n = size(X,1);
    
    A = [X, ones(n,1)];
    B = [Y];
    
    C = A\B;
    
    a=C(1);
    b=C(2);

end


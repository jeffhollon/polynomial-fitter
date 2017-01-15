function [ a b c ] = QuadraticFit( X, Y )
%QUADRATICFIT
%y = a x^2 + b x+ c
    
    n = size(X,1);
    
    A = [X.^2, X, ones(n,1)];
    B = [Y];
    
    C = A\B;
    
    a=C(1);
    b=C(2);
    c=C(3);

end


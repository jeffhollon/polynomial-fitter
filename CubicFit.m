function [ a b c d ] = CubicFit( X, Y )
%QUADRATICFIT
%y = a x^3 + b x^2+ c x + d
    
    n = size(X,1);
    
    A = [X.^3, X.^2, X, ones(n,1)];
    B = [Y];
    
    C = A\B;
    
    a=C(1);
    b=C(2);
    c=C(3);
    d=C(4);

end


function [ a b c d e f ] = QuinticFit( X, Y )
%QUADRATICFIT
%y = a x^3 + b x^2+ c x + d
    
    n = size(X,1);
    
    A = [X.^5, X.^4, X.^3, X.^2, X, ones(n,1)];
    B = [Y];
    
    C = A\B;
    
    a=C(1);
    b=C(2);
    c=C(3);
    d=C(4);
    e=C(5);
    f=C(6);
end


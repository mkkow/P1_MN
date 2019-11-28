function [Ai]=invmd(A)
%Funkcja wyznacza odwrotność macierzy korzystając ze zmodyfikowanej
%metody Doolittle'a
%A^(-1)=invmd(A)
    if nargin<1
        error('Not enough input arguments.');
    end
    if nargin>1
        error('Too many input arguments.');
    end
    if detmd(A) < eps
        error('Matrix is singular to working precision.');
    end
    if size(A,1)~=size(A,2)
        error('Matrix must be square.');
    end
    
    [U,L]=mdoolittle(A);
    Ui=eye(size(A));
    Li=eye(size(A,1));
    n=size(A,1);
    for i=2:n
        Li(i,1:(i-1))=-L(i,1:(i-1))*Li(1:(i-1),1:(i-1));
        Ui(n-i+2,n-i+2)=1/U(n-i+2,n-i+2);
        Ui(n-i+1,(n-i+1):n)=(-U(n-i+1,(n-i+2):n)*Ui((n-i+2):n,(n-i+1):n))./U(n-i+1,n-i+1);
    end
    Ui(1,1)=1/U(1,1);
    Ai=Li*Ui;
end
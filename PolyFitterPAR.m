function [  ] = PolyFitterPAR( X, Y, Ratio, Iterations )
%POLYFITTER Accepts a dataset (X,Y) and returns the best model for it

close all

    X=X(:); Y=Y(:);
    
    n=size(X,1);
    
%     figure(1); scatter(X,Y,'k.')
%     title('Dataset');

    N=round(Ratio*n);  %Training set size
    
    %linear
    
    parfor i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B] = LinearFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B;
        
        f = @(z) A*z+B;
        
%         figure(2); 
%         scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
%         plot(X,f(X),'b')
%         scatter(TEST_X,TEST_Y,'r.'); %hold off
%         legend('Training Set', 'Test Set')
        
        %Get the MSE
        LinearError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
%         pause(0.01)
    end
    
%     figure(3); histogram(LinearError)
%     title('Linear Fit MSEs')
    
    BestLoc = find(LinearError == min(LinearError));
    BestLoc = BestLoc(1);
      
    disp(['Best Linear Model: y=',num2str(a(BestLoc)),'x+',num2str(b(BestLoc)),' with Test MSE=',num2str(LinearError(BestLoc)) ])
    Linear = @(z) a(BestLoc)*z+b(BestLoc);
    
    
    
    %quadratic
    parfor i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C] = QuadraticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C;
        
        f = @(z) A*z.^2+B*z+C;
        
%         figure(4); 
%         scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
%         plot(sort(X),f(sort(X)),'k')
%         scatter(TEST_X,TEST_Y,'r.'); %hold off
%         legend('Training Set', 'Test Set')
        
        %Get the MSE
        QuadraticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
%         pause(0.01)
    end
%     figure(5); histogram(QuadraticError); title('Quadratic Fit MSEs')
    
    
    BestLoc = find(QuadraticError == min(QuadraticError));
    BestLoc = BestLoc(1);
      
    disp(['Best Quadratic Model: y=',num2str(a(BestLoc)),'x^2+',num2str(b(BestLoc)),'x+',num2str(c(BestLoc)),' with Test MSE=',num2str(QuadraticError(BestLoc))])
    Quadratic = @(z) a(BestLoc)*z.^2+b(BestLoc)*z+c(BestLoc);
    
    
    %cubic
    parfor i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D] = CubicFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D;
        
        f = @(z) A*z.^3+B*z.^2+C*z+D;
        
%         figure(6); 
%         scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
%         plot(sort(X),f(sort(X)),'k')
%         scatter(TEST_X,TEST_Y,'r.'); %hold off
%         legend('Training Set', 'Test Set')
        
        %Get the MSE
        CubicError(i) = mean((f(TEST_X)-TEST_Y).^2);

%         pause(0.01)
    end
%         
%     figure(7); histogram(CubicError)
%     title('Cubic Fit MSEs')
        
    BestLoc = find(CubicError == min(CubicError));
    BestLoc = BestLoc(1);
      
    disp(['Best Cubic Model: y=',num2str(a(BestLoc)),'x^3+',num2str(b(BestLoc)),'x^2+',num2str(c(BestLoc)),'x+',num2str(d(BestLoc)),' with Test MSE=',num2str(CubicError(BestLoc))])
    Cubic = @(z) a(BestLoc)*z.^3+b(BestLoc)*z.^2+c(BestLoc)*z+d(BestLoc);
    
    
     %quartic
    parfor i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D E] = QuarticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D; e(i) = E;
        
        f = @(z) A*z.^4+B*z.^3+C*z.^2+D*z+E;
        
%         figure(8); 
%         scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
%         plot(sort(X),f(sort(X)),'k')
%         scatter(TEST_X,TEST_Y,'r.'); %hold off
%         legend('Training Set', 'Test Set')
        
        %Get the MSE
        QuarticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
        
%         pause(0.01)
    end
%     
%     figure(9); histogram(QuarticError)
%     title('Quartic Fit MSEs')
    
    BestLoc = find(QuarticError == min(QuarticError));
    BestLoc = BestLoc(1);
      
    disp(['Best Quartic Model: y=',num2str(a(BestLoc)),'x^4+',num2str(b(BestLoc)),'x^3+',num2str(c(BestLoc)),'x^2+',num2str(d(BestLoc)),'x+',num2str(e(BestLoc)),' with Test MSE=',num2str(QuarticError(BestLoc))])
    Quartic = @(z) a(BestLoc)*z.^4+b(BestLoc)*z.^3+c(BestLoc)*z.^2+d(BestLoc)*z+e(BestLoc);
    
    
         %quintic
    parfor i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D E G] = QuinticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D; e(i) = E; g(i)=G;
        
        f = @(z) A*z.^5+B*z.^4+C*z.^3+D*z.^2+E*z+G;
        
%         figure(10); 
%         scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
%         plot(sort(X),f(sort(X)),'k')
%         scatter(TEST_X,TEST_Y,'r.'); %hold off
%         legend('Training Set', 'Test Set')
        
        %Get the MSE
        QuinticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
        
%         pause(0.01)
    end
    
%     figure(11); histogram(QuinticError)
%     title('Quintic Fit MSEs')
    
    BestLoc = find(QuinticError == min(QuinticError));
    BestLoc = BestLoc(1);
      
    disp(['Best Quintic Model: y=',num2str(a(BestLoc)),'x^5+',num2str(b(BestLoc)),'x^4+',num2str(c(BestLoc)),'x^3+',num2str(d(BestLoc)),'x^2+',num2str(e(BestLoc)),'x+',num2str(g(BestLoc)),' with Test MSE=',num2str(QuinticError(BestLoc))])
    Quintic = @(z) a(BestLoc)*z.^5+b(BestLoc)*z.^4+c(BestLoc)*z.^3+d(BestLoc)*z.^2+e(BestLoc)*z+g(BestLoc);
    
    
    
    
    figure(12)
    scatter([2 3 4 5 6],[mean(LinearError),mean(QuadraticError),mean(CubicError),mean(QuarticError),mean(QuinticError)]); hold on
    errorbar([2 3 4 5 6],[mean(LinearError),mean(QuadraticError),mean(CubicError),mean(QuarticError),mean(QuinticError)],[std(LinearError),std(QuadraticError),std(CubicError),std(QuarticError),std(QuinticError)]/sqrt(Iterations)); hold off
    xlabel('Flexibility'); ylabel('Average MSE')
    title('Average MSE by Parameter and Std Error')
    
    figure(13)
    scatter(X,Y,'k.'); hold on
    X=sort(X);
    plot(X,Linear(X),'r')
    plot(X,Quadratic(X),'g')
    plot(X,Cubic(X),'b');
    plot(X,Quartic(X),'k');
    plot(X,Quintic(X),'m');hold off
    title('Best Models')
    
    
    
end


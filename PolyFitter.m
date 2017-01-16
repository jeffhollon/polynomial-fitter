function [  ] = PolyFitter( X, Y, Ratio, Iterations, Graph )
%POLYFITTER Accepts a dataset (X,Y) and returns the best model for it

    close all
    rng shuffle

    X=X(:); Y=Y(:);
    
    n=size(X,1);
    
%     figure(1); scatter(X,Y,'k.')
%     title('Dataset');

    N=round(Ratio*n);  %Training set size
    
    %linear
    for i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B] = LinearFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B;
        
        f = @(z) a(i)*z+b(i);
        
        if Graph
            figure(2); 
            scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
            plot(X,f(X),'b')
            scatter(TEST_X,TEST_Y,'r.'); %hold off
            legend('Training Set', 'Test Set')
        end
        
        %Get the MSE
        LinearError(i) = mean((f(TEST_X)-TEST_Y).^2);
        

%         pause(0.01)
    end
    
     if Graph
         figure(3); histogram(LinearError)
         title('Linear Fit MSEs')
     end
    
    BestLoc = find(LinearError == min(LinearError));
    BestLoc = BestLoc(1);
      
    disp(['Best Linear Model: y=',num2str(a(BestLoc)),'x+',num2str(b(BestLoc)),' with Test MSE=',num2str(LinearError(BestLoc)) ])
    Linear = @(z) a(BestLoc)*z+b(BestLoc);
    
    
    
    %quadratic
    for i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C] = QuadraticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C;
        
        f = @(z) a(i)*z.^2+b(i)*z+c(i);
        
        if Graph
            figure(4); 
            scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
            plot(sort(X),f(sort(X)),'k')
            scatter(TEST_X,TEST_Y,'r.'); %hold off
            legend('Training Set', 'Test Set')
        end
        
        %Get the MSE
        QuadraticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
%         pause(0.01)
    end
    
    if Graph
        figure(5); histogram(QuadraticError); title('Quadratic Fit MSEs')
    end
    
    BestLoc = find(QuadraticError == min(QuadraticError));
    BestLoc = BestLoc(1);
      
    disp(['Best Quadratic Model: y=',num2str(a(BestLoc)),'x^2+',num2str(b(BestLoc)),'x+',num2str(c(BestLoc)),' with Test MSE=',num2str(QuadraticError(BestLoc))])
    Quadratic = @(z) a(BestLoc)*z.^2+b(BestLoc)*z+c(BestLoc);
    
    
    %cubic
    for i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D] = CubicFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D;
        
        f = @(z) a(i)*z.^3+b(i)*z.^2+c(i)*z+d(i);
        
        if Graph
            figure(6); 
            scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
            plot(sort(X),f(sort(X)),'k')
            scatter(TEST_X,TEST_Y,'r.'); %hold off
            legend('Training Set', 'Test Set')
        end
        
        %Get the MSE
        CubicError(i) = mean((f(TEST_X)-TEST_Y).^2);

%         pause(0.01)
    end

    if Graph
        figure(7); histogram(CubicError)
        title('Cubic Fit MSEs')
    end
        
    BestLoc = find(CubicError == min(CubicError));
    BestLoc = BestLoc(1);
      
    disp(['Best Cubic Model: y=',num2str(a(BestLoc)),'x^3+',num2str(b(BestLoc)),'x^2+',num2str(c(BestLoc)),'x+',num2str(d(BestLoc)),' with Test MSE=',num2str(CubicError(BestLoc))])
    Cubic = @(z) a(BestLoc)*z.^3+b(BestLoc)*z.^2+c(BestLoc)*z+d(BestLoc);
    
    
     %quartic
    for i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D E] = QuarticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D; e(i) = E;
        
        f = @(z) a(i)*z.^4+b(i)*z.^3+c(i)*z.^2+d(i)*z+e(i);
    
        if Graph
            figure(8); 
            scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
            plot(sort(X),f(sort(X)),'k')
            scatter(TEST_X,TEST_Y,'r.'); %hold off
            legend('Training Set', 'Test Set')
        end
    
    %Get the MSE
        QuarticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
        
%         pause(0.01)
    end
    
    if Graph
        figure(9); histogram(QuarticError)
        title('Quartic Fit MSEs')
    end
    
    
    BestLoc = find(QuarticError == min(QuarticError));
    BestLoc = BestLoc(1);
      
    disp(['Best Quartic Model: y=',num2str(a(BestLoc)),'x^4+',num2str(b(BestLoc)),'x^3+',num2str(c(BestLoc)),'x^2+',num2str(d(BestLoc)),'x+',num2str(e(BestLoc)),' with Test MSE=',num2str(QuarticError(BestLoc))])
    Quartic = @(z) a(BestLoc)*z.^4+b(BestLoc)*z.^3+c(BestLoc)*z.^2+d(BestLoc)*z+e(BestLoc);
    
    
         %quintic
    for i=1:Iterations
        Locs = randperm(n,N);
        
        TRAIN_X = X(Locs);
        TRAIN_Y = Y(Locs);
        
        TEST_X = X; TEST_X(Locs)=[];
        TEST_Y = Y; TEST_Y(Locs)=[];
        
        [A B C D E G] = QuinticFit(TRAIN_X,TRAIN_Y);
        a(i) = A; b(i) = B; c(i) = C; d(i)=D; e(i) = E; g(i)=G;
        
        f = @(z) a(i)*z.^5+b(i)*z.^4+c(i)*z.^3+d(i)*z.^2+e(i)*z+g(i);
        
        if Graph
            figure(10); 
            scatter(TRAIN_X,TRAIN_Y,'k.'); hold on
            plot(sort(X),f(sort(X)),'k')
            scatter(TEST_X,TEST_Y,'r.'); %hold off
            legend('Training Set', 'Test Set')
        end
        
        %Get the MSE
        QuinticError(i) = mean((f(TEST_X)-TEST_Y).^2);
        
        
%         pause(0.01)
    end
    
    if Graph
        figure(11); histogram(QuinticError)
        title('Quintic Fit MSEs')
    end
    
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
    X1=sort(X);
    plot(X1,Linear(X1),'r')
    plot(X1,Quadratic(X1),'g')
    plot(X1,Cubic(X1),'b');
    plot(X1,Quartic(X1),'k');
    plot(X1,Quintic(X1),'m');hold off
    title('Best Models')
    
    
    
    [A B] = LinearFit(X,Y);
    f1 = @(z) A*z+B;
    [A B C] = QuadraticFit(X,Y);
    f2 = @(z) A*z.^2+B*z+C;
    [A B C D] = CubicFit(X,Y);
    f3 = @(z) A*z.^3+B*z.^2+C*z+D;
    [A B C D E] = QuarticFit(X,Y);
    f4 = @(z) A*z.^4+B*z.^3+C*z.^2+D*z+E;
    [A B C D E F] = QuinticFit(X,Y);
    f5 = @(z) A*z.^5+B*z.^4+C*z.^3+D*z.^2+E*z+F;
    
    %Plot with LS models
    figure(14)
    scatter(X,Y,'k.'); hold on
    plot(X1,f1(X1),'r')
    plot(X1,f2(X1),'g')
    plot(X1,f3(X1),'b');
    plot(X1,f4(X1),'k');
    plot(X1,f5(X1),'m');
    hold off
    title('LS Models')
    
    
end


function main
    clc; 
    close all;
    clear all;
    format long;

    S = input('Enter stock price S [example: S=95]=');
    X = input('Enter strike price X [example: X=100]=');
    H = input('Enter high barrier H [example: H=140]=');
    L = input('Enter low barrier L [example: L=90]=');
    t = input('Enter maturity t [example: t=1]=');
    sigma = input('Enter annual volatility sigma [example: sigma=0.25]=');
    r = input('Enter interest rate r [example: r=0.1] =');
    n = input('Enter number of periods n [example: n=1000]=');
    m = input('Enter number of paths m [example: m=1000]=');
%    S=95; X=100; H=140; L=90; t=1; sigma=0.25; r=0.1; n=1000; m=1000;
    
    deltaT=t/n;
    
    %Detect if there is a problem with the barriers and the stock price
    flagErrorBarriers=0;
    if (L>H)
        disp('ERROR: The Lower barrier (L) is higher than the Higher barrier (H)')
        flagErrorBarriers=1;
    end
    if (L>S)
        disp('ERROR: The Stock price (S) is lower than the Lower barrier (L) ')
        flagErrorBarriers=1;
    end
    if (S>H)
        disp('ERROR: The Stock price (S) is higher than the Higher barrier (H) ')
        flagErrorBarriers=1;
    end
    
    %if there is no problem with the barriers, continue
    if (flagErrorBarriers==0)
        
        %============== trinomail tree =======================
        h=floor(log(H/S)/(sigma*sqrt(deltaT)));
        lambda=log(H/S)/(h*sigma*sqrt(deltaT));
    
        %Calculate the probabilities
        R=exp(r*deltaT);
        pu=1/(2*(lambda^2))+((r-(sigma^2)/2)*sqrt(deltaT))/(2*lambda*sigma);
        pd=1/(2*(lambda^2))-((r-(sigma^2)/2)*sqrt(deltaT))/(2*lambda*sigma);
        pm=1-pu-pd;
        u=exp(lambda*sigma*sqrt(deltaT));
        d=1/u;
    
        %Extra calcultions
        l=floor(log(S/L)/(sigma*lambda*sqrt(deltaT)));
        gamma=-log(L/(S*(d^(l-1))))/(lambda*sigma*sqrt(deltaT));
        a=(r-(sigma^2)/2)*sqrt(deltaT)/(lambda*sigma);
        b=1/(lambda^2);
	
        %Overcalculate probabilites
        pu_L=(b+a*gamma)/(1+gamma);
        pd_L=(b-a)/(gamma+gamma^2);
        pm_L=1-pu_L-pd_L;
    
        C=zeros(1,2*n+1);
        for(i=0:2*n)
            C(i+1)=max(0,S*(d^(n-i))-X);
        end
        C(n+h+1)=0;
        C(n-l+1)=0;
    
        for (j=n-1:-1:0)
            for (i=0:2*j)
                if (i==(j-l+1))
                    C(i+1)=(pd_L*C(i+1)+pm_L*C(i+2)+pu_L*C(i+3))/R;
                else
                    C(i+1)=(pd*C(i+1)+pm*C(i+2)+pu*C(i+3))/R;
                end
            end
            
            if ((h+j)<=2*j)
    			C(h+j+1)=0;
            end
    		if ((j-l)>=0)
                C(j-l+1)=0;
            end
        end
        disp('---------RESULTS---------');
        Y=['Trinomial tree value: ', num2str(sprintf('%0.7f',C(1)))];
        disp(Y)
        
        
        %============= monte carlo method ==================
        D=0;
        D_individual=zeros(1,m+1);
        for i=1:m
            P=S;
            hit=0;
            for j=1:n
                factor=exp(((r-(sigma^2)/2)*(deltaT))+(sigma*sqrt(deltaT)*normrnd(0,1)));
                P=P*factor;
                if ((P>=H)|(P<=L))
                    hit=1;
                    break;
                end
            end
            if (hit==0)
                D=D+max(P-X,0);
                D_individual(i+1)=max(P-X,0);
            end
        end
        monteCarloValue = D*exp(-r*t)/m;
        
        %calculating standard deviation
        D_average=D/m;
        %sum of elements
        suma=0;
        for i=1:m
            suma=suma+(D_individual(i+1)-D_average)^2;
        end
        standardDeviation=sqrt(suma/m);
        
        std2(D_individual);

        Y=['Monte carlo simulation: ', num2str(sprintf('%0.7f',monteCarloValue))];
        disp(Y)
        Y=['Standard deviation: ', num2str(sprintf('%0.7f',standardDeviation))];
        disp(Y)
        disp('-------------------------');
    end
end
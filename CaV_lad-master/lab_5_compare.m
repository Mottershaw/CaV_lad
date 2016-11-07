%% Lab 5 Comparison.

%reworking the code from lab 4 I have rewritten the following code. 
clear
clc
 
%% From lab 3 data to set up the equation 

% This needs to be varifed 
k = [2.9,1.1,0.44];
j = [1.5,1.5,1.3];
Ph=[-0.011,0.0,0.005];
wn = [85,85,85,85];
a = [90000,90000,90000,90000];
kp=9343/470;
%% Creating the transfer function. 

%We are going to need a new transfer function because we have a feed back loop. 
I=[0.5 15 100]
for i=1:3
	%This will load the data for each time of the for loop. 
     T = 1/4;
     
	if i==1
        load 0_5Hz_lab5.txt;
        time = X0_5Hz_lab5(:,1);
        X = X0_5Hz_lab5(:,2);
        Y = X0_5Hz_lab5(:,3);
        A = max(X);
        clear x0_5Hz_lab5
        
        t = linspace(0,2*T,1000);
	end
	
	if i==2
        load 15HZ_lab5_T2.txt;
        time = X15HZ_lab5_T2(:,1);
        X = X15HZ_lab5_T2(:,2);
        Y = X15HZ_lab5_T2(:,3);
        A = max(X);
        clear X15Hz_lab5
        
        t = linspace(0,2*T,2000);
	end
	
	if i==3
        load 100Hz_lab5.txt;
        time = X100Hz_lab5(:,1);
        X = X100Hz_lab5(:,2);
        Y = X100Hz_lab5(:,3);
        A = max(X);
        clear X100Hz_lab5
        
        t = linspace(0,2*T,2000);
	end

	num1 = [0 0 k(i)*wn(i)^2];
	den1 = [1 2*j(i)*wn(i) wn(i)^2];
	num2 = [0 1 ];
	den2 = [1/a(i) 1];
	[num,den] = series(num1,den1,num2,den2);  % this is adding the two different systems together. 
	
	    sys1=tf(num,den) %  sets up the transfer funciton for the feed back. 
	    H=feedback(sys1,1) % This Creats the Feed back 
	x = 0; y = 0; 
    T=T+Ph(i)

		%% this is for each frequecy  
		for n = 1:2:30
			an = 8*A/(pi*n)^2;
			x = x + an*cos(2*pi*n*(t - T/4)/T);
			[m,p] = bode(H,2*pi*n/T);
			y = y + an*m*cos(2*pi*n*(t - T/4)/T + p*pi/180);
		end 
	figure(i)
	plot(t,X,t,Y,t,x,t,y)
	title('At 0.5 Hx')
	xlabel('time response')
	ylabel('Magnitude (V)')
	legend('Experimental input','Experimental output','Simulation input','Simulation output') 

end



%% Lab 5 Comparison.

%reworking the code from lab 4 I have rewritten the following code. 
clear
clc

%% loading the data for 0.5Hz

load 0_5Hz.txt;
time = X4Hz(:,1);
X4 = X4Hz(:,2);
Y4 = X4Hz(:,3);
A = max(X4);

clear x0_5Hz % this is to free up Ram on the computer. 
%% From lab 3 data to set up the equation 

% This needs to be varifed 
k = [1.6,1.6,1.2];
j = [1.5,1.5,1.5,1.5];
wn = [85,85,85,85];
a = [90000,90000,90000,90000];
%% Creating the transfer function. 

%We are going to need a new transfer function because we have a feed back loop. 

for i=1:3
	%This will load the data for each time of the for loop. 
	if i==1
	load 0_5Hz.txt;
	time = X0_5Hz(:,1);
	X = X0_5Hz(:,2);
	Y = X0_5Hz(:,3);
	A = max(X);
	clear x0_5Hz
	end
	
	if i==2
	load 15Hz.txt;
	time = X15Hz(:,1);
	X = X15Hz(:,2);
	Y = X15Hz(:,3);
	A = max(X);
	clear Hz
	end
	
	if i==3
	load 100Hz.txt;
	time = X100Hz(:,1);
	X = X100Hz(:,2);
	Y = X100Hz(:,3);
	A = max(X4);
	end
	


	num1 = [0 0 k(n)*wn(i)^2];
	den1 = [1 2*j(i)*wn(i) wn(i)^2];
	num2 = [0 1 ];
	den2 = [1/a(i) 1];
	[num,den] = series(num1,den1,num2,den2);  % this is adding the two different systems together. 

	x = 0; y = 0;  T = 1/4;
	t = linspace(0,2*T,2000);

		%% this is for 4Hz
		for n = 1:2:30
			an = 8*A/(pi*n)^2;
			x = x + an*cos(2*pi*n*(t - T/4)/T);
			[m,p] = bode(num,den,2*pi*n/T);
			y = y + an*m*cos(2*pi*n*(t - T/4)/T4 + p*pi/180);
		end 
	figure(i)
	plot(t,X4,t,Y4,t,x4,t,y4)
	title('At 4 Hz')
	xlabel('time response')
	ylabel('Magnitude (V)')
	legend('Experimental input','Experimental output','Simulation input','Simulation output') 

end



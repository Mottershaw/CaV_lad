%% This is to check that the data is good for lab 5

% Getting the data 
clear
clc


load 0_5Hz_lab5.txt
 load 15Hz_lab5.txt
 
 A=X0_5Hz_lab5(:,2);
 B=X15Hz_lab5(:,2);
 
 
 y=['a' 'b' 'e']
 y(1)
 %%
 Check=Zeros(1000); 
 for i=1:length(A)
     if A(i)==B(i+1)
         Check(i)=1
         fail=1
     else
         Check(i)=0;
     end
 end
 
 Check
 
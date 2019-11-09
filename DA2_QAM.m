%This is the code for QAM in a specified order by the user.
clc
clear all
close all

[y2,Fs2] = audioread('DCS 1 min.m4a'); %Input audio file of my speech
figure(1);
t = 0:1/Fs2:(length(y2)-1)/Fs2;
plot(t,y2); %Display the input audio file
xlabel('Time')
ylabel('Amplitude')
title('Input Audio Signal');
hold on;


N2 = input('Enter the no. of quantization levels : '); %Quantization levels need to be entered
figure(3);
maxa = max(y2); 
mina = min(y2);
index = (maxa-mina)/(N2-1); 
u = maxa + index;
level = [mina:index:maxa];  
co = [mina:index:u]; 
[index,y3] = quantiz(y2,level,co); 
t = 0:1/Fs2:(length(y2)-1)/Fs2;
plot(t,y3); %Quantized signal is displayed
xlabel('Time')
ylabel('Discretized Amplitude')
title('Quantized Audio Signal');

N3 = input('Enter the Modulation order to perform QAM : '); %Order of QAM is to be entered
y4 = uint8((y3 - level(1))/((maxa-mina)/(N2-1)));
y5 = qammod(y4,N3);
scatterplot(y5); %Display
xlabel('In-Phase')
ylabel('Quadrature')
title('Scatter Plot');

y6 = qammod(y4,N3,'PlotConstellation',true);
xlabel('In Phase')
ylabel('Quadrature')
title('128-QAM');
%%%% ENTWURF EINES FEDERHALLS - DESIGN OF A SPRING REVERBERATOR %%%%

%%% Beuth Hochschule fuer Technik Berlin 
%%% Audiotechnik Uebung - WiSe 20/21 
%%% Gruppe 7: Jan Abel, Pierre-Hugues Hadacek, Steven Thiele
%%% Dozent: Herr Pr.Dr. Andre Jakob

%%  TEIL 1
%%% Sonstiges 

clear all; home; close all; clc;

Fs = 48000;
Ts = 1/Fs;

%dummy variable
sample_N = 240000;
t = [0:Ts:(sample_N-1)*Ts];

%%  TEIL 2
%%% Physikalische Eigenschaften | Physical Parameters 

%Hier werden die Eigenschaften eines Feders eingetragen | The properties of a given spring are entered here.
%Model: Olson X-82

%Laenge des Helix der Feder | Length of Helix[m]
spring_parameter.h_length = 0.065;

%Durchmesser des Helix der Feder | Helix  Diameter[m]
spring_parameter.h_diam = 0.0054;

%Durchmesser des Drahts | Diameter of the wire[m]
spring_parameter.f_diam = 0.00035;

%Anzahl der Windungen | Number of Turns of the Spring[1]
spring_parameter.turns = 148;

%Flaeche Querschnitt des Drahts | Area of round Wire[m^2]   
spring_parameter.A = pi*(spring_parameter.f_diam/2)^2;

%Dichte | Density of Steel[kg*m^-3]
spring_parameter.rho = 7800;                   

%Elastizitaetsmodul | Young's Modulus of Steel[N*m^-2]
spring_parameter.E = 2^11;

%Flaechentraegheitsmoment | Second Moment of Area[m^4]
spring_parameter.I = (pi*(spring_parameter.h_diam/2)^4)/4;

%Laenge des gesamten Drahts | Length of the whole wire[m]
spring_parameter.L = sqrt((2*pi*spring_parameter.turns*...
    spring_parameter.h_diam/2)^2+spring_parameter.h_length^2);
% spring_parameter.L = 10

%Alle Eigenschaften in einer Variable gesammelt | All Parameter summarized in One Variable 'kappa'[m^2 * s^-1]
spring_parameter.kappa = sqrt((spring_parameter.E * spring_parameter.I)/(spring_parameter.rho * spring_parameter.A));

%%  TEIL 3
%%% Resonanzfrequenzen | Resonance Frequencies 

%Vektor der Modenformen | Linearly spaced vector of modes
n = linspace(1,2744, 2744);

%Vektor der Resonanzfrequenzen | Vector of resonance frequencies
fr_all = 0.5*pi*spring_parameter.kappa*spring_parameter.L^(-2)*n.^2;
fr = fr_all(1:24:2454);


%Vector mit 10 Colundi Frequenzen
fr_colundi = zeros(1,10);
fr_colundi(1,1)= fr_all(1,27);
fr_colundi(1,2)= fr_all(1,43);
fr_colundi(1,3)= fr_all(1,75);
fr_colundi(1,4)= fr_all(1,112);
fr_colundi(1,5)= fr_all(1,158);
fr_colundi(1,6)= fr_all(1,295);
fr_colundi(1,7)= fr_all(1,473);
fr_colundi(1,8)= fr_all(1,610);
fr_colundi(1,9)= fr_all(1,1028);
fr_colundi(1,10)= fr_all(1,1226);

%%  TEIL 4
%%% Uebertragungsfunktionen und Impulsantworten | Transfer Functions and Impulse Responses

%Hier werden die Ubertragungsfunktionen und Impulsantworten berechnet

%Daempfung | Damping factor
D = 0.001;   % Beliebig

%Erzeugung der Uebertragungsfunktionen | Generation of transfer functions 

%Optimales Design
for k = 1:length(fr)
    name = strcat('G',num2str(k));
    HP2_Order_continous.(name) = create_TF(fr(1,k), D);                        % Continuous
    HP2_Order_discrete.(name) = HP2_Order_continous.(name);
    HP2_Order_discrete.(name) = c2d(HP2_Order_discrete.(name),Ts, 'Tustin');    % Discrete
end


%10 Colundi Frequencies Design
% for k=1:10
%     name = strcat('G',num2str(k));
%     HP2_Order_continous.(name) = create_TF(fr_colundi(1,k), D);
%     HP2_Order_discrete.(name) = HP2_Order_continous.(name);
%     HP2_Order_discrete.(name)= c2d(HP2_Order_discrete.(name),Ts, 'Tustin');
% end

%Erzeugung der Impulsantworten | Generation of impulse responses
for k = 1:length(fr)
    name = strcat('G',num2str(k));
    ir_continous.(name)=impulse(HP2_Order_continous.(name),t);
    ir_discrete.(name)=impulse(HP2_Order_discrete.(name),t);
end

%Addieren aller Impulsantworten | Sum of all impulse responses
ir_continous_sum = zeros(length(ir_continous.G1),1);
ir_discrete_sum = zeros(length(ir_discrete.G1),1);

for k = 1:length(fr)
    name = strcat('G',num2str(k));
    ir_continous_sum = ir_continous_sum+ir_continous.(name);
    ir_discrete_sum = ir_discrete_sum+ir_discrete.(name);
end

%Normierung
ir_continous_sum_norm = ir_continous_sum/norm(ir_continous_sum);
ir_discrete_sum_norm = ir_discrete_sum/norm(ir_discrete_sum);

%Spektrogramm
%figure (1)
%spectrogram(ir_discrete_sum);

%%  TEIL 5
%%% Speicherung als .wav Datei | Export of summed impulse response as .wav file

%Die Impulsantwort wird als .wav datei exportiert zur weiteren Benutzung | 
audiowrite('IR_discrete.wav', ir_discrete_sum_norm, Fs);


%%  TEIL 7
%%% Grafische Darstellung der Impulsantworten

%Hier werden die Impulsantwort und Bode-Diagramm des Systems dargestellt |  Impulse response und Bode diagram are being plotted here 

%Impulsantwort
figure(2)
 
subplot(2,2,1)
plot( t , ir_continous_sum);
axis([0 1 -1*10^4 10^4])
grid on;
title('IR - Continous')
 
subplot(2,2,2)
plot( t ,ir_continous_sum_norm);
grid on;
axis([0 1 -0.25 0.25])
title('IR - Continous (normalized)')
 
 
subplot(2,2,3)
plot( t , ir_discrete_sum);
axis([0 1 -1*10^4 10^4])
grid on;
title('IR - Discrete')
 
subplot(2,2,4)
plot( t , ir_discrete_sum_norm);
grid on;
axis([0 1 -0.25 0.25])
title('IR - Discrete (normalized)')
 
%Bode-diagramm
fft_IR_discrete = fft(ir_discrete_sum)*Ts; 
 
fmax = 1/(2.*Ts);
df=1/((sample_N-1)*Ts);
f=-fmax:df:fmax;
 
Sshift = fftshift(fft_IR_discrete);
Skomp = transpose(Sshift).*exp(-j*2*pi*f*(Ts/2));
 
mag = 20*log10(abs(Skomp));
phase = rad2deg(angle(Skomp));
 
figure (3)
 
subplot(2,1,1)
semilogx(f,mag)
grid on
title('Amplitude')
xlabel('f in Hz')
ylabel('|Mag| (dB)')
 
subplot(2,1,2)
semilogx(f,phase)
title('Phase')
xlabel('f in Hz')
ylabel('Phase in degree')

%%  TEIL 6
%%% Algorithmus zur Erzeugung einer Uebertragungsfunktion | Algorithm to create transfer function

function[S_HP2] = create_TF(resonance_freq,damping_factor)
    
%     arguments
%         resonance_freq double
%         damping_factor double
%     end
    
    w_k=2*pi*resonance_freq;
    d=damping_factor;
    
    num=[1 0 0];
    den = [1 2*w_k*d w_k^2];
    S_HP2=tf(num, den);
end
%%%% ENTWURF EINES FEDERHALLS - DESIGN OF A SPRING REVERBERATOR %%%%

%%% Beuth Hochschule f�r Technik Berlin 
%%% Audiotechnik �bung - WiSe 20/21 
%%% Gruppe 7: Jan Abel, Pierre-Hugues Hadacek, Steven Thiele
%%% Dozent: Herr Pr.Dr. Andr� Jakob

%% 	TEIL 1
%%% Sonstiges 

clear all; home; close all; clc;

%% 	TEIL 2
%%% Importierung und grafische Darstellung der Audiodatei | Import and graphic display of audio file

[in,Fs]=audioread('hier_audio_eingeben.wav');
in_left = in(:,1);
in_right = in(:,2); 

t=[0:length(in)-1];     %Sample Axis
t2=[0:length(in)-1]*Ts; %Time Axis

figure(1)
plot(t,in);
xlabel('Sample [n]')
ylabel('Amplitude')
title('Waveform of selected sample [Sample Axis]')

plot(t2,in);
xlabel('Time [s]')
ylabel('Amplitude')
title('Waveform of selected sample [Time Axis]')

%% 	TEIL 3
%%% Importierung der Impulsantwort | Import of impulse response

[h,Fs]=audioread('hier_IR_eingeben.wav');

% if stereo IR:
h_left = h(:,1);
h_right = h(:,1);

%% 	TEIL 4
%%% Faltung | Convolution

% out = conv(in,h);

%%% Stereo Faltung

out_left = conv(h_left,in_left);
out_right = conv(in_right,h_right);

out = [out_left,out_right];
audiowrite('hier_name_eingeben.wav',out,Fs)

%% 	TEIL 5
%%% Tonausgabe | Audio output

%Play original audio
% sound(in,Fs);

%Play processed sound
% sound(out,Fs);

%% 	TEIL 6
%%% Grafische Darstellung der bearbeiteten Audiodatei | Grafic display of processed audio

figure(1)

plot(length(out),out);
xlabel('Sample [n]')
ylabel('Amplitude')
title('Waveform of convoluted sample [Sample Axis]')
hold on

plot(t2,out);
xlabel('Time [s]')
ylabel('Amplitude')
title('Waveform of convoluted sample [Time Axis]')
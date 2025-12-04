clear all, close all, clc;

% Load S-parameters from s1p file
S = sparameters('REAL_ANT.s1p');
freq = S.Frequencies;  % Frequency in Hz
S11 = squeeze(S.Parameters(1,1,:));
    
% Convert to dB (use 20log for voltages)
S11_dB = 20*log10(abs(S11));

figure;
tiledlayout(1,2);
    
% S11
nexttile;
semilogx(freq .* 10^-6, S11_dB, 'b','LineWidth',1.5);
xlabel('Frequency (MHz)');
ylabel('|S11| (dB)');
title('S11');
xlim([20 30]);
hold on;
grid on;

% Surrogate frequencies
xline(21.450, 'label', '21.450');
xline(24.890, 'label', '24.890');

% Actual frequencies
xline(20.510, 'r', 'label', '20.510');
xline(21.460, 'r', 'label', '21.460');
xline(23.180, 'r', 'label', '23.180');
xline(24.450, 'r', 'label', '24.450');
xline(26.875, 'r', 'label', '26.875');

VSWR = (1 + abs(S11)) ./ (1 - abs(S11));

% VSWR
nexttile;
semilogx(freq .* 10^-6, VSWR, 'r','LineWidth',1.5);
xlabel('Frequency (MHz)');
ylabel('VSWR');
title('VSWR');
hold on;
grid on;
xlim([20 30]);
ylim([1 10]);

% Surrogate frequencies
xline(21.025, 'label', '21.025');
xline(21.200, 'label', '21.200');
xline(21.275, 'label', '21.275');
xline(21.450, 'label', '21.450');
xline(24.890, 'label', '24.890');
xline(24.990, 'label', '24.990');
xline(28.000, 'label', '28.000');
xline(29.700, 'label', '29.700');

% General License Operating Regions
%xregion(14.025, 14.150, [0.8 0.8 0.8]); % 20m
%xregion(14.225, 14.350, [0.8 0.8 0.8]); % 20m
%xregion(18.068, 18.168, [0.8 0.8 0.8]); % 17m
%xregion(21.025, 21.200, [0.8 0.8 0.8]); % 15m
%xregion(21.275, 21.450, [0.8 0.8 0.8]); % 15m
%xregion(24.890, 24.990, [0.8 0.8 0.8]); % 12m
%xregion(28.000, 29.700, [0.8 0.8 0.8]); % 10m

Y_points = [1, 10, 10, 1];

fill([21.025, 21.025, 21.200, 21.200], Y_points, [0.8 0.8 0.8], 'FaceAlpha', 0.75, 'EdgeColor', 'none'); 
fill([21.275, 21.275, 21.450, 21.450], Y_points, [0.8 0.8 0.8], 'FaceAlpha', 0.75, 'EdgeColor', 'none'); 
fill([24.890, 24.890, 24.990, 24.990], Y_points, [0.8 0.8 0.8], 'FaceAlpha', 0.75, 'EdgeColor', 'none'); 
fill([28.000, 28.000, 29.700, 29.700], Y_points, [0.8 0.8 0.8], 'FaceAlpha', 0.75, 'EdgeColor', 'none'); 

% Actual frequencies
xline(20.510, 'r', 'label', '20.510');
xline(21.460, 'r', 'label', '21.460');
xline(23.180, 'r', 'label', '23.180');
xline(24.450, 'r', 'label', '24.450');
xline(26.875, 'r', 'label', '26.875');

% Create Smith chart
%figure('Name','Smith Chart from .s1p file','NumberTitle','off');
%smithplot(S11);

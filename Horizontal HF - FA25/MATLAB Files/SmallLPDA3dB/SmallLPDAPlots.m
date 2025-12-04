clear all, close all, clc;

% This code plots the 3dB beamwidth of the SAS-510-2 small LPDA for 2GHz,
% 446MHz, and 290MHz

%% Settings
dataFile = 'lpda_pattern.csv';
Pt_dBm = -20;                       
nFreqBlocks = 3;                    
freqs_GHz = [2.00, 0.446, 0.29];    
dists_m = [0.12, 0.7472, 1.2192];   
normalize = true;                   

%% Import data
opts = detectImportOptions(dataFile);
opts.DataLines = [3 Inf];           
T = readtable(dataFile, opts);
A = table2array(T);

figure;
tiledlayout(1,3,"TileSpacing","compact","Padding","compact");

for blk = 1:nFreqBlocks
    c0 = (blk-1)*4 + 1;

    distance_m        = A(:,c0);     
    distance_power_dBm= A(:,c0+1);

    nexttile;
    plot(distance_m, distance_power_dBm, 'o-','LineWidth',1.5);
    xlabel('Distance (m)');
    ylabel('Power (dBm)');
    grid on;
    title(sprintf('%.3f GHz: Distance Sweep', freqs_GHz(blk)));
    hold on;

    % −3 dB threshold
    thr3dB = max(distance_power_dBm) - 3;
    yline(thr3dB,'r--','LineWidth',1.5);

    % Find crossings
    crossings = find((distance_power_dBm(1:end-1) > thr3dB & distance_power_dBm(2:end) <= thr3dB) | ...
                     (distance_power_dBm(1:end-1) < thr3dB & distance_power_dBm(2:end) >= thr3dB));

    dist_cross_vals = [];
    for k = 1:length(crossings)
        i1 = crossings(k);
        i2 = i1 + 1;
        t = (thr3dB - distance_power_dBm(i1)) / (distance_power_dBm(i2) - distance_power_dBm(i1));
        x_cross = distance_m(i1) + t*(distance_m(i2)-distance_m(i1));
        dist_cross_vals(end+1) = x_cross;
        plot(x_cross, thr3dB, 'ro','MarkerFaceColor','r','MarkerSize',6);
    end
end

figure;
tiledlayout(1,3,"TileSpacing","compact","Padding","compact");

for blk = 1:nFreqBlocks
    c0 = (blk-1)*4 + 1;

    angle_deg       = A(:,c0+2);
    angle_power_dBm = A(:,c0+3);

    P = angle_power_dBm;
    if normalize
        P = P - max(P);
    end

    theta = deg2rad(angle_deg);

    nexttile;
    polarplot(theta, P, 'LineWidth', 2);
    hold on;
    rlim([-30 0]);
    rticks([-30 -20 -10 0]);
    title(sprintf('%.3f GHz: Azimuth (dist = %.3f m)', freqs_GHz(blk), dists_m(blk)));

    % −3 dB circle
    polarplot(linspace(0,2*pi,360), -3*ones(1,360), 'r--','LineWidth',1.2);

    % Find crossings
    crossings = find((P(1:end-1) > -3 & P(2:end) <= -3) | (P(1:end-1) < -3 & P(2:end) >= -3));
    for k = 1:length(crossings)
        i1 = crossings(k); i2 = i1+1;
        t = (-3 - P(i1)) / (P(i2)-P(i1));
        theta_cross = theta(i1) + t*(theta(i2)-theta(i1));

        polarplot(theta_cross, -3, 'ro','MarkerFaceColor','r','MarkerSize',6);
        polarplot([theta_cross theta_cross], [0 -30], 'r-', 'LineWidth',1.5);
    end
end

% Distance sweeps overlay
figure; hold on; grid on;
for blk = 1:nFreqBlocks
    c0 = (blk-1)*4 + 1;
    distance_m        = A(:,c0);
    distance_power_dBm= A(:,c0+1);

    plot(distance_m, distance_power_dBm, 'LineWidth',1.5, ...
        'DisplayName', sprintf('%.3f GHz', freqs_GHz(blk)));
end
xlabel('Distance (m)');
ylabel('Power (dBm)');
title('Overlay of Distance Sweeps');
legend('show','Location','best');

% Azimuth overlay
figure;
pax = polaraxes; hold(pax,'on');
for blk = 1:nFreqBlocks
    c0 = (blk-1)*4 + 1;

    angle_deg = A(:,c0+2);
    P = A(:,c0+3);
    if normalize
        P = P - max(P);
    end
    theta = deg2rad(angle_deg);
    polarplot(pax, theta, P, 'LineWidth', 1.8, ...
        'DisplayName', sprintf('%.3f GHz', freqs_GHz(blk)));

    polarplot(pax, linspace(0,2*pi,360), -3*ones(1,360), 'r--','HandleVisibility','off');
end
rlim(pax,[-30 0]);
rticks(pax,[-30 -20 -10 0]);
title(pax,'Overlay of Azimuth Patterns');
legend(pax,'show','Location','bestoutside');

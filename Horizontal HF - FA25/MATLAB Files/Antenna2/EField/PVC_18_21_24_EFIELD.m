clear all, close all, clc;

dataFile21 = 'PVC_21_Antenna.xlsx';
dataFile18 = 'PVC_18_Antenna.xlsx';
dataFile24 = 'PVC_24_Antenna.xlsx';

D21 = readmatrix(dataFile21);
D18 = readmatrix(dataFile18);
D24 = readmatrix(dataFile24);

N1 = 12;
N2 = 11;

%% 21.025 MHz
dist1 = D21(1,1);
dist2 = D21(1,8);
dist3 = D21(1,15);

horiz1 = D21(:,2);
horiz2 = D21(:,9);
horiz3 = D21(:,16);

Xavg1 = D21(:,3);
Xavg2 = D21(:,10);
Xavg3 = D21(:,17);

Yavg1 = D21(:,4);
Yavg2 = D21(:,11);
Yavg3 = D21(:,18);

Zavg1 = D21(:,5);
Zavg2 = D21(:,12);
Zavg3 = D21(:,19);

mag1 = D21(:,6);
mag2 = D21(:,13);
mag3 = D21(:,20);

%% 18.168 MHz
dist5 = D18(1,1);
dist6 = D18(1,8);
dist7 = D18(1,15);

horiz5 = D18(:,2);
horiz6 = D18(:,9);
horiz7 = D18(:,16);

Xavg5 = D18(:,3);
Xavg6 = D18(:,10);
Xavg7 = D18(:,17);

Yavg5 = D18(:,4);
Yavg6 = D18(:,11);
Yavg7 = D18(:,18);

Zavg5 = D18(:,5);
Zavg6 = D18(:,12);
Zavg7 = D18(:,19);

mag5 = D18(:,6);
mag6 = D18(:,13);
mag7 = D18(:,20);

%% 24.890 MHz
dist8 = D24(1,1);
dist9 = D24(1,8);
dist10 = D24(1,15);

horiz8 = D24(:,2);
horiz9 = D24(:,9);
horiz10 = D24(:,16);

Xavg8 = D24(:,3);
Xavg9 = D24(:,10);
Xavg10 = D24(:,17);

Yavg8 = D24(:,4);
Yavg9 = D24(:,11);
Yavg10 = D24(:,18);

Zavg8 = D24(:,5);
Zavg9 = D24(:,12);
Zavg10 = D24(:,19);

mag8 = D24(:,6);
mag9 = D24(:,13);
mag10 = D24(:,20);

%% Max and half max

YavgA = [Yavg1; Yavg2; Yavg3];
YavgB = [Yavg5; Yavg6; Yavg7];
YavgC = [Yavg8; Yavg9; Yavg10];

Max1 = max(YavgA);
Max2 = max(YavgB);
Max3 = max(YavgC);

halfmax1 = Max1 ./ 2;
halfmax2 = Max2 ./ 2;
halfmax3 = Max3 ./ 2;

% Group variables into cells to avoid repetitive code
dist   = [dist1 dist2 dist3 dist5 dist6 dist7 dist8 dist9 dist10];
horiz  = {horiz1, horiz2, horiz3, horiz5, horiz6, horiz7, horiz8, horiz9, horiz10};
Xavg   = {Xavg1,  Xavg2,  Xavg3,  Xavg5,  Xavg6, Xavg7, Xavg8, Xavg9, Xavg10};
Yavg   = {Yavg1,  Yavg2,  Yavg3,  Yavg5,  Yavg6, Yavg7, Yavg8, Yavg9, Yavg10};
Zavg   = {Zavg1,  Zavg2,  Zavg3,  Zavg5,  Zavg6, Zavg7, Zavg8, Zavg9, Zavg10};
mag    = {mag1,   mag2,   mag3,   mag5,   mag6,  mag7, mag8, mag9, mag10};

%% 21.025 MHz xy plots
for k = 1:3
    figure;
    hold on;

    yline(halfmax1);
    plot(horiz{k}, Xavg{k}, 'DisplayName','Xavg');
    plot(horiz{k}, Yavg{k}, 'DisplayName','Yavg');
    plot(horiz{k}, Zavg{k}, 'DisplayName','Zavg');
    plot(horiz{k}, mag{k},  'DisplayName','Magnitude');

    title(sprintf('Plot of E-field magnitude for 21.025 MHz at %d, dist = %.2f ft', k, dist(k)));
    xlabel('Horizontal position (ft)');
    ylabel('E-Field Stength (V/m)');

    grid on;
    legend;
end

%% 18.168 MHz MHz xy plots
for k = 4:6
    figure;
    hold on;

    yline(halfmax2);
    plot(horiz{k}, Xavg{k}, 'DisplayName','Xavg');
    plot(horiz{k}, Yavg{k}, 'DisplayName','Yavg');
    plot(horiz{k}, Zavg{k}, 'DisplayName','Zavg');
    plot(horiz{k}, mag{k},  'DisplayName','Magnitude');

    title(sprintf('Plot of E-field magnitude for 18.168 MHz at %d, dist = %.2f ft', k, dist(k)));
    xlabel('Horizontal position (ft)');
    ylabel('E-Field Stength (V/m)');

    grid on;
    legend;
end

%% 24.890 MHz MHz xy plots
for k = 7:9
    figure;
    hold on;

    yline(halfmax3);
    plot(horiz{k}, Xavg{k}, 'DisplayName','Xavg');
    plot(horiz{k}, Yavg{k}, 'DisplayName','Yavg');
    plot(horiz{k}, Zavg{k}, 'DisplayName','Zavg');
    plot(horiz{k}, mag{k},  'DisplayName','Magnitude');

    title(sprintf('Plot of E-field magnitude for 24.890 MHz at %d, dist = %.2f ft', k, dist(k)));
    xlabel('Horizontal position (ft)');
    ylabel('E-Field Stength (V/m)');

    grid on;
    legend;
end

figure;
tiledlayout(1,3);


%% 18.168 MHz contour plot 
DistGrid2 = repmat(dist(4:6), N2, 1);    % each column is dist5...dist8
HorizGrid2 = cell2mat(horiz(4:6));      % concatenate horiz5...horiz8
Ymat2 = cell2mat(Yavg(4:6));            % concatenate Yavg5...Yavg8

nexttile;
contourf(HorizGrid2, DistGrid2, Ymat2, 30, 'LineColor','none');
colorbar;
hold on;

% Add half-max contour line
contour(HorizGrid2, DistGrid2, Ymat2, [halfmax2 halfmax2], 'LineColor','k', 'LineWidth', 2);

xlabel('Horizontal position (ft)');
ylabel('Distance from feed (ft)');
title('18.168 MHz Contour map of Yavg (V/m) vs Distance and Horizontal Position (ft)');

grid on;

%% 21.448 MHz contour plot 
DistGrid1 = repmat(dist(1:3), N1, 1);    % each column is dist1...dist4
HorizGrid1 = cell2mat(horiz(1:3));      % concatenate horiz1...horiz4
Ymat1 = cell2mat(Yavg(1:3));            % concatenate Yavg1...Yavg4

nexttile;
contourf(HorizGrid1, DistGrid1, Ymat1, 30, 'LineColor','none');
colorbar;
hold on;

% Add half-max contour line
contour(HorizGrid1, DistGrid1, Ymat1, [halfmax1 halfmax1], 'LineColor','k', 'LineWidth', 2);

xlabel('Horizontal position (ft)');
ylabel('Distance from feed (ft)');
title('21.448 MHz Contour map of Yavg (V/m) vs Distance and Horizontal Position (ft)');
xlim([-17.5 22.5]);

grid on;

%% 24.890 MHz contour plot 
DistGrid3 = repmat(dist(7:9), N1, 1);    % each column is dist5...dist8
HorizGrid3 = cell2mat(horiz(7:9));      % concatenate horiz5...horiz8
Ymat3 = cell2mat(Yavg(7:9));            % concatenate Yavg5...Yavg8

nexttile;
contourf(HorizGrid3, DistGrid3, Ymat3, 30, 'LineColor','none');
colorbar;
hold on;

% Add half-max contour line
contour(HorizGrid3, DistGrid3, Ymat3, [halfmax3 halfmax3], 'LineColor','k', 'LineWidth', 2);

xlabel('Horizontal position (ft)');
ylabel('Distance from feed (ft)');
title('24.890 MHz Contour map of Yavg (V/m) vs Distance and Horizontal Position (ft)');
xlim([-19 21]);
grid on;

%P_r_21 = (abs(5.45082).^2) .* 22.2967 ./ 285.757;
%P_r_24 = (abs(5.02721).^2) .* 22.2967 ./ 336.120;

%P_r_200_21 = (abs(200).^2) .* 22.2967 ./ 285.757;
%P_r_200_24 = (abs(200).^2) .* 22.2967 ./ 336.120;

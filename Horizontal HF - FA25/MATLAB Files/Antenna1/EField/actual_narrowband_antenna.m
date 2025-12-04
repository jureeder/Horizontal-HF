clear all, close all, clc;

dataFile21 = 'freq21.xlsx';
dataFile24 = 'freq24.xlsx';
dataFileExtra = 'whywemoved.xlsx';

D21 = readmatrix(dataFile21);
D24 = readmatrix(dataFile24);
Dextra = readmatrix(dataFileExtra);

N = 21;

%% 21.448 MHz
dist1 = D21(1,1);
dist2 = D21(1,7);
dist3 = D21(1,13);
dist4 = D21(1,19);

horiz1 = D21(:,2);
horiz2 = D21(:,8);
horiz3 = D21(:,14);
horiz4 = D21(:,20);

Xavg1 = D21(:,3);
Xavg2 = D21(:,9);
Xavg3 = D21(:,15);
Xavg4 = D21(:,21);

Yavg1 = D21(:,4);
Yavg2 = D21(:,10);
Yavg3 = D21(:,16);
Yavg4 = D21(:,22);

Zavg1 = D21(:,5);
Zavg2 = D21(:,11);
Zavg3 = D21(:,17);
Zavg4 = D21(:,23);

mag1 = D21(:,6);
mag2 = D21(:,12);
mag3 = D21(:,18);
mag4 = D21(:,24);

%% 24.390 MHz
dist5 = D24(1,1);
dist6 = D24(1,7);
dist7 = D24(1,13);
dist8 = D24(1,19);

horiz5 = D24(:,2);
horiz6 = D24(:,8);
horiz7 = D24(:,14);
horiz8 = D24(:,20);

Xavg5 = D24(:,3);
Xavg6 = D24(:,9);
Xavg7 = D24(:,15);
Xavg8 = D24(:,21);

Yavg5 = D24(:,4);
Yavg6 = D24(:,10);
Yavg7 = D24(:,16);
Yavg8 = D24(:,22);

Zavg5 = D24(:,5);
Zavg6 = D24(:,11);
Zavg7 = D24(:,17);
Zavg8 = D24(:,23);

mag5 = D24(:,6);
mag6 = D24(:,12);
mag7 = D24(:,18);
mag8 = D24(:,24);

%% 24.390 MHz out of 3dB at same reference point justification
dist9 = Dextra(1,1);

horiz9 = Dextra(:,2);

Xavg9 = Dextra(:,3);

Yavg9 = Dextra(:,4);

Zavg9 = Dextra(:,5);

mag9 = Dextra(:,6);

%% Max and half max

halfmax1 = 2.725410396;
halfmax2 = 2.513603812;

max1 = 2.725410396 .* 2;
max2 = 2.513603812 .* 2;

YavgA = [Yavg1; Yavg2; Yavg3; Yavg4];
YavgB = [Yavg5; Yavg6; Yavg7; Yavg8];

Max1 = max(YavgA);
Max2 = max(YavgB);

% Group variables into cells to avoid repetitive code
dist   = [dist1 dist2 dist3 dist4 dist5 dist6 dist7 dist8 dist9];
horiz  = {horiz1, horiz2, horiz3, horiz4, horiz5, horiz6, horiz7, horiz8, horiz9};
Xavg   = {Xavg1,  Xavg2,  Xavg3,  Xavg4,  Xavg5,  Xavg6,  Xavg7,  Xavg8,  Xavg9};
Yavg   = {Yavg1,  Yavg2,  Yavg3,  Yavg4,  Yavg5,  Yavg6,  Yavg7,  Yavg8,  Yavg9};
Zavg   = {Zavg1,  Zavg2,  Zavg3,  Zavg4,  Zavg5,  Zavg6,  Zavg7,  Zavg8,  Zavg9};
mag    = {mag1,   mag2,   mag3,   mag4,   mag5,   mag6,   mag7,   mag8,   mag9};

%% 21.448 MHz xy plots
for k = 1:4
    figure;
    hold on;

    yline(halfmax1);
    plot(horiz{k}, Xavg{k}, 'DisplayName','Xavg');
    plot(horiz{k}, Yavg{k}, 'DisplayName','Yavg');
    plot(horiz{k}, Zavg{k}, 'DisplayName','Zavg');
    plot(horiz{k}, mag{k},  'DisplayName','Magnitude');

    title(sprintf('Plot of E-field magnitude for 21.448 MHz at %d, dist = %.2f ft', k, dist(k)));
    xlabel('Horizontal position (ft)');
    ylabel('E-Field Stength (V/m)');

    grid on;
    legend;
end

%% 24.390 MHz extra xy plot
figure;
hold on;

plot(horiz{9}, Xavg{9}, 'DisplayName','Xavg (V/m)');
plot(horiz{9}, Yavg{9}, 'DisplayName','Yavg (V/m)');
plot(horiz{9}, Zavg{9}, 'DisplayName','Zavg (V/m)');
plot(horiz{9}, mag{9},  'DisplayName','Magnitude (V/m)');

title(sprintf('Plot of E-field magnitude for 24.390 MHz at dist = %.2f ft', dist(9)));
xlabel('Horizontal position (ft)');
ylabel('E-Field Stength (V/m)');

grid on;
legend;

%% 24.390 MHz xy plots
for k = 5:8
    figure;
    hold on;

    yline(halfmax2);
    plot(horiz{k}, Xavg{k}, 'DisplayName','Xavg');
    plot(horiz{k}, Yavg{k}, 'DisplayName','Yavg');
    plot(horiz{k}, Zavg{k}, 'DisplayName','Zavg');
    plot(horiz{k}, mag{k},  'DisplayName','Magnitude');

    title(sprintf('Plot of E-field magnitude for 24.390 MHz at %d, dist = %.2f ft', k, dist(k)));
    xlabel('Horizontal position (ft)');
    ylabel('E-Field Stength (V/m)');

    grid on;
    legend;
end

%% 21.448 MHz contour plot 
DistGrid1 = repmat(dist(1:4), N, 1);    % each column is dist1...dist4
HorizGrid1 = cell2mat(horiz(1:4));      % concatenate horiz1...horiz4
Ymat1 = cell2mat(Yavg(1:4));            % concatenate Yavg1...Yavg4

figure;
contourf(HorizGrid1, DistGrid1, Ymat1, 30, 'LineColor','none');
colorbar;
hold on;

% Add half-max contour line
contour(HorizGrid1, DistGrid1, Ymat1, [halfmax1 halfmax1], 'LineColor','k', 'LineWidth', 2);

xlabel('Distance (ft)');
ylabel('Horizontal position (ft)');
title('21.448 MHz Contour map of Yavg (V/m) vs Distance and Horizontal Position (ft)');

grid on;


%% 24.390 MHz contour plot 
DistGrid2 = repmat(dist(5:8), N, 1);    % each column is dist5...dist8
HorizGrid2 = cell2mat(horiz(5:8));      % concatenate horiz5...horiz8
Ymat2 = cell2mat(Yavg(5:8));            % concatenate Yavg5...Yavg8

figure;
contourf(HorizGrid2, DistGrid2, Ymat2, 30, 'LineColor','none');
colorbar;
hold on;

% Add half-max contour line
contour(HorizGrid2, DistGrid2, Ymat2, [halfmax2 halfmax2], 'LineColor','k', 'LineWidth', 2);

xlabel('Distance (ft)');
ylabel('Horizontal position (ft)');
title('24.390 MHz Contour map of Yavg (V/m) vs Distance and Horizontal Position (ft)');

grid on;


P_r_21 = (abs(5.45082).^2) .* 22.2967 ./ 285.757;
P_r_24 = (abs(5.02721).^2) .* 22.2967 ./ 336.120;

P_r_200_21 = (abs(200).^2) .* 22.2967 ./ 285.757;
P_r_200_24 = (abs(200).^2) .* 22.2967 ./ 336.120;

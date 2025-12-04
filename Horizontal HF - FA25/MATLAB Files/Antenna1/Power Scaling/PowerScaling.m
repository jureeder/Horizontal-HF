clear all, close all, clc;

% Import s2p files and create graph titles
files = {'REAL_ANT.s1p'};
titles = {'S11 Parameter from .s1p file'};

for file = 1:length(files)
    % Load S-parameters from s1p file
    S = sparameters(files{file});
    freq = S.Frequencies;  % Frequency in Hz
    S11 = squeeze(S.Parameters(1,1,:));
    
    % Convert to dB (use 20log for voltages)
    S11_dB = 20*log10(abs(S11));
    
    % S11
    figure;
    semilogx(freq .* 10^-6, S11_dB, 'b','LineWidth',1.5);
    xlabel('Frequency (MHz)');
    ylabel('|S11| (dB)');
    title('S11');
    grid on;

    % S11 (freq limited to 20-30MHz)
    figure;
    semilogx(freq .* 10^-6, S11_dB, 'b','LineWidth',1.5);
    xlabel('Frequency (MHz)');
    ylabel('|S11| (dB)');
    title('S11');
    grid on;
    xlim([20 30]);

    VSWR = (1 + abs(S11)) ./ (1 - abs(S11));

    % VSWR
    figure;
    semilogx(freq .* 10^-6, VSWR, 'r','LineWidth',1.5);
    xlabel('Frequency (MHz)');
    ylabel('VSWR');
    title('VSWR');
    grid on;
    ylim([1 10]);

    % VSWR (freq limited to 20-30MHz)
    figure;
    semilogx(freq .* 10^-6, VSWR, 'r','LineWidth',1.5);
    xlabel('Frequency (MHz)');
    ylabel('VSWR');
    title('VSWR');
    grid on;
    xlim([20 30]);
    ylim([1 10]);

    P_25_dBm = 10 .* log10(25 .* 1000);% 25W Transmit power from radio
    P_t = (1 - abs(S11).^2) .* 25;   
    P_t_dBm = 10 .* log10(P_t .* 1000);

    % P_t
    figure;
    semilogx(freq .* 10^-6, P_t_dBm, 'r','LineWidth',1.5);
    yline(P_25_dBm, 'label', '25W in dBm');
    xlabel('Frequency (MHz)');
    ylabel('P_t (dBm)');
    title('Power Seen by Antenna System P_t');
    ylim([35 45]);
    grid on;

    % P_t (freq limited to 20-30MHz)
    figure;
    semilogx(freq .* 10^-6, P_t_dBm, 'r','LineWidth',1.5);
    yline(P_25_dBm, 'label', '25W in dBm');    
    xlabel('Frequency (MHz)');
    ylabel('P_t (dBm)');
    title('Power Seen by Antenna System P_t');
    grid on;
    ylim([35 45]);
    xlim([20 30]);

    P_balun = 0.5 .* P_t;
    P_balun_dBm = 10 .* log10(P_balun .* 1000);

    % P_t
    figure;
    hold on;
    p1 = semilogx(freq .* 10^-6, P_t_dBm, 'r','LineWidth',1.5);
    p2 = semilogx(freq .* 10^-6, P_balun_dBm, 'b','LineWidth',1.5);
    yline(P_25_dBm, 'label', '25W in dBm');    
    xlabel('Frequency (MHz)');
    ylabel('Power (dBm)');
    title('Power Seen by Antenna and After Balun Loss');
    ylim([35 45]);
    grid on;
    legend([p1 p2], {'P_t in dBm', 'P_{balun} in dBm'}, 'Location', 'best');

    % P_t (freq limited to 20-30MHz)
    figure;
    hold on;
    p1 = semilogx(freq .* 10^-6, P_t_dBm, 'r','LineWidth',1.5);
    p2 = semilogx(freq .* 10^-6, P_balun_dBm, 'b','LineWidth',1.5);
    yline(P_25_dBm, 'label', '25W in dBm');    
    xlabel('Frequency (MHz)');
    ylabel('Power (dBm)');
    title('Power Seen by Antenna and After Balun Loss');
    ylim([35 45]);
    xlim([20 30]);
    grid on;
    legend([p1 p2], {'P_t in dBm', 'P_{balun} in dBm'}, 'Location', 'best');


    % Create Smith chart
    figure('Name',['Smith Chart: ', titles{file}],'NumberTitle','off');

    smithplot(S11);

end

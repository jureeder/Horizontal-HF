clc; clear all; close all;

%test data for 290 MHz
%using average values of Ey
x_290 = [-16, -15, -14, -13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
E_290 = [1.686568119, 1.788660891, 1.924878515, 2.12613901, 2.253908911, 2.369815545, 2.417627129, 2.523678119, 2.640850594, 2.752581485, 2.798532772, 2.682550495, 2.740682079, 2.716780297, 2.783554752, 2.636164356, 2.602337822, 2.674899703, 2.656030198, 2.685714257, 2.583575149, 2.385236634, 2.285359208, 2.153725842, 2.221672673, 2.221378317, 2.111566733, 2.00969297, 2.004134455, 1.736289703, 1.699533564, 1.568020495, 1.52969];
w_290 = 3e8/290e6;
w_290_in = w_290*100/2.54;

x_2000 = [-8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7];
E_2000 = [1.662777228, 2.000701683, 2.306107624, 2.565145743, 2.738097228, 2.937049109, 3.067675149, 3.087552178, 3.058037525, 3.151263663, 3.072188614, 2.897393267, 2.624025941, 2.292172475, 2.167341683, 1.862718911];
w_2000 = 3e8/2e9;
w_2000_in = w_2000*100/2.54;

xq_290 = linspace(min(x_290), max(x_290), 100);
yq_290 = interp1(x_290, E_290, xq_290, 'spline');

x_290_1 = 0;
diff = 10;
for n=1:(length(yq_290)/2)
    new = yq_290(n) - (max(yq_290)/sqrt(2));
    if abs(new) > abs(diff)
        new = 0;
    else
        diff = new;
        x_290_1 = n;
    end
end

x_290_2 = 0;
diff2 = 10;
for n=(length(yq_290)/2):length(yq_290)
    new = yq_290(n) - (max(yq_290)/sqrt(2));
    if abs(new) > abs(diff2)
        new = 0;
    else
        diff2 = new;
        x_290_2 = n;
    end
end

figure(1);
plot(x_290,E_290,'LineWidth',2);
hold on;
plot(xq_290, yq_290, ':', 'LineWidth',2);
xline(xq_290(x_290_1), 'LineWidth', 2);
xline(xq_290(x_290_2), 'LineWidth', 2);
title('Electric Field (E_y) of 290 MHz');
xlabel('Distance (in)');
ylabel('Electric Field (V/m)');
legend('Experimental Data', 'Interpolation');

Width_290 = abs(xq_290(x_290_1)) + xq_290(x_290_2);
fprintf('For 290 MHz: \n');
fprintf('Left most point: %0.3f in\n',xq_290(x_290_1));
fprintf('Right most point: %0.3f in\n',xq_290(x_290_2));
fprintf('3dB Beam Width: %0.3f in\n', Width_290);
fprintf('Wavelength: %0.3f in\n', w_290_in);

xq_2000 = linspace(min(x_2000), max(x_2000), 100);
yq_2000 = interp1(x_2000, E_2000, xq_2000, 'spline');

x_2000_1 = 0;
diff3 = 10;
for n=1:(length(yq_2000)/2)
    new = yq_2000(n) - (max(yq_2000)/sqrt(2));
    if abs(new) > abs(diff3)
        new = 0;
    else
        diff3 = new;
        x_2000_1 = n;
    end
end

x_2000_2 = 0;
diff4 = 10;
for n=(length(yq_2000)/2):length(yq_2000)
    new = yq_2000(n) - (max(yq_2000)/sqrt(2));
    if abs(new) > abs(diff4)
        new = 0;
    else
        diff4 = new;
        x_2000_2 = n;
    end
end

figure(2);
plot(x_2000,E_2000,'LineWidth',2);
hold on;
plot(xq_2000, yq_2000, ':', 'LineWidth',2);
xline(xq_2000(x_2000_1), 'LineWidth', 2);
xline(xq_2000(x_2000_2), 'LineWidth', 2);
title('Electric Field (E_y) of 2 GHz');
xlabel('Distance (in)');
ylabel('Electric Field (V/m)');
legend('Experimental Data', 'Interpolation');

fprintf('\n');
Width_2000 = abs(xq_2000(x_2000_1)) + xq_2000(x_2000_2);
fprintf('For 2000 MHz: \n');
fprintf('Left most point: %0.3f in\n',xq_2000(x_2000_1));
fprintf('Right most point: %0.3f in\n',xq_2000(x_2000_2));
fprintf('3dB Beam Width: %0.3f in\n', Width_2000);
fprintf('Wavelength: %0.3f in\n', w_2000_in);
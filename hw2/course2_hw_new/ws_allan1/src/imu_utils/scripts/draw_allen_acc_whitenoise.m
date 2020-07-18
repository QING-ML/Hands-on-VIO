clear 
close all

dt = dlmread('E:\allan_matlab\data\data_A3_acc_t.txt');         
data_x = dlmread('E:\allan_matlab\data\data_A3_acc_x.txt'); 
data_y = dlmread('E:\allan_matlab\data\data_A3_acc_y.txt'); 
data_z = dlmread('E:\allan_matlab\data\data_A3_acc_z.txt'); 
data_draw=[data_x data_y data_z] ;
data_sim_x= dlmread('E:\allan_matlab\data\data_A3_sim_acc_x.txt'); 
data_sim_y= dlmread('E:\allan_matlab\data\data_A3_sim_acc_y.txt'); 
data_sim_z= dlmread('E:\allan_matlab\data\data_A3_sim_acc_z.txt'); 
data_sim_draw=[data_sim_x data_sim_y data_sim_z] ;

%Kalibration white noise
slope = -0.5;
logtau = log10(dt);
logadev = log10(data_draw);
dlogadev = diff(logadev) ./ diff(logtau);
[~, i] = min(abs(dlogadev - slope));
i_x = i(1);
i_y = i(2);
i_z = i(3);

%%Find the y-intercept of the line
b_x = logadev(i_x) - slope * logtau(i_x);
b_y = logadev(i_y) - slope * logtau(i_y);
b_z = logadev(i_z) - slope * logtau(i_z);
%%Determine the rate random walk coefficient from the line
logK_x = slope * log10(1) + b_x
logK_y = slope * log10(1) + b_y
logK_z = slope * log10(1) + b_z
%k_x / 57.3/3600 = rad/s
K_x = 10^logK_x;
K_y = 10^logK_y;
K_z = 10^logK_z;
sigma_n_gyr = K_z 

tauK = 1;
lineK_x = K_x ./ sqrt(dt);

figure
%loglog(dt, data_draw , '-');
loglog(dt, data_x , '-');
%loglog(dt, data_y, '-');
%loglog(dt, data_z , '-');

xlabel('time:sec');                
ylabel('Sigma:deg/h');             
% legend('x','y','z');      
grid on;                           
hold on;                           
%loglog(dt, data_sim_draw , '-');
loglog(dt, lineK_x, '--' );
%loglog(dt, lineK_y, '--' );
%loglog(dt, lineK_z, '--' );
grid on;
grid on;
loglog(tauK,  K_x, 'o');
text(tauK, K_x, ['\sigma_n = ' , num2str(sigma_n_gyr)] )
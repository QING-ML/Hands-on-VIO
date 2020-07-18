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

figure
loglog(dt, data_draw , 'x');
xlabel('time:sec');
ylabel('Sigma')
grid on;                           
hold on;   
loglog(dt, data_sim_draw , '-');
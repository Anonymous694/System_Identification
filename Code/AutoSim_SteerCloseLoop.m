clear;

init_sim_lookup_tables;
SteeringParameter;
Data = importdata('Maschine.mat');
X = Data.Winkel;
Y = Data.M_Soll;
Z = Data.Drehmoment;

simout_list = {
    'Car.vx'; 
    'Car.YawVel'; 
    'Steer.WhlAng'; 
    'Steer.WhlTrq'; 
    'Car.ax'; 
    'Car.ay'; 
    'PT.Motor.Trq'; 
    'PT.Motor1.Trq';
    };

% Definition of generic variables
cm.project_path = '..';
cm.sim_model_name = 'generic_usersteer_close_loop.slx';
cm.sim_model_path = [cm.project_path,  '\src_cm4sl\',  cm.sim_model_name];

%%----CHG>>>>%%
cm.messdaten_path = 'N:\01_SmartLoad\03_Messdaten_Analyse\Messdaten\13_Messungen\Messdaten\20191107';   
cm.messdaten_name = 'elfpp.ppc_2019_11_07_11_05_30.mat'; 
%%<<<<CHG----%%

% % messdaten, t_from, t_to
% % elfpp.ppc_2019_10_28_15_35_27     266     296
% % elfpp.ppc_2019_10_28_15_48_33     45      145
% % elfpp.ppc_2019_10_28_15_55_05     325     390
% % elfpp.ppc_2019_11_07_10_59_31     75      300
% % elfpp.ppc_2019_11_07_11_05_30     75      140


[curr.messdaten, curr.messdaten_name] = load_messdaten([cm.messdaten_path, '\', cm.messdaten_name]);
idx_start = 1; % default
idx_end = size(curr.messdaten.X(1).Data,2); % default

%----CHG>>>>%%
% idx_start = 11000;
% idx_end = 15000;

% Time Set
t_from = 75;
t_to = 140;
t_index = find(curr.messdaten.X(1).Data>=t_from & curr.messdaten.X(1).Data<=t_to);
idx_start = t_index(1);
idx_end = t_index(length(t_index));
%<<<<CHG----%%

simin = get_timeseries4simin(simin_name_pairs, simin_list, curr.messdaten, idx_start, idx_end);

sim(cm.sim_model_path);

%%%
% initial value
len = size(simout_list,1);
for i=1:len
    idx_pairs_list(i) = find_string_index(simout_name_pairs(:,1),simout_list(i));
    idx_messdatenX_list(i) = find_string_index({curr.messdaten.X.Raster}, simout_name_pairs(idx_pairs_list(i),2));
    idx_messdatenY_list(i) = find_string_index({curr.messdaten.Y.Name}, simout_name_pairs(idx_pairs_list(i),2));
end
% slice time series
all_simtime = (idx_end-idx_start+1)/100;
ts = simout.Time>0 & simout.Time<=all_simtime;
t_span = round(length(ts)/((idx_end-idx_start+1)*10));
simout_time = simout.Time(ts);
labels = {'v_x (m/s)','{\omega}_z (rad/s)','{\delta}_s (rad)','m_s (Nm)','a_x (m/s^2)','a_y (m/s^2)','torque (Nm)','torque (Nm)'};
off = {0, 0, 0, 0, 0, 0, 0, 0};
% time_lim = [75 300];
time_lim = [0 all_simtime];
m=-4;
for i=1:8
    if i==1 || i==5
        figure('Name', [cm.messdaten_name], 'NumberTitle', 'off');
        m=m+4;
    end
subplot(2,2,i-m),
simout_idx = i;
    simout_data_i = simout.Data(ts, simout_idx);
    st = simout_time(1:t_span:end);
    sd = simout_data_i(1:t_span:end);
    mt = curr.messdaten.X(1).Data(idx_start:idx_end) - curr.messdaten.X(1).Data(idx_start);
md = curr.messdaten.Y(idx_messdatenY_list(simout_idx)).Data(idx_start:idx_end)-off{i};
    plot(st, sd, mt, md);
    title(simout_name_pairs(idx_pairs_list(simout_idx),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
ylabel(labels{i});
xlim(time_lim);
    grid on;
end
%%%
disp([cm.messdaten_name '_(' num2str(time_lim(1)) '-' num2str(time_lim(2)) '[sec])' ]);

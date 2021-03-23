clear;

init_sim_lookup_tables;
SteeringParameter;

simin_list = {
    'PT.Control.Motor.Trq_trg'; 
    'PT.Control.Motor1.Trq_trg';
    'Steer.MA2ColTrq';
    'Steer.Rack.LFrc';
    'Steer.Rack.RFrc';
    };

simout_list = {
    'Car.vx';
    'Steer.WhlAng';
    'Steer.WhlTrq';
    'Steer.Rack.LFrc';
    'Steer.Rack.RFrc';
    'Car.YawVel';
    'Car.ax';
    'Car.ay';
    };

% Definition of generic variables
cm.project_path = '..';
cm.sim_model_name = 'generic_usersteer.slx';
cm.sim_model_path = [cm.project_path,  '\src_cm4sl\',  cm.sim_model_name];

%%----CHG>>>>%%
file_idx = 8;
%%<<<<CHG----%%

files = {
    {'elfpp.ppc_2019_10_28_15_35_27.mat',   270,    300}; % 2.4727,8.9019;
    {'elfpp.ppc_2019_10_28_15_48_33.mat',   64,     74};  % 1.545, 5.562;
    {'elfpp.ppc_2019_10_28_15_48_33.mat',   107,    127}; % 1.8543,6.6757;
    {'elfpp.ppc_2019_10_28_15_55_05.mat',   360,    372}; % 1.676, 6.0336;
    {'elfpp.ppc_2019_10_25_11_09_42.mat',   288,    304}; % 1.4648,5.2734;
    {'elfpp.ppc_2019_10_25_11_09_42.mat',   347,    355}; % 0.002351,0.008464;
    {'elfpp.ppc_2019_10_28_15_37_02.mat',   479,    494}; % 1.4107,5.0787;
    {'elfpp.ppc_2019_10_28_15_37_02.mat',   454,    474}; % 2.4876,8.9555;
    {'elfpp.ppc_2019_10_25_11_03_09.mat',   115,    140}; % 0,0;
    };

cm.messdaten_path = 'N:\01_SmartLoad\03_Messdaten_Analyse\Messdaten\13_Messungen\Messdaten\';
cm.messdaten_name = files{file_idx}{1};
cm.subfolder = [cm.messdaten_name(11:14), cm.messdaten_name(16:17), cm.messdaten_name(19:20)];
[messdaten, curr.messdaten_name] = load_messdaten([cm.messdaten_path, cm.subfolder, '\', cm.messdaten_name]);

t_from = files{file_idx}{2};
t_to = files{file_idx}{3};
t_index = find(messdaten.X(1).Data>=t_from & messdaten.X(1).Data<=t_to);
idx_start = t_index(1);
idx_end = t_index(length(t_index));
    
% initial value
len = size(simout_list,1);
for i=1:len
    idx_pairs_list(i) = find_string_index(simout_name_pairs(:,1),simout_list(i));
    idx_messdatenX_list(i) = find_string_index({messdaten.X.Raster}, simout_name_pairs(idx_pairs_list(i),2));
    idx_messdatenY_list(i) = find_string_index({messdaten.Y.Name}, simout_name_pairs(idx_pairs_list(i),2));
end

simin = get_timeseries4simin(simin_name_pairs, simin_list, messdaten, idx_start, idx_end);
    
damp = Steer.d_rack;

sim(cm.sim_model_path);

% slice time series
all_simtime = (idx_end-idx_start+1)/100;
ts = simout.Time>0 & simout.Time<=all_simtime;
t_span = round(length(ts)/((idx_end-idx_start+1)*10));
simout_time = simout.Time(ts);
% begin loop
% len = size(simout_list,1);
figure('Name', [cm.messdaten_name, '_(', num2str(t_from), '-', num2str(t_to), '[sec])'], 'NumberTitle', 'off');
len=2;
for i=[2]
%     idx_pairs_list(i) = find_string_index(simout_name_pairs(:,1),simout_list(i));
%     idx_messdatenX_list(i) = find_string_index({messdaten.X.Raster}, simout_name_pairs(idx_pairs_list(i),2));
%     idx_messdatenY_list(i) = find_string_index({messdaten.Y.Name}, simout_name_pairs(idx_pairs_list(i),2));

    % plot(--Simdaten--, --Messdaten--);
    simout_data_i = simout.Data(ts, i);

    stime = simout_time(1:t_span:end);
    sdata = simout_data_i(1:t_span:end);
    mtime = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    mdata = messdaten.Y(idx_messdatenY_list(i)).Data(idx_start:idx_end);
    s_ts = stime>0 & stime<=all_simtime;
    m_ts = mtime>0 & mtime<=all_simtime;
    
%     subplot(2,2,2*i-1), 
    plot(stime, sdata, mtime, mdata);
    title(simout_name_pairs(idx_pairs_list(i),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
    ylabel('angle (rad)')
    xlim([0 all_simtime]);
    grid on;
end 

% Plots 2 4
figure('Name', [cm.messdaten_name, '_(', num2str(t_from), '-', num2str(t_to), '[sec])'], 'NumberTitle', 'off');
%     subplot(2,2,1),
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(1)).Data(idx_start:idx_end);
    plot(mt, md);
    title(simout_name_pairs(idx_pairs_list(1),1), 'Interpreter', 'none');
    xlabel('time (s)');
    ylabel('vx (m/s)');
    xlim([0 all_simtime]);
    grid on;
figure('Name', [cm.messdaten_name, '_(', num2str(t_from), '-', num2str(t_to), '[sec])'], 'NumberTitle', 'off');
    subplot(1,2,1),
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(3)).Data(idx_start:idx_end);
    plot(mt, md);
    title(simout_name_pairs(idx_pairs_list(3),1), 'Interpreter', 'none');
    xlabel('time (s)');
    ylabel('torque (Nm)');
    xlim([0 all_simtime]);
    grid on;
    subplot(1,2,2),
    mt1 = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md1 = messdaten.Y(idx_messdatenY_list(4)).Data(idx_start:idx_end);
    mt2 = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md2 = messdaten.Y(idx_messdatenY_list(5)).Data(idx_start:idx_end);
    plot(mt1, md1, mt2, md2);
    title('tie_rod_force', 'Interpreter', 'none');
    legend('left', 'right');
    xlabel('time (s)');
    ylabel('force (N)');
    xlim([0 all_simtime]);
    grid on;
%%%

offset_list = {
    {0,0};      {0,0};      {0,0};      {0,0};
    {0,0};      {0,0};      {0,0};      {0,0};
    {0,0};      {0,0};      {0,0};      {0,0};
    {0,0};
    };

%%% vx,wz,ax,zy
figure('Name', [cm.messdaten_name, '_(', num2str(t_from), '-', num2str(t_to), '[sec])'], 'NumberTitle', 'off');
subplot(2,2,1),
simout_idx = 1;
    simout_data_i = simout.Data(ts, simout_idx);
    st = simout_time(1:t_span:end);
    sd = simout_data_i(1:t_span:end);
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(simout_idx)).Data(idx_start:idx_end);
    plot(st, sd, mt, md);
    title(simout_name_pairs(idx_pairs_list(simout_idx),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
ylabel('v_x (m/s)');
    xlim([0 all_simtime]);
    grid on;
subplot(2,2,2),
simout_idx = 6;
    simout_data_i = simout.Data(ts, simout_idx);
    st = simout_time(1:t_span:end);
    sd = simout_data_i(1:t_span:end);
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(simout_idx)).Data(idx_start:idx_end);
    plot(st, sd, mt, md);
    title(simout_name_pairs(idx_pairs_list(simout_idx),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
ylabel('{\omega}_z (rad/s)');
    xlim([0 all_simtime]);
    grid on;
subplot(2,2,3),
simout_idx = 7;
    simout_data_i = simout.Data(ts, simout_idx);
    st = simout_time(1:t_span:end);
    sd = simout_data_i(1:t_span:end);
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(simout_idx)).Data(idx_start:idx_end)-offset_list{file_idx}{1};
    plot(st, sd, mt, md);
    title(simout_name_pairs(idx_pairs_list(simout_idx),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
ylabel('a_x (m/s^2)');
    xlim([0 all_simtime]);
    grid on;
subplot(2,2,4),
simout_idx = 8;
    simout_data_i = simout.Data(ts, simout_idx);
    st = simout_time(1:t_span:end);
    sd = simout_data_i(1:t_span:end);
    mt = messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start);
    md = messdaten.Y(idx_messdatenY_list(simout_idx)).Data(idx_start:idx_end)-offset_list{file_idx}{2};
    plot(st, sd, mt, md);
    title(simout_name_pairs(idx_pairs_list(simout_idx),1), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
ylabel('a_y (m/s^2)');
    xlim([0 all_simtime]);
    grid on;
%%%


mdata_interp = interp1(mtime,mdata, simout.Time);
mdata_interp(isnan(mdata_interp)) = 0;
mdata_ts_interp = timeseries(mdata_interp,simout.Time);

% rmse, sse
stime = stime(s_ts);
sdata = sdata(s_ts);
mtime = mtime(m_ts)';
mdata = mdata(m_ts)';
ser = floor(linspace(1,length(sdata),length(mdata)));
stime = stime(ser);
sdata = sdata(ser);
rmse = sqrt(sum((sdata-mdata).^2)/length(sdata));
mse = sum((sdata-mdata).^2)/length(sdata); % mean square error
    
    sigmas = [];
    % maximum absolute error
    sigma_max = max(abs(sdata-mdata));
    % mean absolute error
    sigma_mean = mean(abs(sdata-mdata));
    % root mean square error
    sigma_rmse = sqrt(mean((sdata-mdata).^2));
    % sum squared srror
    sigma_sse = sum((sdata-mdata).^2);
    
    sigmas = [sigmas, [sigma_max, sigma_mean, sigma_rmse, sigma_sse]'];


% fprintf('fric: %.1f [N]\ndamp: %.1f [Ns/m]\n',fric,damp);
% fprintf('RMSE: %f \nMSE: %f \n',rmse,mse);

% figure; plot(stime, sdata, mtime, mdata);

%% Save Fig
% savefilename = ['C:\Users\kwgrg\Desktop\SteerFigs_mf0.7_d18000_k18800_long_with_vx\', cm.messdaten_name(1:end-4), '_', num2str(t_from), '-', num2str(t_to), 'sec'];
% savefig([savefilename,'.fig']);
% save([savefilename,'.mat'], 'sigmas');

disp([cm.messdaten_name, '_(', num2str(t_from), '-', num2str(t_to), '[sec])']);






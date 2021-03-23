clear;

init_sim_lookup_tables;
init_sim_offsetlist;
% SteeringParameter;

% Definition of generic variables
cm.project_path = '..';
cm.sim_model_name = 'generic.mdl';
cm.sim_model_path = [cm.project_path,  '\src_cm4sl\',  cm.sim_model_name];

%%----CHG>>>>%%
cm.messdaten_path = 'E:\KIT_Masterarbeit_OnlyForTest\Messdaten\13_Messungen\Messdaten\Abrollmessung';   
cm.messdaten_name = 'elfpp.ppc_2019_12_06_15_08_47.mat'; 

% Geradeausfahrt - Abrollen:
%     elfpp.ppc_2019_12_06_15_03_19.mat	808.4	823.8
%     elfpp.ppc_2019_12_06_15_03_19.mat	841     860
%     elfpp.ppc_2019_12_06_15_03_19.mat	875.8	900
%     elfpp.ppc_2019_12_06_15_08_47.mat	14      34
% Geradeausfahrt - v<>c
%     elfpp.ppc_2019_10_28_15_22_21.mat	0       50
%%<<<<CHG----%%

[curr.messdaten, curr.messdaten_name] = load_messdaten([cm.messdaten_path, '\', cm.messdaten_name]);
idx_start = 1; % default
idx_end = size(curr.messdaten.X(1).Data,2); % default

%----CHG>>>>%%
% idx_start = 11000;
% idx_end = 15000;

% Time Set
t_from = 14;
t_to = 34;
t_index = find(curr.messdaten.X(1).Data>=t_from & curr.messdaten.X(1).Data<=t_to);
idx_start = t_index(1);
idx_end = t_index(length(t_index));
%<<<<CHG----%%

simin = get_timeseries4simin(simin_name_pairs, simin_list, curr.messdaten, idx_start, idx_end);

sim(cm.sim_model_path);

figure('Name', cm.messdaten_name, 'NumberTitle', 'off');
% slice time series
all_simtime = (idx_end-idx_start+1)/100;
ts = simout.Time>0 & simout.Time<=all_simtime;
t_span = round(length(ts)/((idx_end-idx_start+1)*10));
simout_time = simout.Time(ts);
% begin loop
len = size(simout_list,1);
for i=1:len
    idx_pairs_list(i) = find_string_index(simout_name_pairs(:,1),simout_list(i));
    idx_messdatenX_list(i) = find_string_index({curr.messdaten.X.Raster}, simout_name_pairs(idx_pairs_list(i),2));
    idx_messdatenY_list(i) = find_string_index({curr.messdaten.Y.Name}, simout_name_pairs(idx_pairs_list(i),2));
    
    % offset
    offset = 0;
    offset_idx = find_string_index(sim_offset_name_pairs(:,1), simout_name_pairs(idx_pairs_list(i),2));
    if ~isempty(offset_idx)
        offset = cell2mat(sim_offset_name_pairs(offset_idx,2));
    end
    %%%
        
    % plot(--Simdaten--, --Messdaten--);
    simout_data_i = simout.Data(ts, i);
    subplot(ceil(len/3),3,i), plot(simout_time(1:t_span:end), simout_data_i(1:t_span:end), ...
        curr.messdaten.X(1).Data(idx_start:idx_end) - curr.messdaten.X(1).Data(idx_start), ... 
        curr.messdaten.Y(idx_messdatenY_list(i)).Data(idx_start:idx_end)-offset);
    title(cell2str(simout_name_pairs(idx_pairs_list(i),:),' / '), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
%     xlim([20 32]);
end

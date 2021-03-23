clear;

init_sim_lookup_tables;
init_sim_offsetlist;

simdata_path = 'E:\KIT_Masterarbeit_OnlyForTest\MA_Project\MyCodes\simdata' ;
[simdata_name, simdata_path] = uigetfile('*.mat','Open Simdata',simdata_path);

if simdata_name == 0
    disp '--- No selected file ---';
    return
end

load([simdata_path, simdata_name]);
messdaten_path = cm.messdaten_path;
messdaten = load_messdaten([messdaten_path, '\', cm.messdaten_name]);
% messdaten = load_messdaten(['E:\KIT_Masterarbeit_OnlyForTest\Messdaten\13_Messungen\Messdaten\Abrollmessung\', cm.messdaten_name]);


figure('Name', simdata_name, 'NumberTitle', 'off');
% slice time series
all_simtime = (idx_end-idx_start+1)/100;
ts = simout.Time>0 & simout.Time<=all_simtime;
t_span = round(length(ts)/((idx_end-idx_start+1)*10));
simout_time = simout.Time(ts);
% begin loop
len = size(simout_list,1);
for i=1:len
    idx_pairs_list(i) = find_string_index(simout_name_pairs(:,1),simout_list(i));
    idx_messdatenX_list(i) = find_string_index({messdaten.X.Raster}, simout_name_pairs(idx_pairs_list(i),2));
    idx_messdatenY_list(i) = find_string_index({messdaten.Y.Name}, simout_name_pairs(idx_pairs_list(i),2));
    
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
        messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start), ... % messdaten.X(idx_messdatenX_list(i))
        messdaten.Y(idx_messdatenY_list(i)).Data(idx_start:idx_end)-offset);
    title(cell2str(simout_name_pairs(idx_pairs_list(i),:),' / '), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
%     xlim([20 32]);
end
savefig([simdata_path, simdata_name(1:end-4)]);






figure('Name', convertStringsToChars(messdaten_name), 'NumberTitle', 'off');
% slice time series
all_simtime = (idx_end-idx_start+1)/100;
ts = simout.Time>0 & simout.Time<=all_simtime;
t_span = round(length(ts)/((idx_end-idx_start+1)*10));
simout_time = simout.Time(ts);
% begin loop
len = size(outputs,1);
for i=1:len
    idx_pairs_list(i) = find_string_index(outputs_pairs(:,1), outputs(i));
    idx_messdatenX_list(i) = find_string_index({messdaten.X.Raster}, outputs_pairs(idx_pairs_list(i),2));
    idx_messdatenY_list(i) = find_string_index({messdaten.Y.Name}, outputs_pairs(idx_pairs_list(i),2));

    % plot(--Simdaten--, --Messdaten--);
    simout_data_i = simout.Data(ts, i);
    subplot(ceil(len/3),3,i), plot(simout_time(1:t_span:end), simout_data_i(1:t_span:end), ...
        messdaten.X(1).Data(idx_start:idx_end) - messdaten.X(1).Data(idx_start), ... 
        messdaten.Y(idx_messdatenY_list(i)).Data(idx_start:idx_end));
    title(cell2str(outputs_pairs(idx_pairs_list(i),:),' / '), 'Interpreter', 'none');
    legend('Simdaten', 'Messdaten');
    xlabel('time (s)');
end
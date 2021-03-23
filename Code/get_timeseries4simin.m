function timeseries4simin = get_timeseries4simin(simin_name_pairs, simin_list, messdaten, idx_start, idx_end)
%timeseries4simin = get_timeseries4simin(simin_name_pairs, simin_list, messdaten, idx_start, idx_end)
ts = [];
times = messdaten.X(133).Data(idx_start:idx_end)-messdaten.X(133).Data(idx_start);
for i=1:length(simin_list)
    idx_name = find_string_index(simin_name_pairs(:,1),simin_list(i));
    idx = find_string_index({messdaten.Y.Name}, simin_name_pairs(idx_name,2));
    
% filter
%     windowSize = 100; 
%     b = (1/windowSize)*ones(1,windowSize);
%     a = 1;
%     y = filter(b,a,messdaten.Y(idx).Data(idx_start:idx_end));
%     if i==3
%         ts = [ts, messdaten.Y(idx).Data(idx_start:idx_end)'];
%     else
%         x = messdaten.Y(idx).Data(idx_start:idx_end);
%         x(6713:end) = 1.5;
%         ts = [ts, x'];
%     end
    ts = [ts, messdaten.Y(idx).Data(idx_start:idx_end)'];
%ts = [ts, messdaten.Y(idx).Data(33000:78940)'];
end
timeseries4simin = timeseries(ts,times);
end


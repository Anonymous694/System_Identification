function [item] = get_item_from_simdaten(simdaten, idx_start, idx_end, simout_list, name)
%[item] = get_item_from_simdaten(messdaten, name)
ts = 1:10:((idx_end-idx_start+1)*10);
item.name = name;
item.id = find_string_index(simout_list, {item.name});
item.time = simdaten.Time(ts)';
item.data = simdaten.Data(ts,item.id)';
end
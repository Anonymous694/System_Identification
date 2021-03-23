function [item] = get_item_from_messdaten_idx(messdaten, idx_start, idx_end, name)
item = get_item_from_messdaten(messdaten, name);
item.time = item.time(idx_start:idx_end);
item.data = item.data(idx_start:idx_end);
end
function [item] = get_item_from_messdaten(messdaten, name)
%[item] = get_item_from_messdaten(messdaten, name)
item.name = name;
item.xid = find_string_index({messdaten.X.Raster}, {item.name});
item.yid = find_string_index({messdaten.Y.Name}, {item.name});
item.time = messdaten.X(item.xid).Data;
item.data = messdaten.Y(item.yid).Data;
end


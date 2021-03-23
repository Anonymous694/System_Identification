function [messdaten, name] = load_messdaten(messdaten_path)
%[messdaten, name] = load_messdaten(messdaten_path)
%   [in]   messdaten_path -> Path of messdaten
%   [out]  messdaten -> Loaded messdaten
%   [out]  name -> Name of loaded messdaten
t_messdaten = load(messdaten_path);
t_messdaten_fields = fieldnames(t_messdaten);
name = t_messdaten_fields{1};
messdaten = eval(['t_messdaten.', name]);
end


configs = readtable('Config.xlsx','Sheet','Run');

model_path = strtrim(string(configs.Value(ismember(configs.Item, 'Model Path'))));
messdaten_path = strtrim(string(configs.Value(ismember(configs.Item, 'Messdaten Path'))));
time_from = double(strtrim(string(configs.Value(ismember(configs.Item, 'Time from')))));
time_to = double(strtrim(string(configs.Value(ismember(configs.Item, 'Time to')))));
input_list = strtrim(string(configs.Value(ismember(configs.Item, 'Input List'))));
output_list = strtrim(string(configs.Value(ismember(configs.Item, 'Output List'))));
pairs_path = strtrim(string(configs.Value(ismember(configs.Item, 'Pairs Path'))));

input_pairs_table = readtable('.\Pairs.xlsx', 'Sheet', 'Input'); %%%
output_pairs_table = readtable('.\Pairs.xlsx', 'Sheet', 'Output'); %%%

inputs = cellstr(strtrim(split(input_list,',')));
outputs = cellstr(strtrim(split(output_list,',')));

inputs_pairs = strtrim([input_pairs_table.InCarMaker, input_pairs_table.InMessdaten]);
outputs_pairs = strtrim([output_pairs_table.InCarMaker, output_pairs_table.InMessdaten]);



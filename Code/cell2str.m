function str = cell2str(list, split)
%str = cell2str(list, split)
str = [];
for i=1:length(list)-1
    str = [str, list{i}, split];
end
str = [str, list{length(list)}];
end


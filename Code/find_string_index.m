function idx = find_string_index(S, Str)
%idx = find_string_index(S, Str)
%   [in]   S -> Cell of StringList
%   [in]   Str -> String to find
%   [out]  idx -> Index of String
idx = find(strcmp(S,Str));
end


function vec = readFile(fileName)
    cellArr = textscan(fopen(fileName, 'r'), '%s');
    c = cellArr{1};
    vec = string(c);
end
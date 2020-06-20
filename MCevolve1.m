function MCevolve1(lex, nGen, nSim)
    lexList = lex ;
    countData = 1:nSim;
    for j = 1:nSim
        lex2 = evolve1(lex, nGen);
        i = 1;
        found = 0;
        while found == 0 && i <= length(lexList)
            if (equalLexicon(lexList(i), lex2) == 1)
                countData(j) = i;
                found = 1;
            end
            i = i + 1;
        end
        if found == 0
            lexList = [lexList lex2];
            countData(j) = i;
        end
    end
    histogram(countData);
    counts = histc(countData, 1:(i+1));
    for i = 1:length(lexList)
        disp(uniqueVector(lexList(i)));
        disp(counts(i));
    end
end
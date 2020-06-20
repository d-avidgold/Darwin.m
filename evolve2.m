function exp = evolve2(lex, nSim)
    tot = 0;
    orig = lex;
    for i = 1:nSim
        lex = orig;
        j = 0;
        while equalLexicon(lex, lengthenVowels(lex)) == 0
            lex = evolve1(lex, 1);
            j = j + 1;
        end
        tot = tot + j;
    end
    exp = tot / nSim;
end
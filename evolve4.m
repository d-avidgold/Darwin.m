function exp = evolve4(nSim)
    tot = 0;
    vec = 1:nSim;
    for i = 1:nSim
        str = word("'tod");
        j = 0;
        while printWord(str) ~= "too" && printWord(str) ~= "doo"
            r = 10 * rand;
            if r <= 2
                str = swapTandD(str);
            elseif r <= 5
                str = lengthenVowels(str);
            elseif r <= 6
                str = dropLastEnv1(str);
            end
            j = j + 1;
        end
        tot = tot + j;
        vec(i) = j;
    end
    
    exp = tot / nSim;
    histogram(log(vec));
end
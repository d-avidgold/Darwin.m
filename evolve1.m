function final = evolve1(lex, nSim)
    final = lex;
    for i = 1:nSim
        r = rand * 3;
        if r <= 1
            final = swapTandD(final);
        elseif r <= 2
            final = lengthenVowels(final);
        end
    end
    % print(orig);
    % disp(newline);
    % print(lex);
end
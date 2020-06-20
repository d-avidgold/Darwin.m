function q = grassman(lex)
    c = ["t" "d"];
    v = ["o" "oo" "ee" "e"];
    for i = 1:2
        for j = 1:2
            for k = 1:4
                lex = regexprep(lex, c(i) + "h" + v(k) + c(j) + "h", c(i) + v(k) + c(j) + "h");
            end
        end
    end
    q = lex;
end
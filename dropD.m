function q = dropD(lex)
     w = regexprep(lex, "odh?$", "o");
     q = regexprep(w, "oodh?$", "oo");
end
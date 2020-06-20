function [h1, h2, v1, v2, c1, c2, uniq1, uniq2] = evolveRegex(nSim, r1, r2)

    % Decompose the data first -> CVC vs CVCVC!
    cons = ["t" "d" "th" "dh"];
    vows = ["o" "e" "oo" "ee"];
    oneSyl = getAllWords(cons, vows, 0);
    twoSyl = getAllWords(cons, vows, 1);
    
    % Sampling the space before we evolve...
    if nargin >= 2
        oneSyl = randsample(oneSyl, r1 * length(oneSyl), false); 
    end
    if nargin >= 3
        twoSyl = randsample(twoSyl, r2 * length(twoSyl), false); 
    end
    
    % Evolve!
    for i = 1:nSim
        r = 10 * rand;
        oneSyl = CHANGE(oneSyl, r);
        twoSyl = CHANGE(twoSyl, r);
    end
    

    % Get distribution of lengths:
    
    slen1 = strlength(oneSyl);
    h1 = slen1;
    slen2 = strlength(twoSyl);
    h2 = slen2;
    
    v1 = vowelVec(oneSyl);
    v2 = vowelVec(twoSyl);
    
    c1 = consVec(oneSyl);
    c2 = consVec(twoSyl);
    
    uniq1 = length(unique(oneSyl));
    uniq2 = length(unique(twoSyl));
end

function w = CHANGE(wrd, r)

    w = wrd;
        
    if r < 3
        w = regexprep(w, "a+", "a");
        w = regexprep(w, "i+", "i");
        w = regexprep(w, "e+", "e");
        w = regexprep(w, "u+", "u");
        w = regexprep(w, "o+", "o");
        
    elseif r < 6
        w = regexprep(w, "od$", "o");
        w = regexprep(w, "ood$", "oo");
    
    elseif r < 8
        w = regexprep(w, "^thoth", "toth");
        w = regexprep(w, "^thooth", "tooth");
        w = regexprep(w, "^dhoth", "doth");
        w = regexprep(w, "^dhooth", "dooth");
        w = regexprep(w, "^thoth", "todh");
        w = regexprep(w, "^thooth", "toodh");
        w = regexprep(w, "^dhoth", "dodh");
        w = regexprep(w, "^dhooth", "doodh");
        
    elseif r < 9
        w = regexprep(w, "ho+", "hoo");
        w = regexprep(w, "ha+", "haa");
        w = regexprep(w, "he+", "hee");
        w = regexprep(w, "hi+", "hii");
        w = regexprep(w, "hu+", "huu");
    end
end

function v = syllVec(lexVec)
    q = [];
    for i = 1:length(lexVec)
        wrd = lexVec(i);
        syllCount = 0;
        onVowl = 0;
        for j = 1:strlength(wrd)
            if ismember(extractBetween(wrd, j, j), ["a" "e" "i" "o" "u"])
                
                if onVowl == 0
                    syllCount = syllCount + 1;
                    onVowl = 1;
                end
            else
                onVowl = 0;
            end
        end     
        
        if (length(q) >= syllCount)
            q(syllCount) = q(syllCount) + 1;    
        else
            q(syllCount) = 1;
        end
    end
    v = q;
end

function v = vowelVec(lexVec)
   longO = count(lexVec, "oo");
   shortO = count(lexVec, "o") - 2 * longO;
   
   longE = count(lexVec, "ee");
   shortE = count(lexVec, "e") - 2 * longE;
   
   v = [sum(shortO) sum(longO) sum(shortE) sum(longE)];
end

function v = consVec(lexVec)
    th = count(lexVec, "th");
   justt = count(lexVec, "t") - th;
   
   dh = count(lexVec, "dh");
   justd = count(lexVec, "d") - dh;
   
   v = [sum(th) sum(justt) sum(dh) sum(justd)];
end

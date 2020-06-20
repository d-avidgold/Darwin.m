function q = MCMCevolve3(nGen, nSim, r1, r2)
 % Decompose the data first -> CVC vs CVCVC!
    cons = ["t" "d" "th" "dh"];
    vows = ["o" "e" "oo" "ee"];
    oneSylconst = getAllWords(cons, vows, 0);
    clf;
    
    avg = zeros(nGen + 1, 4);
    sqavg = zeros(nGen + 1, 4);
    
    % Sampling the space before we evolve...

    % Evolve!
    lenon = length(oneSylconst);
    for k = 1:nSim
        
        oneSyl = oneSylconst;
        
        if nargin > 2
            oneSyl = randsample(oneSyl, floor(r1 * lenon), false); 
        end
        
        for i = 1:(nGen+1)
            

            v1 = consVec(oneSyl);
            v1 = v1 / sum(v1);


            for j = 1:4
                subplot(2, 2, j);
                hold on;
                scatter(i - 1, v1(j), 20, 'r', 'filled');
                hold off;
                
                avg(i, j) = avg(i, j) + v1(j) / nSim;
                sqavg(i, j) = sqavg(i, j) + v1(j) ^ 2 / nSim;
            end
            
            r = 10 * rand;
            oneSyl = CHANGE2(oneSyl, r, .9);

        end
    end
    
    disp(avg);
    sig = real(sqrt(sqavg - avg .^ 2));
    disp(sig);
    sgtitle("Consonant Distributions over " + string(nSim) + " simulations");
    for j = 1:4
        subplot(2, 2, j);
        hold on;
        grid;
        xlabel("Generation");
        vow = ["th" "t" "dh" "d"];
        ylabel("Consonant Distribution " + vow(j));
        avgs = avg(1:(nGen + 1), j);
        sigs = sig(1:(nGen + 1), j);
        errorbar(0:nGen, avgs, sigs, 'k');
        title("Consonant " + vow(j) + " over " + string(nGen) + " generations");
        hold off;           
    end
    
end

function w2 = CHANGE2(wrd, r, q)
    w2 = wrd;
    w2changed = CHANGE(wrd, r);
    for i = 1:length(w2)
        if rand < q
            w2(i) = w2changed(i);
        end
    end
end

function w = CHANGE(wrd, r)

    w = wrd;
        
    if r < 1
        w = regexprep(w, "a+", "a");
        w = regexprep(w, "i+", "i");
        w = regexprep(w, "e+", "e");
        w = regexprep(w, "u+", "u");
        w = regexprep(w, "o+", "o");
        
    elseif r < 5
        w = regexprep(w, "odh?$", "o");
        w = regexprep(w, "oodh?$", "oo");
    
    elseif r < 9
        c = ["t" "d"];
        v = ["o" "oo" "ee" "e"];
        for i = 1:2
            for j = 1:2
                for k = 1:4
                    w = regexprep(w, c(i) + "h" + v(k) + c(j) + "h", c(i) + v(k) + c(j) + "h");
                end
            end
        end
        
    elseif r < 10
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

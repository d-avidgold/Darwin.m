function h = MCMCevolve(nGen, nSim, r1, r2)
    
    histShort = zeros(1,10);
    histLong = zeros(1,10);
    
    vowsShort = zeros(1, 4);
    vowsLong = zeros(1, 4);
    vowsShortSq = zeros(1, 4);
    vowsLongSq = zeros(1, 4);
    
    consShort = zeros(1, 4);
    consLong = zeros(1, 4);
    consShortSq = zeros(1, 4);
    consLongSq = zeros(1, 4);
    
    unique1 = zeros(1, nSim);
    unique2 = zeros(1, nSim);
    for i = 1:nSim
        [h1, h2, v1, v2, c1, c2, u1, u2] = evolveRegex(nGen, r1, r2);
        if (i == 1)
            l1 = length(h1);
            l2 = length(h2);
            disp(v1);
            disp(c1);
        end
        histShort = histShort + histcounts(h1, 0:10);
        histLong = histLong + histcounts(h2, 0:10);
        
        v1 = v1 / sum(v1);
        v2 = v2 / sum(v2);
        vowsShort = vowsShort + v1;
        vowsLong = vowsLong + v2;
        
        vowsShortSq = vowsShortSq + v1.^2;
        vowsLongSq = vowsLongSq + v2.^2;
        
        c1 = c1 / sum(c1);
        c2 = c2 / sum(c2);
        consShort = consShort + c1;
        consLong = consLong + c2;
        
        consShortSq = consShortSq + c1.^2;
        consLongSq = consLongSq + c2.^2;
        
        unique1(i) = u1;
        unique2(i) = u2;
    end
    
    
    sgtitle("Summary Statistics after " + string(nGen) + " Generations, " + string(nSim) + " Simulations." );
    subplot(2, 2, 1);

    bar(0:9, histShort/(l1*nSim), 'b', 'FaceAlpha', .5);
    hold on;
    bar(0:9, histLong/(l2 * nSim), 'y', 'FaceAlpha', .5);
    legend('CVC', 'CVCVC');
    
    xlabel("Length");
    ylabel("Density");
    title("Distribution of Resultant Word Length");
    hold off
    grid;
    
    subplot(2, 2, 2);
    
    expVowShort = vowsShort / nSim;
    expVowShortSq = vowsShortSq / nSim;
    expVowLong = vowsLong / nSim;
    expVowLongSq = vowsLongSq / nSim;
    sigVowShort = nSim * (expVowShortSq - expVowShort.^2) / (nSim - 1);
    sigVowLong = nSim * (expVowLongSq - expVowLong.^2) / (nSim - 1);
    disp(sigVowShort);
    disp(sigVowLong);
    
    err = [sigVowShort.' sigVowLong.'];
    X = categorical({'o','oo','e','ee'});
    X = reordercats(X,{'o','oo','e','ee'});
    yData = [expVowShort.' expVowShort.'];
    disp(yData);
    bar(yData, 'FaceAlpha', .5);
    hold on;
    ngroups = size(yData, 1);
    nbars = size(yData, 2);
    % Calculating the width for each bar group
    groupwidth = min(0.8, nbars/(nbars + 1.5));
    for i = 1:nbars
        x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
        errorbar(x, yData(:,i), err(:,i), '.');
    end
    xticklabels(X);
    
    %bar(X, vowsLong/(2*l2*nSim), 'y', 'FaceAlpha', .5);
    xlabel("Vowel");
    ylabel("Density");
    title("Vowel Distribution");
    legend('CVC', 'CVCVC');
    grid;
    hold off;
    
    
    subplot(2, 2, 3);
    expCShort = consShort / nSim;
    expCShortSq = consShortSq / nSim;
    expCLong = consLong / nSim;
    expCLongSq = consLongSq / nSim;
    sigCShort = nSim * (expCShortSq - expCShort.^2) / (nSim - 1);
    sigCLong = nSim * (expCLongSq - expCLong.^2) / (nSim - 1);
    err = [sigCShort.' sigCLong.'];
    yData2 = [expCShort.' expCLong.'];
    disp(yData2);
    bar(yData2, 'FaceAlpha', .5);
    hold on;
    ngroups = size(yData2, 1);
    nbars = size(yData2, 2);
    % Calculating the width for each bar group
    groupwidth = min(0.8, nbars/(nbars + 1.5));
    for i = 1:nbars
        x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
        errorbar(x, yData2(:,i), err(:,i), '.');
    end
    X = categorical({'t', 'th', 'd', 'dh'});
    X = reordercats(X, {'t', 'th', 'd', 'dh'});
    
    hold on;
    xticklabels(X);
    xlabel("Consonant");
    ylabel("Density");
    title("Consonant Distribution");   
    legend('CVC', 'CVCVC');
    grid;
    hold off;
    
    subplot(2, 2, 4);
    m = max(max(unique1), max(unique2));
    bar([histcounts(unique1, 0:m) ; histcounts(unique2, 0:m)].');
end
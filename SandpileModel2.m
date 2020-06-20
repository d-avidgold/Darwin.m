function g = SandpileModel2(gridSize, nSim, p, fl)
    matr = zeros(gridSize, gridSize);
    stack = [];
    colormap(parula(5));
    relaxedMatrix = zeros(gridSize, gridSize);
    vec = zeros(nSim);
    
    for i = 1:nSim
        count = 0;
        rowNum = floor(rand * gridSize + 1);
        colNum = floor(rand * gridSize + 1);
        matr(rowNum, colNum) = 1 + matr(rowNum, colNum);
        
        % If we just overloaded the system...
        if (matr(rowNum, colNum) == 4)
            
            relaxedMatrix(rowNum, colNum) = 1;
            % Relax it
            matr(rowNum, colNum) = 0;
            poss = [];
            % Check Down
            if checkIfGrid(gridSize, rowNum + 1, colNum)
                poss = [poss 1];
            end  
            % Check Up
            if checkIfGrid(gridSize, rowNum - 1, colNum)
                poss = [poss 2];
            end
            % Check Right
            if checkIfGrid(gridSize, rowNum, colNum + 1)
                poss = [poss 3];
            end
            % Check Left
            if checkIfGrid(gridSize, rowNum, colNum - 1)
                poss = [poss 4];
            end
            k = p;
            if length(poss) < p
                k = length(poss);
            end
            sample = randsample(poss, k, false);
            
            if ismember(1, sample)
                matr(rowNum + 1, colNum) = matr(rowNum + 1, colNum) + 1;
                stack = [stack rowNum + 1 colNum];
            end
            
            % Check Up
            if ismember(2, sample)
                matr(rowNum - 1, colNum) = matr(rowNum - 1, colNum) + 1;
                stack = [stack rowNum - 1 colNum];
            end
            
            % Check Right
            if ismember(3, sample)
                matr(rowNum, colNum + 1) = matr(rowNum, colNum + 1) + 1;
                stack = [stack rowNum (colNum + 1)];
            end
            
            % Check Left
            if ismember(4, sample)
                matr(rowNum, colNum - 1) = matr(rowNum, colNum - 1) + 1;
                stack = [stack rowNum (colNum - 1)];
            end
        end
        
        % Continue checking for overloading
        while not(isempty(stack))
            
            % Pop first coordinate of stack
            rowNum = stack(1);
            colNum = stack(2);
            stack = stack(3:length(stack));
            
            % Check if overloaded
            if (matr(rowNum, colNum) >= 4)
                relaxedMatrix(rowNum, colNum) = 1;
                % Relax it
                matr(rowNum, colNum) = 0;
                poss = [];
                % Check Down
                if checkIfGrid(gridSize, rowNum + 1, colNum)
                    poss = [poss 1];
                end  
                % Check Up
                if checkIfGrid(gridSize, rowNum - 1, colNum)
                    poss = [poss 2];
                end
                % Check Right
                if checkIfGrid(gridSize, rowNum, colNum + 1)
                    poss = [poss 3];
                end
                % Check Left
                if checkIfGrid(gridSize, rowNum, colNum - 1)
                    poss = [poss 4];
                end
                k = p;
                if length(poss) < p
                    k = length(poss);
                end
                sample = randsample(poss, k, false);

                if ismember(1, sample)
                    matr(rowNum + 1, colNum) = matr(rowNum + 1, colNum) + 1;
                    stack = [stack rowNum + 1 colNum];
                end

                % Check Up
                if ismember(2, sample)
                    matr(rowNum - 1, colNum) = matr(rowNum - 1, colNum) + 1;
                    stack = [stack rowNum - 1 colNum];
                end

                % Check Right
                if ismember(3, sample)
                    matr(rowNum, colNum + 1) = matr(rowNum, colNum + 1) + 1;
                    stack = [stack rowNum (colNum + 1)];
                end

                % Check Left
                if ismember(4, sample)
                    matr(rowNum, colNum - 1) = matr(rowNum, colNum - 1) + 1;
                    stack = [stack rowNum (colNum - 1)];
                end
            end
        end
        
        vec(i) = sum(sum(relaxedMatrix));
        relaxedMatrix = zeros(gridSize, gridSize);
        %Done distributing! Display, then next generation.
        if (fl)
            subplot(1, 2, 1);
            imagesc(matr);
            colorbar;
            pause(.5)
        end
    end
    
    values = unique(nonzeros(vec));
    maxPop = gridSize * gridSize;
    values = [values.' maxPop];
    
    counts = histcounts(vec, values);
    if fl
        subplot(1, 2, 2);
    end
    values = values(1:(length(values) - 1));
    loglog(values, counts);
    
%     x = log(values(1:(length(values)-1)));
%     coefficients = polyfit(log(values(1:(length(values)-1))), log(counts), 1);
%     
%     xFit = linspace(min(x), max(x), 1000);
%     yFit = polyval(coefficients , xFit);
%     hold on;
%     plot(xFit, yFit, 'r-', 'LineWidth', 2);
%     grid on;

    g = [values ; counts];
    p = polyfit(log(values),log(counts),1);
    z = polyval(p,log(values));
    hold on;
    loglog(values,exp(z));
end

function f = checkIfGrid(gridSize, rowNum, colNum)
    if rowNum < 1 || rowNum > gridSize
        f = 0;
    else
        if colNum < 1 || colNum > gridSize
            f = 0;
        else
            f = 1;
        end
    end
end
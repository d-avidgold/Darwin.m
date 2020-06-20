function s = samplePlatter(nSim)
    % Uniform on [2, 4]
    vec = rand(1, nSim);
    vec = 2 * vec;
    vec = 2 + vec;
    
    subplot(2, 2, 1);
    histogram(vec, 50, 'Normalization','pdf') 
    grid on;
    xlim([2, 4]);
    m = sum(vec) / nSim;
    
    disp("Expected Mean: 3");
    disp("Estimated Mean: " + string(m) + newline);
    
    varVec = (m - vec) .^ 2;
    var = sum(varVec) / nSim;
    
    disp("Expected Variance: .333");
    disp("Estimated Variance: " + string(var));
    
    s = vec(1:10);
    
    % Exponential (lambda = 1)
    vec2 = rand(1, nSim);
    vec2 = -1 * log(vec2);
    subplot(2, 2, 2);
    histogram(vec2, 50, 'Normalization','pdf');
    grid on;
    xlim([0, 5]);
    
    m2 = sum(vec2) / nSim;
    
    disp("Expected Mean: 1");
    disp("Estimated Mean: " + string(m2) + newline);
    
    varVec2 = (m2 - vec2) .^ 2;
    var2 = sum(varVec2) / nSim;
    
    disp("Expected Variance: 1");
    disp("Estimated Variance: " + string(var2));
    
    vec3 = rand(1, nSim) + .0000001;
    vec3 = sqrt(abs(2 * log(vec3 * sqrt(2 * pi))));
    subplot(2, 2, 3);
    histogram(vec3, 50, 'Normalization','pdf');
    
end
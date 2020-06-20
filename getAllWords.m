% BASIC version: only CVC structure. 
% CVVC supported via doubling by hand (a > aa) in input vector.


function vec = getAllWords(consVec, vowVec, fl)
    [X, Y, Z] = meshgrid(consVec,vowVec, consVec);
    vec = X + Y + Z;
    vec = vec(:);
    if (fl == 1)
        [X1, Y1, Z1] = meshgrid(vec, vowVec, consVec);
        vec = X1 + Y1 + Z1;
        vec = vec(:);
    end
end


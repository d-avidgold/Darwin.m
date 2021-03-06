function l = randomLexicon(consBank, vowelBank, syllData, length, onsetData, rimeData, maxes)
    % IPAbank: 2x4 string array (cons and then vowels)
    % syllData: 1xmaxSyll syllable distribution 
    % length: number of words to be constructed
    % onsetRimeData: 
    
    lexicon = strings(1, length);
    for i = 1:length
        word = "";
        length = randsample(maxes(1), 1, true, syllData);
        for j = 1:length
            word = word + randomSyllable(consBank, vowelBank, onsetData, rimeData, maxes(2), maxes(3));
            if j < length
                word = word + "-";
            end
        end
        lexicon(i) = word;
    end
    l = lexicon;        
end

function s = randomSyllable(consBank, vowelBank, onsetData, rimeData, maxOnset, maxRime)
    onset = "";
    nucleus = randsample(vowelBank, 1, true);
    coda = "";
    onsetLength = randsample(maxOnset, 1, true, onsetData);
    for i = 1:onsetLength
        onset = onset + randsample(consBank, 1, true);
    end
    codaLength = randsample(maxRime, 1, true, rimeData);
    for j = 1:codaLength
        coda = coda + randsample(consBank, 1, true);
    end
    s = onset + nucleus + coda;
end
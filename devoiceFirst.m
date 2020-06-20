function retWord = devoiceFirst(w)
    firstSyll = w.Syllables(1);
    onset = firstSyll.Onset;
    if not(isempty(onset))
        onset(1) = devoice(onset(1));
    end
    newSyll = syllable();
    newSyll.Onset = onset;
    newSyll.Nucleus = firstSyll.Nucleus;
    newSyll.Rime = firstSyll.Rime;
    retWord = w;
    retWord.Syllables(1) = newSyll;
end


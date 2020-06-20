classdef syllable
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Onset 
        Nucleus
        Rime
    end
    
    methods
        
        function obj = syllable(string)
            if nargin > 0
                string = char(string);
                i = 1;
                vows = ["i" "u" "e" "o"];
                onsetLength = 0;
                codaLength = 0;
                onsetStr = "";
                codaStr = "";
                while i <= length(string) && not(ismember(string(i), vows))
                    if string(i) ~= "h"
                        onsetLength = onsetLength + 1;
                    end 
                    onsetStr = onsetStr + string(i);
                    i = i + 1;
                end
                if i >= length(string) + 1
                    disp("Bad input!")
                    obj.Onset = [];
                    obj.Nucleus = "";
                    obj.Rime = [];
                else
                    vowl = string(i);
                    i = i + 1;
                    if i <= length(string) && ismember(char(string(i)), vows)

                        vowl = strcat(vowl, vowl);
                        i = i + 1;
                    end
                    while i <= length(string)
                        if string(i) ~= "h"
                            codaLength = codaLength + 1;
                        end
                        codaStr = codaStr + string(i);
                        i = i + 1;
                    end
                    
                    if (onsetLength)
                        onsList(1, onsetLength) = consonant;
                        i = 1;
                        place = 1;
                        onsetStr = char(onsetStr);
                        while i <= onsetLength
                            
                            cons = onsetStr(place);
                            place = place + 1;
                            if place <= length(onsetStr) && onsetStr(place) == "h"
                                 cons = cons + "h";
                                 place = place + 1;
                            end
                            onsList(i) = consonant(cons);
                            i = i + 1;
                        end
                        
                    else
                        onsList = [];
                    end
                    
                    if (codaLength)
                        codList(1, codaLength) = consonant;
                        i = 1;
                        place = 1;
                        codaStr = char(codaStr);
                        
                        
                        while i <= codaLength
                            cons = codaStr(place);
                            place = place + 1;
                            if place <= length(codaStr) && codaStr(place) == "h"
                                cons = cons + "h";
                                place = place + 1;
                            end
                            codList(i) = consonant(cons);
                            i = i + 1;
                        end
                    else
                        codList = [];
                    end
                    obj.Onset = onsList;
                    obj.Nucleus = vowel(vowl);
                    obj.Rime = codList;
                end
            end
        end
        
        function syll = print(obj)
            syll = "";
            for i = 1:length(obj.Onset)
                syll = syll + print(obj.Onset(i));
            end
            syll = syll + print(obj.Nucleus);
            for i = 1:length(obj.Rime)
                syll = syll + print(obj.Rime(i));
            end
            
        end
        
        function w = swapTandD(syl)
            lenOn = length(syl.Onset);
            lenRi = length(syl.Rime);
            
            w = syllable;
            if (lenOn > 0)
                on(1, lenOn) = consonant;
                for i = 1:lenOn
                    on(i) = swapTandD(syl.Onset(i));
                end
                w.Onset = on;
            else
                w.Onset = syl.Onset;
            end
            if (lenRi > 0)
                ri(1, lenRi) = consonant;
                for i = 1:lenRi
                    ri(i) = swapTandD(syl.Rime(i));
                end
                w.Rime = ri;
            else
                w.Rime = syl.Rime;
            end
            
            w.Nucleus = syl.Nucleus;
           
        end

        function s = lengthenVowels(syl)
            s = syllable;
            s.Onset = syl.Onset;
            s.Rime = syl.Rime;
            s.Nucleus = lengthen(syl.Nucleus);
        end
        
        function q = equalSyll(s1, s2)
            q = 1;
          
            o1 = s1.Onset;
            o2 = s2.Onset;
            
            % Check if onsets equal
            if (length(o1) ~= length(o2))
                q = 0;
            else
                i = 1;
                while i <= length(o1) && q == 1
                    c1 = o1(i);
                    c2 = o2(i);
                    if not(equalCons(c1, c2))
                        q = 0;
                    end
                    i = i + 1;
                end
            end
            
            if q ~= 0
                n1 = s1.Nucleus;
                n2 = s2.Nucleus;
                if not(equalVowel(n1, n2))
                    q = 0;
                end
                % Check if nuclei equal
            end
            if q ~= 0
            
                r1 = s1.Rime;
                r2 = s2.Rime;
                if (length(r1) ~= length(r2))
                    q = 0;
                else
                    i = 1;
                    while i <= length(r1) && q == 1
                        c1 = r1(i);
                        c2 = r2(i);
                        if not(equalCons(c1, c2))
                            q = 0;
                        end
                        i = i + 1;
                    end
                end
                % Check if rimes equal
            end
        end
        
        function s = dropLastEnv1(syl)
            s = syl;
            if (equalVowel(syl.Nucleus, vowel("o")) || equalVowel(syl.Nucleus, vowel("oo"))) && length(syl.Rime) == 1
                if equalCons(syl.Rime(1), consonant("d"))
                    s.Rime = [];
                end
            end
                
        end
    end
    
end


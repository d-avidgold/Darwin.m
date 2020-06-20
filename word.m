classdef word
    % Word Class
    %   Used to store lists of syllables and the associated stress
    %   patterns.
    
    properties
        Syllables
        Stress 
    end
    
    methods
        
        function obj = word(str)
            % word()
            %   Constructs an instance of the class given a string of the
            %   format: '[c*vc*-]*c*vc*
            if nargin > 0
                
                str = char(str) + "-";
                str = char(str);
                sylls = count(str, "'") + count(str, ",") + count(str, "-") - 1;
                l(1, sylls) = syllable;
                k(1, sylls) = "";
                start = 1;
                fin = 3;
                i = 1;
                while i <= sylls
                    while (not(ismember(str(fin), ["," "'" "-"])))
                        fin = fin + 1;
                    end
                    sy = str(start+1:fin-1);
                    l(i) = syllable(convertCharsToStrings(sy));
                    k(i) = str(start);
                    start = fin;
                    
                    fin = start + 2;
                    i = i + 1;
                    
                end
            
            obj.Syllables = l;
            obj.Stress = k;
            end
        end
        
        function st = printWord(obj)
            % printWord()
            %   Returns a string representing the word, without syllable
            %   breaks or stress markers.
            st = "";
            for i = 1:(length(obj.Syllables))
                st = st + print(obj.Syllables(i));
            end
        end
        
        function st = printWithStress(obj)
            % printWithStress()
            %   Returns a string with the given stress pattern of the word,
            %   with primary stress marked '
            %        secondary stress      ,
            %        no stress             -
            st = "";
            for i = 1:(length(obj.Syllables))
                st = st + obj.Stress(i);
                st = st + print(obj.Syllables(i));
            end
        end
        
        function w = swapTandD(wrd)
            len = length(wrd.Syllables);
            v(1, len) = syllable;
            for i = 1:len
                v(i) = swapTandD(wrd.Syllables(i));
            end
            w = word;
            w.Syllables = v;
            w.Stress = wrd.Stress;
        end
        
        function w = lengthenVowels(wrd)
            len = length(wrd.Syllables);
            v(1, len) = syllable;
            for i = 1:len
                v(i) = lengthenVowels(wrd.Syllables(i));
            end
            w = word;
            w.Syllables = v;
            w.Stress = wrd.Stress;
        end
        
        function q = equalWords(w1, w2)
            q = 1;
            l1 = w1.Syllables;
            l2 = w2.Syllables;
            if length(l1) ~= length(l2)
                q = 0;
            else
                i = 1;
                while q == 1 && i <= length(l1)
                    s1 = l1(i);
                    s2 = l2(i);
                    if not(equalSyll(s1, s2))
                        q = 0;
                    end
                    i = i + 1;
                end
            end
        end
        
        function w = dropLastEnv1(wrd)
            w = wrd;
            len = length(w.Syllables);
            w.Syllables(len) = dropLastEnv1(w.Syllables(len));
        end
    end
end
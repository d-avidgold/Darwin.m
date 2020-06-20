classdef lexicon
    % Lexicon Class
    %   Used to store large vectors of words.
    
    properties
        Words
    end
    
    methods
        
        function obj = lexicon(vec)
            % lexicon() 
            %   Constructs an instance given a vector of words OR strings.
            if nargin > 0
                if class(vec(1)) == "word"
                    obj.Words = vec;
                else
                    v(1, length(vec)) = word;
                    for i = 1:length(vec)
                        v(i) = word(vec(i));
                    end
                    obj.Words = v;
                end
            end
        end
            
        function g = getData(obj)
            % getData()
            %   Creates histograms for vowel and consonant data.
            vowelData = containers.Map(["e" "ee" "i" "ii" "o" "oo" "u" "uu"], zeros(1, 8));
            consData = containers.Map(["b" "bh" "p" "ph" "t" "th" "d" "dh"], zeros(1, 8));
            
            for i = 1:length(obj.Words)
                word = obj.Words(i);
                for j = 1:length(word.Syllables)
                    syll = word.Syllables(j);
                    ons = syll.Onset;
                    nucleus = syll.Nucleus;
                    rime = syll.Rime;
                    for k = 1:length(ons)
                        letter = ons(k);
                        consData(print(letter)) = consData(print(letter)) + 1;
                    end
                    
                    vowelData(print(nucleus)) = vowelData(print(nucleus)) + 1;
                    
                    for k = 1:length(rime)
                        letter = rime(k);
                        consData(print(letter)) = consData(print(letter)) + 1;
                    end
                    
                end
            end
            
            cell2mat(values(consData))
            subplot(1, 2, 1);
            histogram('Categories',keys(consData),'BinCounts',cell2mat(values(consData)));
            subplot(1, 2, 2);
            histogram('Categories',keys(vowelData),'BinCounts',cell2mat(values(vowelData)));
            
            g = vowelData;
        end
        
        function p = print(obj)
            % print()
            %   Prints each word in the lexicon, using word's printWord
            %   function.
            for i = 1:length(obj.Words)
                w = obj.Words(i);
                disp(printWord(w));
            end
            p = 0;
        end
        
        function l = swapTandD(lex)
            % swapTandD()
            %   Applies the t > d, d > t change to every word in the
            %   lexicon.
            len = length(lex.Words);
            v(1, len) = word;
            for i = 1:len
                v(i) = swapTandD(lex.Words(i));
            end
            l = lexicon(v);
        end
        
        function l = lengthenVowels(lex)
            % lengthenVowels()
            %   Applies the V > VV change to every word in the lexicon.
            len = length(lex.Words);
            v(1, len) = word;
            for i = 1:len
                v(i) = lengthenVowels(lex.Words(i));
            end
            l = lexicon(v);
        end
        
        function v = uniqueVector(obj)
            % uniqueVector()
            %   Creates a vector of strings from the list of words, only
            %   taking each string once.
            w(1, length(obj.Words)) = "";
            for i = 1:length(obj.Words)
                w(i) = printWord(obj.Words(i));
            end
            v = unique(w, 'stable');
        end
        
        function q = equalLexicon(l1, l2)
            % equalLexicon()
            %   Takes in two lexica and compares for equality word by word.
            %   Order matters! This way, l1 != swapTandD(l1).
            q = 1;
            l1 = l1.Words;
            l2 = l2.Words;
            if (length(l1) ~= length(l2))
                q = 0;
            else
                i = 1;
                while q == 1 && i <= length(l1)
                    if not(equalWords(l1(i), l2(i)))
                        q = 0;
                    end
                    i = i + 1;
                end
            end
        end
    end
end


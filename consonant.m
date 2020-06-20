classdef consonant
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Place 
        Voicing
        Aspiration
    end
    
    methods
        
        function obj = consonant(letter)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            if nargin > 0
                letter = char(letter);
                if (ismember(letter(1), ["p" "b"]))
                    obj.Place = "bilab";
                end
                if (ismember(letter(1), ["t" "d"]))
                    obj.Place = "dentl";
                end

                if (ismember(letter(1), ["p" "t"]))
                    obj.Voicing = 0;
                end
                if (ismember(letter(1), ["b" "d"]))
                    obj.Voicing = 1;
                end

                if (length(letter) >= 2 && letter(2) == "h")
                    obj.Aspiration = 1;
                else
                    obj.Aspiration = 0;
                end
            end
            
            
        end
        
        function obj = devoice(obj)
            obj.Voicing = 0;
        end
        
        function letter = print(obj)
            letter = "";
            ind = obj.Voicing + 1;
            bilbs = ["p" "b"];
            dents = ["t" "d"];
            if obj.Place == "bilab"
                letter = letter + bilbs(ind);
            end
            if obj.Place == "dentl"
                letter = letter + dents(ind);
            end
            if obj.Aspiration
                letter = letter + "h";
            end
        end
        
        function k = swapTandD(letter)
            k = consonant;
            k.Place = letter.Place;
            k.Aspiration = letter.Aspiration;
            if (letter.Place == "dentl")
                k.Voicing = 1 - letter.Voicing;
            else
                k.Voicing = letter.Voicing;
            end
            
        end
        
        function q = equalCons(l1, l2)
            q = 1;
            if l1.Place ~= l2.Place
                q = 0;
            end
            if l1.Voicing ~= l2.Voicing
                q = 0;
            end
            if l1.Aspiration ~= l2.Aspiration
                q = 0;
            end
        end
        
    end
end


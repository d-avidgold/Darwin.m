classdef vowel
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Height
        Place
        Length
    end
    
    methods
        
        function obj = vowel(letter)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            letter = char(letter);
            if (ismember(letter(1), ["i" "u"]))
                obj.Height = "top";
            end
            if (ismember(letter(1), ["e" "o"]))
                obj.Height = "mid";
            end
            
            if (ismember(letter(1), ["i" "e"]))
                obj.Place = "front";
            end
            if (ismember(letter(1), ["u" "o"]))
                obj.Place = "back";
            end
            
            if (length(letter) >= 2)
                obj.Length = 1;
            else
                obj.Length = 0;
            end
        end
        
        function obj = shorten(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Length = 0;
        end
        
        function obj = lengthen(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Length = 1;
        end
        
        function obj = raise(obj)
            obj.Height = "top";
        end
        
        function obj = lower(obj)
            obj.Height = "mid";
        end
        
        function letter = print(obj)
            if obj.Height == "mid"
                if obj.Place == "front"
                    letter = "e";
                else
                    letter = "o";
                end
            
            else
                if obj.Place == "front"
                    letter = "i";
                else
                    letter = "u";
                end
            end    
            if (obj.Length)
                letter = letter + letter;
            end
        end
        
        function q = equalVowel(v1, v2)
            q = 1;
            if v1.Place ~= v2.Place
                q = 0;
            end
            if v1.Height ~= v2.Height
                q = 0;
            end
            if v1.Length ~= v2.Length
                q = 0;
            end
        end
    end
end


%returns the values tha are present in both vectors

function [out] = presentBothVectors (in1, in2)
    out = [];
    for i = 1:size(in1,1)
        if ~isempty(find(in2 == in1(i)))
            out = [out; in1(i)];
        end
    end
end
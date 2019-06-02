function [out] = deleteOutterBoundaries(allBoundaries, outterBoundaries)
    out = [];
    for i = 1:size(allBoundaries,1)
        if isempty(find(outterBoundaries == allBoundaries(i),1))
            out = [out; allBoundaries(i)];
        end
    end
end
%Extract all the points that lie on the boundaries of
%the point cloud
function [boundaryPoints] = extractBoundaries (faces, faceEdges)

    [row, col] = find (faceEdges == 0);

    boundaryPoints = [];

    for i = 1:size(row,1)
        if col(i) == 1
            boundaryPoints = [boundaryPoints; faces(row(i), 1); faces(row(i), 2)];
        elseif col(i) == 2
            boundaryPoints = [boundaryPoints; faces(row(i), 1); faces(row(i), 3)];
        else
            boundaryPoints = [boundaryPoints; faces(row(i), 2); faces(row(i), 3)];
        end

        boundaryPoints = unique(boundaryPoints);
    end
end

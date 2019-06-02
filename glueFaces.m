%there will always be 2 points to represent a point shared by two different
%semantic objects. 3 if the point appear at an intersection of three
%differently labels objects, such as the corner of two walls and the
%ceilling. This functions aims to eliminate those multiple points.
function [gluedFaces, coincidentLabels] = glueFaces(faces, verticies, semanticInfo)

    gluedFaces = faces; %creates a copy of the matrix faces
    coincidentLabels = {};

    for i = 1:size(verticies,1)
        [row1, ~] = findVector(verticies(i,:), verticies);
        row1 = sort(row1);
        if (size(row1,1)>1 && row1(1)==i)%isempty(find(row1<i,1))) %find more than just itself and be the firt to be found (otherwise it has been already found)
            auxSemantic = semanticInfo(row1,1);
            coincidentLabels{row1(1)} = auxSemantic;
            for j = 2:size(row1,1)
                coincidentLabels{row1(j)} = auxSemantic;
                [row2, col2] = find(gluedFaces==row1(j));
                for k = 1:size(row2,1)
                    gluedFaces(row2(k), col2(k)) = i;
                end
            end
        else
            if (size(row1,1)==1)
                coincidentLabels{i} = semanticInfo(i,1);
            end
        end
    end
end
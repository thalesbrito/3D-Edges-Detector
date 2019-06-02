function [noDuplicateFaces] = removeDuplicates(faces, verticies, pointsPerObj)

    noDuplicateFaces = faces; %creates a copy of the matrix faces
    lastPos = 0;
    
    for h = 1:size(pointsPerObj,1)
        initPos = lastPos + 1;
        lastPos = lastPos + pointsPerObj(h);
        objPoints = unique([noDuplicateFaces(initPos:lastPos,1); noDuplicateFaces(initPos:lastPos,2); noDuplicateFaces(initPos:lastPos,3)]);
    
        for i = 1:size(objPoints,1)
            [row1, col1] = findVector(verticies(objPoints(i),:), verticies(objPoints,:));
            if (size(row1,1)>1 && isempty(find(row1<i,1))) %find more than just itself and be the firt to be found (otherwise it has been already found)
                for j = 1:size(row1,1)
                    %obj.v(row1(i),:) = [];  Cannot erase it, otherwise it will chante
                    %the other line numbers. I'll just ignore the numbers.
                    if ~(objPoints(i) == row1(j))
                        [row2, col2] = find(noDuplicateFaces(initPos:lastPos,:)==objPoints(row1(j)));
                        for k = 1:size(row2,1)
                            noDuplicateFaces(row2(k)+initPos-1, col2(k)) = objPoints(i);
                        end
                    end
                end
            end
        end
    end
end
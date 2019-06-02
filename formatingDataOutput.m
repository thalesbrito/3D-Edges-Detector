function [pointsOutOrder, labels, labelsWeight] = formatingDataOutput (edgePoints, pointsInOrder)
    
    numPoints = size(pointsInOrder,1);
    labels = ones(numPoints, 1)*(-1);
    labels(edgePoints) = 1;
    
    %permutation of points and its respective labels
    perm = randperm(numPoints);
    pointsOutOrder = pointsInOrder(perm,:);
    labels = labels(perm,:);

    %same weight for now
    labelsWeight = ones(numPoints,1);
    
    %delete duplicate points and staircase
    numPointsLeft = size(pointsOutOrder,1);
    i = 1;
    while i <= numPointsLeft
        if ((pointsOutOrder(i,2)>3.1)||(pointsOutOrder(i,2)<-0.1))
            pointsOutOrder(i,:) = [];
            labels(i,:) = [];
            labelsWeight(i,:) = [];
            numPointsLeft = size(pointsOutOrder,1);
        else
            [row1, col1] = findVector(pointsOutOrder(i, :), pointsOutOrder);
            row1 = sort(row1);
            if length(row1)>1
                pointsOutOrder(row1(2:end),:) = [];
                labels(row1(2:end),:) = [];
                labelsWeight(row1(2:end),:) = [];
            end
            numPointsLeft = size(pointsOutOrder,1);
            i = i + 1;
        end
    end
    

    
end

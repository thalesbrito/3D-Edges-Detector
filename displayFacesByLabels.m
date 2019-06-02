function displayFacesByLabels (faces, labels, verticies, allEdges, selectedLabels, rooms, colourEdges)

    toDisplay = [];
    if isempty(rooms)
        for i = 1:size(selectedLabels,2)
            [row1, col1] = find(labels(:,1) == selectedLabels(i));
            toDisplay = [toDisplay; faces(row1,:)];
        end
    else
        for i = 1:size(rooms,2)
            [row1, col1] = find(labels(:,3) == rooms(i));
            for j = 1:size(selectedLabels,1)
                [row2, col2] = find(labels(row1,1) == selectedLabels(j));
                toDisplay = [toDisplay; faces(row1(row2),:)];
            end
        end
    end
            
    edgePoints= unique([toDisplay(:,1); toDisplay(:,2); toDisplay(:,3)]);

    [edgePointsToDisplay] = presentBothVectors(edgePoints,allEdges);

    figure;
    trisurf(toDisplay, verticies(:,1), verticies(:,2), verticies(:,3))
    hold on;
    scatter3(verticies(edgePointsToDisplay,1),verticies(edgePointsToDisplay,2),verticies(edgePointsToDisplay,3),'*',colourEdges)
    hold off;
    %axis equal;
end

function displayPointsByLabels (faces, labels, verticies, edges, selectedLabels, colourPoints, colourEdges)

toDisplay = [];

for i = 1:size(selectedLabels,2)
    [row, col] = find(labels(:,1) == selectedLabels(i));
    toDisplay = [toDisplay; unique([faces(row,1); faces(row,2); faces(row,3) ])];
end

toDisplay = str2double(unique(toDisplay));

[edgePoints] = presentBothVectors(toDisplay, edges);

figure;
scatter3(verticies(toDisplay,1),verticies(toDisplay,2),verticies(toDisplay,3),'.',colourPoints)
hold on;
scatter3(verticies(edgePoints,1),verticies(edgePoints,2),verticies(edgePoints,3),'*',colourEdges)
hold off;
axis equal;
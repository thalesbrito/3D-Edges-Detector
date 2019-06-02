function [points, labels, labelsWeight] = generateData(area,obj)

    %%%%%%%%%%%%[READING THE MESH OBJECT AND CONDITIONING THE DATA]%%%%%%%%%%%%

    %Reading the data
    %obj = readObj(strcat('area_',string(area),'/3d/semantic.obj'));

    %Removing duplicate points within each semantic object
    noDuplicateFaces = removeDuplicates(obj.f.v, obj.v, obj.f.pointsPerObj);

    %Recalcule faces' normals
    [calcNormals, indCalcNormals] = calcFacesNormals (obj.f.v, obj.v);

    %%%%%%%%%%%%%%[WORKING WITH THE SEMANTIC OBJECTS SEPARATELLY]%%%%%%%%%%%%%% 

    %For each triangle, identifies its neighbours and calculate the angle
    %between each two triangles. It is executed over each semantic object
    %separatelly
    [~, faceEdges] = neighbourSurfacesPerObj(noDuplicateFaces, calcNormals, indCalcNormals, obj.f.pointsPerObj);

    %Finding points that lie on the boudaries of each semantic object
    [boundaryPoints] = extractBoundaries (noDuplicateFaces, faceEdges);

    %For testing
    %[edgePointsByNormal] = findEdgesByNormal(noDuplicateFaces(2450:2768,:), normalDif(2450:2768,:), 60, 120);

    %%%%%%%%%%%%%%%[WORKING WITH THE SEMANTIC OBJECTS TOGETHER]%%%%%%%%%%%%%%%%

    %make duplicate points on the boundaries of different semantic objects to
    %be the same
    [gluedFaces, coincidentLabels] = glueFaces(noDuplicateFaces, obj.v, obj.f.sem);

    %For each triangle, identifies its neighbours and calculate the
    %and between their surfaces
    [gluedNormalDif, gluedFaceEdges] = neighbourSurfaces(gluedFaces, calcNormals, indCalcNormals);

    %Finding point that seem to lay on the structural edges because of the
    %angle between neighbour surfaces
    [edgePointsByNormal] = findEdgesByNormal(gluedFaces, gluedNormalDif, 60, 120);

    %Finding points that lie on the boudary of the whole point cloud (limit of
    %the point cloud)
    [externalBoundaryPoints] = extractBoundaries (gluedFaces, gluedFaceEdges);

    %delete the external edges and leave just the ones found surrounding semantic
    %objects
    [internalBoundaryPoints] = deleteOutterBoundaries(boundaryPoints, externalBoundaryPoints);

    %check for concordance between the edge points identified because of the
    %two methods used
    %[edgePoints] = presentBothVectors(edgePointsByNormal, internalBoundaryPoints);
    
    %Consensus analisys
    [edgePoints, edgesWeight] = consensusAnalysis(edgePointsByNormal, internalBoundaryPoints, externalBoundaryPoints, coincidentLabels);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%[ADAPTING OUTPUT]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %adapt the output to work with the algorithm cretated in Australia
    [points, labels, labelsWeight] = formatingDataOutput (edgePoints, obj.v, edgesWeight);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%[DISPLAY RESULTS]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Display points
    %displayPointsByLabels (obj.f.v, obj.f.sem, obj.v, internalBoundaryPoints, ["wall"], 'y', 'b');

    %display mesh
    %displayFacesByLabels (gluedFaces, obj.f.sem, obj.v, edgePoints, ["column"], [], 'b')
end
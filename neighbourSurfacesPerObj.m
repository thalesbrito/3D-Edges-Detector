function [normalDif, faceEdges] = neighbourSurfacesPerObj(faces, normals, faceNormals, pointsPerObj)
    lastPos = 0;
    normalDif = [];
    faceEdges = [];
    
    for h = 1:size(pointsPerObj,1)
        initPos = lastPos + 1;
        lastPos = lastPos + pointsPerObj(h);
        [auxNormalDif, auxFaceEdges] = neighbourSurfaces(faces(initPos:lastPos,:), normals, faceNormals(initPos:lastPos,:));
        normalDif = [normalDif; auxNormalDif];
        faceEdges = [faceEdges; auxFaceEdges];
    end
end
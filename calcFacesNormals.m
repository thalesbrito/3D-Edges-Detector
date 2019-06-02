function [calcNormals, indCalcNormals ] = calcFacesNormals (faces, verticies)
    calcNormals = zeros(size(faces,1),3);
    indCalcNormals = zeros(size(faces,1),1);

    for i = 1:size(faces,1)
        A = verticies(faces(i,1),:);
        B = verticies(faces(i,2),:);
        C = verticies(faces(i,3),:);
        X = A-C;
        Y = C-B;
        indCalcNormals(i,:) = i;
        calcNormals(i,:) = cross(X,Y);
    end
end
%Highlight the points that belong to an edge
%which is between two triangles, when those triangular surfaces have their
%normal difference above `curValue`.
function [vert] = findEdgesByNormal(faces, normalDif, lowerAngle, upperAngle)

    normalDifCut = (normalDif<upperAngle).*normalDif;
    normalDifCut = (normalDifCut>lowerAngle).*normalDif;
    [row, col] = find(normalDifCut); %find nonzero locations 
    vert = [];

    for i = 1:size(row,1)
        if col == 1
            vert = [vert; faces(row(i),1); faces(row(i),2)];
        elseif col == 2
            vert = [vert; faces(row(i),1); faces(row(i),3)];
        else
            vert = [vert; faces(row(i),2); faces(row(i),3)]; 
        end
    end
    vert = unique(vert);
end

% figure;
% scatter3(obj.v(:,1),obj.v(:,2),obj.v(:,3),'.','y')
% hold on;
% scatter3(obj.v(vert,1),obj.v(vert,2),obj.v(vert,3),'*','b')
% hold off;
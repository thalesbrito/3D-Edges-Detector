%Given a surface, this function is meant to find the other surfaces related
%to each one of the surface's edges

%A surface [v1, v2, v3] has the edges [v1, v2; v1, v3; v2, v3]
%It will be generated a vector [f1, f2, f3] correpondant to this surface
%in which f1 will be the the surface which intersects edge [v1, v2],  etc.
%It will be generated another vector with the angle difference between the
%two surfaces.

%Code to visualise the trigule mesh
%tr = triangulation(obj.f.v,obj.v(:,1),obj.v(:,2),obj.v(:,3));
%trimesh(tr)
function [normalDif, faceEdges] = neighbourSurfaces(faces, normals, faceNormals)

    %creates the edges and normals vector
    normalDif = ones(size(faces,1),3).*(-1);
    faceEdges = zeros(size(faces,1),3);

    for face = 1:size(faces,1)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%For edges [v1, v2]  and [V1, v3]%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (faceEdges(face,1)==0)||(faceEdges(face,2)==0)
            %find the surfaces that share the "face(face, 1)"
            [row1, col1] = find(faces == faces(face, 1)); %%%%%%%%%%%%% se (faceEdges(face,1)==0)||(faceEdges(face,2)==0)

            %for all the surfaces that share the vertex "face(face, 1)",
            %whithin the for it will be checked whether they share another
            %vertex. If yes, it means that the surfaces share an edge.
            for i = 1:size(row1,1)
                %avoid matching surface 'a' whith itself. Also, if
                %faceEdges(face, 1) == -1, it means that the [V1, V2] edge
                %has already been found as a neighbour of another face
                if (row1(i)~=face)
                    col2 = 0;
                    if (faceEdges(face, 1) == 0)
                        %Try finding the second matching vertex
                        col2 = find(faces(row1(i),:) == faces(face, 2));
                    end
                    if col2
                        faceEdges(face,1) = row1(i);
                        %Calculating the angle btw the surfaces
                        v1 = normals(faceNormals(face,1),:);
                        v2 = normals(faceNormals(row1(i),1),:);
                        normalDif(face,1) = rad2deg(pi - atan2(norm(cross(v1,v2)),dot(v1,v2)));
                        if col1(i) == 1
                            if col2 == 2
                                faceEdges(row1(i),1) = -1*face;
                            else
                                faceEdges(row1(i),2) = -1*face;
                            end
                        elseif col1(i) == 2
                            if col2 == 1
                                faceEdges(row1(i),1) = -1*face;
                            else
                                faceEdges(row1(i),3) = -1*face;
                            end
                        elseif col2 == 1
                            faceEdges(row1(i),2) = -1*face;
                        else
                            faceEdges(row1(i),3) = -1*face;
                        end
                        %break;
                    else
                        if (row1(i)~=face) && (faceEdges(face, 2) == 0)
                            %Try finding the second matching vertex
                            col2 = find(faces(row1(i),:) == faces(face, 3));
                            if col2
                                faceEdges(face,2) = row1(i);
                                %Calculating the angle btw the surfaces
                                v1 = normals(faceNormals(face,1),:);
                                v2 = normals(faceNormals(row1(i),1),:);
                                normalDif(face,2) = rad2deg(pi - atan2(norm(cross(v1,v2)),dot(v1,v2)));
                                if col1(i) == 1
                                    if col2 == 2
                                        faceEdges(row1(i),1) = -1*face;
                                    else
                                        faceEdges(row1(i),2) = -1*face;
                                    end
                                elseif col1(i) == 2
                                    if col2 == 1
                                        faceEdges(row1(i),1) = -1*face;
                                    else
                                        faceEdges(row1(i),3) = -1*face;
                                    end
                                elseif col2 == 1
                                    faceEdges(row1(i),2) = -1*face;
                                else
                                    faceEdges(row1(i),3) = -1*face;
                                end
                                %break;
                            end
                        end
                    end
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%
        %%%For edges [v2, v3]%%%
        %%%%%%%%%%%%%%%%%%%%%%%%

        %If faceEdges(face, 3) ~= 0, it means that the [V2, V3] edge
        %has already been found as a neighbour of another face
        if (faceEdges(face,3)==0)

            %find the surfaces that share the "face(face, 2)"
            [row1, col1] = find(faces == faces(face, 2));

            %for all the surfaces that share the vertex "face(face, 2)",
            %whithin the for it will be checked whether they share another
            %vertex. If yes, it means that the surfaces share an edge.
            for i = 1:size(row1,1)

                %avoid matching surface 'a' whith itself.
                if (row1(i)~=face)

                    %Try finding the second matching vertex
                    col2 = find(faces(row1(i),:) == faces(face, 3));

                    if col2
                        faceEdges(face,3) = row1(i);
                        %Calculating the angle btw the surfaces
                        v1 = normals(faceNormals(face,1),:);
                        v2 = normals(faceNormals(row1(i),1),:);
                        normalDif(face,3) = rad2deg(pi - atan2(norm(cross(v1,v2)),dot(v1,v2)));
                        if col1(i) == 1
                            if col2 == 2
                                faceEdges(row1(i),1) = -1*face;
                            else
                                faceEdges(row1(i),2) = -1*face;
                            end
                        elseif col1(i) == 2
                            if col2 == 1
                                faceEdges(row1(i),1) = -1*face;
                            else
                                faceEdges(row1(i),3) = -1*face;
                            end
                        elseif col2 == 1
                            faceEdges(row1(i),2) = -1*face;
                        else
                            faceEdges(row1(i),3) = -1*face;
                        end
                        %break;
                    end
                end
            end
        end
    end
end

    
    
    

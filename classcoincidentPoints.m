%gets the mesh faces
faces = obj.f.v;

classCoincidentPoints = [0 0 0];

for face = 1:size(faces,1)
    %find the surfaces that share the "face(face, 1)"
    [row1, col1] = find(faces == faces(face, 1));
    for i = 1:size(row1,2)
        if (obj.f.sem(row1(i),1)~=obj.f.sem(face,1))||(obj.f.sem(row1(i),2)~=obj.f.sem(face,2))%check differnt labels
            %check if the point was already stored in the matrix classCoincidentPoints
            row2 = find(classCoincidentPoints(:,1) == faces(face,1));
            for j = 1:size(row2,2)
                if ~(find(classCoincidentPoints(row2(j),2:3)==face) && find(classCoincidentPoints(row2(j),2:3)==row1(i)))
                    classCoincidentPoints = [classCoincidentPoints; faces(face,1) face row1(i)];
                end
            end
        end
    end
end

for face = 1:size(faces,2)
    %find the surfaces that share the "face(face, 1)"
    [row1, col1] = find(faces == faces(face, 2));
    for i = 1:size(row1,2)
        if (obj.f.sem(row1(i),1)~=obj.f.sem(face,1))||(obj.f.sem(row1(i),2)~=obj.f.sem(face,2))%check differnt labels
            %check if the point was already stored in the matrix classCoincidentPoints
            row2 = find(classCoincidentPoints(:,1) == faces(face,2));
            for j = 1:size(row2,2)
                if ~(find(classCoincidentPoints(row2(j),2:3)==face) && find(classCoincidentPoints(row2(j),2:3)==row1(i)))
                    classCoincidentPoints = [classCoincidentPoints; faces(face,2) face row1(i)];
                end
            end
        end
    end
end

for face = 1:size(faces,3)
    %find the surfaces that share the "face(face, 1)"
    [row1, col1] = find(faces == faces(face, 3));
    for i = 1:size(row1,2)
        if (obj.f.sem(row1(i),1)~=obj.f.sem(face,1))||(obj.f.sem(row1(i),2)~=obj.f.sem(face,2))%check differnt labels
            %check if the point was already stored in the matrix classCoincidentPoints
            row2 = find(classCoincidentPoints(:,1) == faces(face,3));
            for j = 1:size(row2,2)
                if ~(find(classCoincidentPoints(row2(j),2:3)==face) && find(classCoincidentPoints(row2(j),2:3)==row1(i)))
                    classCoincidentPoints = [classCoincidentPoints; faces(face,3) face row1(i)];
                end
            end
        end
    end
end

classCoincidentPoints = classCoincidentPoints(2:end,:);


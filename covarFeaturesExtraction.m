%Thales Rodrigues de Brito - Engineering Research - ANU
%Extracting features related to the covariance matrix of points within M

%-------------------------------------------------------------------------%
%FEATURES IDENTIFICATION
%-------------------------------------------------------------------------%
%f1 = Sum
%f2 = Omnivariance
%f3 = Eigenentropy
%f4 = Anisotropy
%f5 = Planarity
%f6 = Linearity
%f7 = Surface Variation
%f8 = Sphericity
%f9 = Verticallity
%-------------------------------------------------------------------------%
%

function [featuresMatrix] = covarFeaturesExtraction(downSampledM, analysedPoints, neighbSize, kdModel, labels)

%M --> the rows are the points and the columns their position [x, y, z]

%Matrix to store the feature vector for each point for each defined scale
%rows: points
%columns: different neighbourhoods
featuresMatrix = zeros(size(analysedPoints, 1), length(neighbSize)*9); %9 is the number of features

%Gets the indexes and distances of the points whithin defined neighbourhood
for aux1 = 1:length(neighbSize)
    disp('Neigbourhood Size');
    display(neighbSize(aux1));
    featLastPos = aux1*9-9;
    actualNeighbSize = neighbSize(aux1);
    %Find points within a spheric region of the pre-defined radius
    Idx = rangesearch(kdModel, analysedPoints, actualNeighbSize);


    %checks max # of neighbours -> to prealocate H
    max = 0;
    for i = 1:size(analysedPoints, 1)
        if length(Idx{i})>max
            max = length(Idx{i});
        end
    end
    %disp(max)
    H = zeros(max+1, 3);

    %covariance Matrix Calculation - Considers the actual point as the centroid    
    for aux2 = 1:size(analysedPoints, 1)
        numberNeighb = length(Idx{aux2});
        
        if numberNeighb>3
            %disp(Idx{aux2});
            %idxDownSampledM(Idx(aux2, :)) --> contain the indexes in M of
            %the neinghbours
            
            %ponto = [analysedPoints(aux2, 1), analysedPoints(aux2, 2), analysedPoints(aux2, 3)]
            %vizinhos = [downSampledM(Idx{aux2, :}, 1),downSampledM(Idx{aux2, :}, 2),downSampledM(Idx{aux2, :}, 3)] 
            
            centroidX = (sum(downSampledM(Idx{aux2, :}, 1)) + analysedPoints(aux2, 1))/(numberNeighb+1); %calculating centroid
            %display(centroidX);
            centroidY = (sum(downSampledM(Idx{aux2, :}, 2)) + analysedPoints(aux2, 2))/(numberNeighb+1);
            %display(centroidY);
            centroidZ = (sum(downSampledM(Idx{aux2, :}, 3)) + analysedPoints(aux2, 3))/(numberNeighb+1);
            %display(centroidZ);
            %centroide= [centroidX,centroidY,centroidZ]

            for aux3 = 1:(numberNeighb) 
                    %display('calc');
                    %display((M(currentNeighb, 1)));
                    H(aux3,1) = sqrt((downSampledM(Idx{aux2}(aux3), 1) - centroidX)^2); %Should I calculate th euclidean distance?
                    H(aux3,2) = sqrt((downSampledM(Idx{aux2}(aux3), 2) - centroidY)^2); %Did I misunderstood the meaning of centroid?
                    H(aux3,3) = sqrt((downSampledM(Idx{aux2}(aux3), 3) - centroidZ)^2);
                    %should I include the actual point?
            end
            %SEEMS TO BE USED TO CALCULATE THE DISTANCE OF THE CENTOIDE TO
            %THE ANALYSED POINT
            if downSampledM(Idx{aux2}(1), :) ~= analysedPoints(aux2, :)
                H(aux3+1,1) = sqrt((analysedPoints(aux2, 1) - centroidX)^2); %Should I calculate th euclidean distance?
           	    H(aux3+1,2) = sqrt((analysedPoints(aux2, 2) - centroidY)^2); %Did I misunderstood the meaning of centroid?
                H(aux3+1,3) = sqrt((analysedPoints(aux2, 3) - centroidZ)^2);    
                covarMatrix = (H(1:numberNeighb+1, :)'*H(1:numberNeighb+1, :))/(numberNeighb+1);
            else
                covarMatrix = (H(1:numberNeighb, :)'*H(1:numberNeighb, :))/(numberNeighb);
            end

            %display(aux2);
            %display(H(1:numberNeighb, :));
            %display('covMatrix');
            %display(covarMatrix);
        
            %Obtaining biggest eigenvalues and eigenvectors
            [eVectors, eValues] = eigs(covarMatrix);
            eValues = abs(eValues);
%             if (aux1 == 1)
%                 disp(downSampledM(Idx{aux2, :}, :));
%                 %plots all the neighbours
%                 scatter3(downSampledM(Idx{aux2, :}, 1),downSampledM(Idx{aux2, :}, 2),downSampledM(Idx{aux2, :}, 3), '*', 'b');
%                 hold on;
% 
%                 %plots the point being analysed
%                 scatter3(analysedPoints(aux2, 1), analysedPoints(aux2, 2), analysedPoints(aux2, 3),'*', 'k');
%                 if labels(aux2) == 1
%                     text(analysedPoints(aux2, 1), analysedPoints(aux2, 2), analysedPoints(aux2, 3), {'Edge'});
%                 else
%                     text(analysedPoints(aux2, 1), analysedPoints(aux2, 2), analysedPoints(aux2, 3), {'Non-Edge'});
%                 end
% 
%                 hold on;
% 
%                 %plots the centroid
%                 scatter3(centroidX,centroidY,centroidZ, '*', 'r');
%                 text(centroidX,centroidY,centroidZ, {'Centroid'});
%                 hold on;
% 
%                 %plots eigenvectors
%                 quiver3(centroidX,centroidY,centroidZ, eVectors(1,1)*eValues(1,1), eVectors(2,1)*eValues(1,1), eVectors(3,1)*eValues(1,1));
%                 quiver3(centroidX,centroidY,centroidZ, eVectors(1,2)*eValues(2,2), eVectors(2,2)*eValues(2,2), eVectors(3,2)*eValues(2,2));
%                 quiver3(centroidX,centroidY,centroidZ, eVectors(1,3)*eValues(3,3), eVectors(2,3)*eValues(3,3), eVectors(3,3)*eValues(3,3));
%                 axis equal;
%                 hold off;
%             end
            %eValues(3,3)>eValues(2,2)eValues(1,1)>=0

            %display('eValues');
            %display(eValues);
            %Defining each feature and Filling the multiscale feature matrix

            %Checking for negative zeros
            if eValues(1, 1) <= 0
                %%All the eigenvalues are zero or negative
                featuresMatrix(aux2, featLastPos+1:featLastPos+8) = [0 0 0 0 0 0 0 0];
                featuresMatrix(aux2, featLastPos+9) = 1 - abs(eVectors(1, 1));
            else
                %none of the eigenvalues are zero or negative
            	featuresMatrix(aux2, featLastPos+1) = eValues(1,1)+eValues(2,2)+eValues(3,3);
                featuresMatrix(aux2, featLastPos+2) = (eValues(1,1)*eValues(2,2)*eValues(3,3))^(1/3);
                featuresMatrix(aux2, featLastPos+3) = (eValues(1,1)*log(eValues(1,1)))+(eValues(2,2)*log(eValues(2,2)))+(eValues(3,3)*log(eValues(3,3)));   
                featuresMatrix(aux2, featLastPos+4) = (eValues(3,3)-eValues(1,1))/eValues(3,3); 
                featuresMatrix(aux2, featLastPos+5) = (eValues(2,2)-eValues(1,1))/eValues(3,3);
                featuresMatrix(aux2, featLastPos+6) = (eValues(3,3)-eValues(2,2))/eValues(3,3);
                featuresMatrix(aux2, featLastPos+7) = eValues(1,1)/featuresMatrix(aux2, featLastPos+1);
                featuresMatrix(aux2, featLastPos+8) = eValues(1,1)/eValues(3,3);
                featuresMatrix(aux2, featLastPos+9) = 1 - abs(eVectors(1, 1));
            end
        else
            featuresMatrix(aux2, featLastPos+1:featLastPos+9) = [0 0 0 0 0 0 0 0 0];
        end
    end
end



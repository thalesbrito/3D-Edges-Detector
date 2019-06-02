%function to find the average, max and min normal variation in a class
class = obj.f.sem(1,1);
instanceNum = obj.f.sem(1,2);
roomType = obj.f.sem(1,3);
roomNum = obj.f.sem(1,4);
areaNum = obj.f.sem(1,5);

sameLabel = 1;
totalNonZero = 0;
sumDifNormals = 0;
maxDif = 0;
minDif = 4;
normalDifClass = [];

for i = 1:size(normalDif,1)
    if (obj.f.sem(i,1)~=class || obj.f.sem(i,2)~=instanceNum || obj.f.sem(i,3)~=roomType || obj.f.sem(i,4)~=roomNum || obj.f.sem(i,5)~=areaNum)
        %save results
        normalDifClass = [normalDifClass; class instanceNum roomType roomNum areaNum sumDifNormals/totalNonZero maxDif minDif];
        sameLabel = 0;
        totalNonZero = 0;
        sumDifNormals = 0;
        maxDif = 0;
        minDif = 200;
        
        class = obj.f.sem(i,1);
        instanceNum = obj.f.sem(i,2);
        roomType = obj.f.sem(i,3);
        roomNum = obj.f.sem(i,4);
        areaNum = obj.f.sem(i,5);
    end

    nonZero = normalDif(i,:) >= 0;
    totalNonZero = totalNonZero + sum(nonZero);
    sumDifNormals = sumDifNormals + sum(normalDif(i,:));
    maximum = max(normalDif(i,:));
    minimum = min(normalDif(i,nonZero));
    if maxDif < maximum
        maxDif = maximum;
    end
    if minDif > minimum
        minDif = minimum;
    end
    
end
normalDifClass = [normalDifClass; class instanceNum roomType roomNum areaNum sumDifNormals/totalNonZero maxDif minDif];

    
    
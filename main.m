%neighbSize = [0.01, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6, 3.2];
neighbSize = [0.1, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0, 1.2, 1.6];
downsampleRate = 1;
% trainSplitRate = 0.7;
rateE_NE = 5;

%-------------------------------------------------------------------------%
%GENERATE LABELED AND UNORDERED DATA
%-------------------------------------------------------------------------%
%Input parameters:
%1 - Area from the dataset
%[points, labels, labelsWeight] = generateData(3,obj);
load('after_generate_data(01-06).mat')

%-------------------------------------------------------------------------%
%SPLIT AND NORMALIZE DATA (1 E --> rateE_NE NE) FOR TRAINING AND TESTING
%(THE FEATURES WILL BE CALCULATED FOR ALL THESE POINTS)
%-------------------------------------------------------------------------%
numPoints = size(points,1);
edgesIndx = find(labels==1);
nEdgesIndx = find(labels==-1);
numEdges = size(edgesIndx,1);
numNEdges = size(nEdgesIndx,1);
if rateE_NE*numEdges<= numNEdges
    chosenNEPoints = nEdgesIndx(randperm(numNEdges, rateE_NE*numEdges));
    normPoints = [points(chosenNEPoints,:); points(edgesIndx,:)];
    normLabels = [-1*ones(rateE_NE*numEdges,1);ones(numEdges,1)];
    normLabelsWeight = [labelsWeight(chosenNEPoints,:); labelsWeight(edgesIndx,:)];
else
    chosenNEPoints = nEdgesIndx(randperm(numNEdges));
    normPoints = [points(chosenNEPoints,:); points(edgesIndx,:)];
    disp('Rate between edges and non-edges not OK. Did not change the rate!');
    normLabels = [-1*ones(numNEdges,1);ones(numEdges,1)];
    normLabelsWeight = [labelsWeight(chosenNEPoints,:); labelsWeight(edgesIndx,:)];
end    
numNormPoints = size(normPoints,1);

%makes the point's order random
permNormPoints = randperm(numNormPoints);
normPoints = normPoints(permNormPoints,:);
normLabels = normLabels(permNormPoints);
normLabelsWeight = normLabelsWeight(permNormPoints);

%Split points
normTrainPoints = []; normTrainLabels = []; normTrainLabelsWeight = [];
normTestPoints = []; normTestLabels = []; normTestLabelsWeight = [];
for i = 1:numNormPoints
    if (normPoints(i,1)<100) %divide the area into two separate areas
        normTrainPoints = [normTrainPoints; normPoints(i,:)];
        normTrainLabels = [normTrainLabels; normLabels(i)];
        normTrainLabelsWeight = [normTrainLabelsWeight; normLabelsWeight(i)];
    else
        normTestPoints = [normTestPoints; normPoints(i,:)];
        normTestLabels = [normTestLabels; normLabels(i)];
        normTestLabelsWeight = [normTestLabelsWeight; normLabelsWeight(i)];
    end
end

%-------------------------------------------------------------------------%
%SPLIT AND DOWNSAMPLE DATA FOR TRAINING AND TESTING 
%(THESE POINTS WILL BE THE NEIGHBOURHOOD TO BE ANALYSED)
%-------------------------------------------------------------------------%
%%Randon downsampling
% downSampledPerm = randperm(numPoints, ceil(numPoints*downsampleRate));
% downSampledPoints = points(downSampledPerm,:);
% numDownSampledPoints = size(downSampledPoints,1);

%Creates a point cloud object
pointCloudObj = pointCloud(points);

%denoise point cloud
pointCloudDenoised = pcdenoise(pointCloudObj, 'Threshold', 1, 'NumNeighbors', 4); %default 1 e 4

%downsample-->remove redundant points from the point cloud
pointCloudDownSampled = pcdownsample(pointCloudDenoised,'gridAverage',0.03);

% %Calculate and display normals
% figure; 
% hold on;
% pcshow(pointCloudDownSampled);
% x = pointCloudDownSampled.Location(1:10:end,1);
% y = pointCloudDownSampled.Location(1:10:end,2);
% z = pointCloudDownSampled.Location(1:10:end,3);
% u = normals(1:10:end,1);
% v = normals(1:10:end,2);
% w = normals(1:10:end,3);
% quiver3(x,y,z,u,v,w);
% hold off
% axis equal

downSampledPoints = pointCloudDownSampled.Location;
numDownSampledPoints = size(downSampledPoints,1);

%Split points
downSampledTrainPoints = []; downSampledTestPoints = [];
for i = 1:numDownSampledPoints
    if (downSampledPoints(i,1)<100) %divide the area into two separate areas
        downSampledTrainPoints = [downSampledTrainPoints; downSampledPoints(i,:)];
    else
        downSampledTestPoints = [downSampledTestPoints; downSampledPoints(i,:)];
    end
end

%-------------------------------------------------------------------------%
%FEATURES EXTRACTION
%-------------------------------------------------------------------------%

%kd-tree model
kdModelTrain = createns(downSampledTrainPoints, 'distance', 'euclidean', 'BucketSize', 50); %ADD 'BucketSize', xxx --> 50 is the default
kdModelTest = createns(downSampledTestPoints, 'distance', 'euclidean', 'BucketSize', 50);

%Extracting features related to the covariance matrix of points within M
%for each defined scale
trainFeaturesMatrix = covarFeaturesExtraction(downSampledTrainPoints, normTrainPoints, neighbSize, kdModelTrain, normTrainLabels);
testFeaturesMatrix = covarFeaturesExtraction(downSampledTestPoints, normTestPoints, neighbSize, kdModelTest, normTestLabels);

%-------------------------------------------------------------------------%
%TRAINNING MODEL
%-------------------------------------------------------------------------%
%Mdl = fitcensemble(trainFeaturesMatrix, normTrainLabels, 'ClassNames', [-1,1], 'OptimizeHyperparameters', 'auto');

%Mdl1 = fitcensemble(trainFeaturesMatrix, normTrainLabels, 'method', 'AdaBoostM1', 'NumLearningCycles', 500, 'Learners', 'Tree');

%Mdl2 = fitcensemble(trainFeaturesMatrix, normTrainLabels, 'method', 'GentleBoost', 'NumLearningCycles', 18, 'Learners', 'Tree');

Mdl3 = fitcensemble(trainFeaturesMatrix, normTrainLabels, 'method', 'Bag', 'Learners', 'Tree');

%-------------------------------------------------------------------------%
%CLASSIFIER
%-------------------------------------------------------------------------%
trainPredictedLabels = predict(Mdl3,trainFeaturesMatrix);

testPredictedLabels = predict(Mdl3,testFeaturesMatrix);

%-------------------------------------------------------------------------%
%PERFORMANCE EVALUATION 
%-------------------------------------------------------------------------%
%trainning
[lossFuncTrain, precisionTrain, recallTrain] = performanceEvaluation(normTrainLabels, trainPredictedLabels);

%test
[lossFuncTest, precisionTest, recallTest] = performanceEvaluation(normTestLabels, testPredictedLabels);

%-------------------------------------------------------------------------%
%SHOW RESULT
%-------------------------------------------------------------------------%
% figure;
% axis equal;
% pcshow(normTrainPoints);
% hold on;
% colormap white;
% idx = find(trainPredictedLabels == 1);
% scatter3(normTrainPoints(idx,1), normTrainPoints(idx,2),normTrainPoints(idx,3),'*', 'k');
% hold off;
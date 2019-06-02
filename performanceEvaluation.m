function [lossFunc, precision, recall] = performanceEvaluation(Labels, PredictedLabels)

%Loss Function
%think that the loss function is wrong - need to multiply by -1
lossFunc = sum(((Labels .* (PredictedLabels*-1)) + 1)./2);
display (size(Labels,1), 'Loss Function Max Value:');
display(lossFunc, 'Sum Loss Function');

%Precision-Recall
trueLabels = (((Labels .* PredictedLabels) + 1)./2);
falseLabels = (((Labels .* (PredictedLabels*-1)) + 1)./2);
posPredic = (Labels+1)./2;
negPredic = abs((Labels-1)./2);

tp = sum(trueLabels .* posPredic)
fp = sum(falseLabels .* posPredic)
tn = sum(trueLabels .* negPredic)
fn = sum(falseLabels .* negPredic)

precision = tp/(tp + fp); %all the samples label as +
display(precision);
recall = tp/(tp + fn); %all that should be labed +
display(recall);
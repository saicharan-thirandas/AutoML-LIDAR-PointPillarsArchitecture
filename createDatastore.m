% createDatastore.m
function [trainData, trainLabels, testData, testLabels] = createDatastore(croppedPointCloudObj, processedLabels, outputFolder)
    rng(1);
    shuffledIndices = randperm(size(processedLabels, 1));
    idx = floor(0.7 * length(shuffledIndices));
    
    trainData = croppedPointCloudObj(shuffledIndices(1:100), :);
    testData = croppedPointCloudObj(shuffledIndices(idx + 1:end), :);
    trainLabels = processedLabels(shuffledIndices(1:100), :);
    testLabels = processedLabels(shuffledIndices(idx + 1:end), :);
    
    dataLocation = fullfile(outputFolder, 'InputData');
    writeFiles = true;
    [trainData, trainLabels] = saveptCldToPCD(trainData, trainLabels, dataLocation, writeFiles);
    
    dataLocation_val = fullfile(outputFolder, 'ValData');
    [testData, testLabels] = saveptCldToPCD(testData, testLabels, dataLocation_val, writeFiles);
end

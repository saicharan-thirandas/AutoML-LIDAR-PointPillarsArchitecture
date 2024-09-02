% makeObjFcn.m
function ObjFcn = makeObjFcn(cdsAugmented, cds_val, trainData, trainLabels, testData, testLabels)
    ObjFcn = @valErrorFun;
    
    function [valError, cons, fileName] = valErrorFun(optVars)
        P = 12000; % Number of prominent pillars
        xMin = 0.0; yMin = -39.68; zMin = -5.0;
        xMax = 69.12; yMax = 39.68; zMax = 5.0;
        xStep = 0.16; yStep = 0.16; dsFactor = 2.0;

        pointCloudRange = [xMin xMax yMin yMax zMin zMax];
        voxelSize = [xStep yStep];
        
        N = 100; % Number of points per pillar
        anchorBoxes = calculateAnchorsPointPillars(trainLabels);
        classNames = trainLabels.Properties.VariableNames;
        
        detector = pointPillarsObjectDetector(pointCloudRange, classNames, anchorBoxes, ...
            'VoxelSize', voxelSize, 'NumPillars', P, 'NumPointsPerPillar', N);
        
        options = trainingOptions('adam', ...
            'Plots', "none", ...
            'MaxEpochs', 4, ...
            'MiniBatchSize', 4, ...
            'InitialLearnRate', optVars.InitialLearnRate, ...
            'ValidationData', cds_val, ...
            'ValidationFrequency', floor(numel(trainLabels) / 4), ...
            'CheckpointPath', tempdir);
        
        if doTraining    
            [detector, info] = trainPointPillarsObjectDetector(cdsAugmented, detector, options);
        else
            pretrainedDetector = load('pretrainedPointPillarsDetector.mat', 'detector');
            detector = pretrainedDetector.detector;
        end
        
        % Calculate validation error
        detectionResults = detect(detector, testData(1:50, :), 'Threshold', 0.25);
        metrics = evaluateDetectionAOS(detectionResults, groundTruthData, 0.5);
        valError = 1 - mean(metrics.AP);
        
        % Save results
        fileName = strcat(num2str(valError), ".mat");
        save(fileName, 'detector', 'valError', 'options');
        cons = [];
    end
end

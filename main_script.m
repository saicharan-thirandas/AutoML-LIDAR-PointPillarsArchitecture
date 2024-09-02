% main_script.m

% Set parameters
doTraining = false;
outputFolder = fullfile(tempdir, 'Pandaset');

% Download dataset
lidarURL = ['https://ssd.mathworks.com/supportfiles/lidar/data/' ...
    'Pandaset_LidarData.tar.gz'];
helperDownloadPandasetData(outputFolder, lidarURL);

% Load Data
path = fullfile(outputFolder, 'Lidar');
lidarData = fileDatastore(path, 'ReadFcn', @(x) pcread(x));
gtPath = fullfile(outputFolder, 'Cuboids', 'PandaSetLidarGroundTruth.mat');
data = load(gtPath, 'lidarGtLabels');
Labels = timetable2table(data.lidarGtLabels);
boxLabels = Labels(:, 2:3);

% Display Point Cloud
ptCld = read(lidarData);
helperDisplayPointCloud(ptCld);

% Preprocessing
[croppedPointCloudObj, processedLabels] = preprocessLidarData(lidarData, boxLabels);

% Create Datastore
[trainData, trainLabels, testData, testLabels] = createDatastore(croppedPointCloudObj, processedLabels, outputFolder);

% Data Augmentation
cdsAugmented = augmentData(cds, outputFolder);

% Bayesian Optimization
ObjFcn = makeObjFcn(cdsAugmented, cds_val, trainData, trainLabels, testData, testLabels);
optimVars = [optimizableVariable('InitialLearnRate', [1e-2 1], 'Transform', 'log')];
BayesObject = bayesopt(ObjFcn, optimVars, 'MaxTime', 600, 'IsObjectiveDeterministic', false, 'UseParallel', false);

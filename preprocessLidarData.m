% preprocessLidarData.m
function [croppedPointCloudObj, processedLabels] = preprocessLidarData(lidarData, boxLabels)
    % Define parameters
    xMin = 0.0; yMin = -39.68; zMin = -5.0;
    xMax = 69.12; yMax = 39.68; zMax = 5.0;
    xStep = 0.16; yStep = 0.16; dsFactor = 2.0;

    pointCloudRange = [xMin xMax yMin yMax zMin zMax];
    
    % Crop the lidar data
    [croppedPointCloudObj, processedLabels] = cropFrontViewFromLidarData(lidarData, boxLabels, pointCloudRange);
    reset(lidarData);
end

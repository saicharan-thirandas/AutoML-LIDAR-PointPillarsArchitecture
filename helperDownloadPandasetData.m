% helperDownloadPandasetData.m
function helperDownloadPandasetData(outputFolder, lidarURL)
    lidarDataTarFile = fullfile(outputFolder, 'Pandaset_LidarData.tar.gz');
    if ~exist(lidarDataTarFile, 'file')
        mkdir(outputFolder);
        disp('Downloading PandaSet Lidar driving data (5.2 GB)...');
        websave(lidarDataTarFile, lidarURL);
        untar(lidarDataTarFile, outputFolder);
    end
    
    % Extract the file.
    if (~exist(fullfile(outputFolder, 'Lidar'), 'dir')) && ...
       (~exist(fullfile(outputFolder, 'Cuboids'), 'dir'))
        untar(lidarDataTarFile, outputFolder);
    end
end

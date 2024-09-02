% augmentData.m
function cdsAugmented = augmentData(cds, outputFolder)
    classNames = {'Car', 'Truck'};
    sampleLocation = fullfile(outputFolder, 'GTsamples');
    [ldsSampled, bdsSampled] = sampleLidarData(cds, classNames, 'MinPoints', 20, 'Verbose', false, 'WriteLocation', sampleLocation);
    cdsSampled = combine(ldsSampled, bdsSampled);
    
    numObjects = [10 10];
    cdsAugmented = transform(cds, @(x) pcBboxOversample(x, cdsSampled, classNames, numObjects));
    cdsAugmented = transform(cdsAugmented, @(x) augmentData(x));
end

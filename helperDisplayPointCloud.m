% helperDisplayPointCloud.m
function helperDisplayPointCloud(ptCld)
    figure;
    ax = pcshow(ptCld.Location);
    set(ax, 'XLim', [-50 50], 'YLim', [-40 40]);
    zoom(ax, 2.5);
    axis off;
end

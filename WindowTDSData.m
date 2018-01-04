function [x_windowed, y_windowed] = WindowTDSData(x,y,PeakPosition,preScanDist,postScanDist)

% Window TeraView/Menlo TDS data
% inpus:
% x - vector of delay line position
% y - vector of signal
% preScanDist = relative distance left of the peak
% postScanDist = relative distance right of the peak

[~, PeakPosInd] = min(abs(x-PeakPosition));

if (x(PeakPosInd)-preScanDist)>=x(1)
    RemovePreWindowRange = find(x<=(x(PeakPosInd)-preScanDist));
    StartWindowIndex = RemovePreWindowRange(end);
else
    disp('Pre window size is out of range. Taking first x point for window limit');
    StartWindowIndex = 1;
end;

if (x(PeakPosInd)+postScanDist)<=x(end)
    RemovePostWindowRange = find(x(:,1)>=(x(PeakPosInd)+postScanDist));
    EndWindowIndex = RemovePostWindowRange(1);
else
    disp('Post window size is out of range. Taking last x point for window limit');
    EndWindowIndex = length(x(:,1));
end;

x_windowed = x(StartWindowIndex:EndWindowIndex);
y_windowed = y(StartWindowIndex:EndWindowIndex);

end
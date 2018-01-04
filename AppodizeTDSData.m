function [x_appodized, y_appodized, y_shift] = AppodizeTDSData(x,y,PeakPosition)

% Appodize Menlo/TeraView TDS data
% inputs:
% x - vector of time in psec
% y - vector of signal
% PeakPosition - in mm or ps

[~, PeakPosInd] = min(abs(x(:,1)-PeakPosition)); %finding location of peak in picoseconds. Why take min?
[xRows, xCols] = size(x);

AppWindowLength = (xRows - PeakPosInd)*2; %why subtract peak position?

AppWindow = tukeywin(AppWindowLength(1),0.1); %creates a vector of the same length of AppWindowLength, with a cosine tapered section on each section that amounts to 10percent of the data
AppTailLength = find(AppWindow==1,1,'first');
if (AppTailLength<PeakPosInd) && (AppTailLength<(xRows-PeakPosInd))
    AppWindow_Post = AppWindow(AppWindowLength/2+1:end);
    AppWindow_Pre = AppWindow(1:PeakPosInd);
    AppWindowVector = vertcat(AppWindow_Pre,AppWindow_Post);
    AppWindowMat = repmat(AppWindowVector,1,xCols);
    y_shift = mean(y);
    y_mean = repmat(y_shift,xRows,1);
    y_appodized = (y-y_mean).*AppWindowMat;
    x_appodized = x;
else
    y_appodized = y;
    x_appodized = x;
    y_shift = zeros(1,xCols);
end

end
function [tvec] = Position_to_Time_Menlo(x)

    tvec = (x+1.5e5)/3840; % in ps
    % 3840 steps/ps for the delay line and setting -150,000 steps as t=0
    
end
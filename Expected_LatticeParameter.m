function [a] = Expected_LatticeParameter(h, k, l, TwoTheta)

%Inputs:
%h, k, l refer to the predicted orientation of the crystal
%TwoTheta comes from the x-ray defraction plot obtained by experimentally
%characterizing the sample

lambda = 1.5406;
d = lambda/(2*sind(TwoTheta/2));
a = d*((h^2 + k^2 + l^2)^(1/2));

end
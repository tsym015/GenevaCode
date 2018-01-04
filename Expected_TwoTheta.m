function [twotheta] = Expected_TwoTheta(h, k, l, a)

%Inputs:
%a = accepted lattice parameter of predicted element peak
%h, k, l refer to the orientation of the predicted element

lambda = 1.5406;
d = a/((h^2 + k^2 + l^2)^(1/2));
theta = asind(lambda/(2*d));
twotheta = 2*theta;

end
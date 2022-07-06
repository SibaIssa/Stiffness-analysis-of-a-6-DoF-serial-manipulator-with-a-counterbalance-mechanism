function [x, y, z] = manipulator_FDKM(theta1, theta2, theta3)
%MANIPULATOR_DKM Summary of this function goes here
%   Detailed explanation goes here

% Constants
l1 = 1; l2 = 1; l3 = 1;
%

% Calculating the Transformation for the 1st link
T03 = Rz(theta1)*Tz(l1)*Ry(theta2)*Tz(l2)*Ry(theta3)*Tx(l3);

x = T03(1,4);
y = T03(2,4);
z = T03(3,4);
end




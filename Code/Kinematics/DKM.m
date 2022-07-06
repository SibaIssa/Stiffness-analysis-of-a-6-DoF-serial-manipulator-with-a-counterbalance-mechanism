function [T] = DKM(theta1, theta2, theta3, theta4, theta5, theta6, is_plot)

if nargin < 7
    is_plot = false;
end
%DKM Summary of this function goes here
%   Detailed explanation goes here

%constants
l1 = 0.05; l2 = 0.05; l3 = 0.1; l4 = 0.1;l5 = 0.01; eps = 10^(-3);
%

%calculating the Transformation matrix for arm, wrist and end effector
T0w = Rz(theta1)*Tz(l1 + l2)*Ry(theta2)*Tz(l3)*Ry(theta3)*Tx(l4);
Tw6 = Rx(theta4)*Ry(theta5)*Rx(theta6);
T6e = Tx(l5);
T = T0w*Tw6*T6e;
    
%for ploting I have to gather all points from transformation matrics
T01  = Tz(l1)*Rz(theta1);
T12  = Tz(l2)*Ry(theta2);
T23  = Tz(l3)*Ry(theta3);
T3w  = Tx(l4)*Rx(theta4)*Ry(theta5)*Rx(theta6);
Twe = Tx(l5);

if(is_plot)
    P1  = T01;
    P2  = P1*T12;
    P3  = P2*T23;
    P4  = P3*T3w;
    P5  = P4*Twe;
    
    pos = [[0, 0, 0];P1(1:3,4)'; P2(1:3,4)'; P3(1:3,4)'; P4(1:3,4)'; P5(1:3,4)'];
    figure;
    hold on
    grid on
    view(25, 25);
    
    plot3(pos(:,1), pos(:,2), pos(:,3), '-o', 'LineWidth', 1);
end

end


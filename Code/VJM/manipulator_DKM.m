function [result] = manipulator_DKM(theta1, theta2, theta3, is_plot)
%MANIPULATOR_DKM Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    is_plot = false;
end

% Constants
l1 = 1; l2 = 1; l3 = 1; l4 = 0.5; 
a = 0.25; b = 0.25; c = 0.5;
%

% Calculating the Transformation for the 1st link
T01 = Rz(theta1)*Tz(l1);
result.T1 = T01;

% Calculating the Transformation for the 2nd link
T02 = T01*Ry(theta2 + theta3)*Tx(a);
result.T2 = T02;

% Calculating the Transformation for the 3rd link
T03 = T01*Ry(theta2)*Tz(c);
result.T3 = T03;

% Calculating the Transformation for the 4th link
T04 = T01*Tz(b);
result.T4 = T04;

% spring is link 5, 6

% Calculating the Transformation for the 7th link
T07 = T01*Tz(l4);
result.T7 = T07;

% Calculating the Transformation for the 8th link
T08 = T01*Tz(l4)*Ry(theta2)*Tz(l2);
result.T8 = T08;

% Calculating the Transformation for the 9th link
T09 = T01*Ry(theta2)*Tz(l2);
result.T9 = T09;

% Calculating the Transformation for the 10th link
T010 = T09*Ry(-theta2)*Tz(b);
result.T10 = T010;

% Calculating the Transformation for the 11th link
T011 = T09*Ry(-theta2)*Tz(l4);
result.T11 = T011;

% spring is link 12

% Calculating the Transformation for the 13th link
T013 = T09*Ry(theta3)*Tx(a);
result.T13 = T013;

% Calculating the Transformation for the 14th link
T014 = T09*Ry(theta3)*Tx(l3);
result.T14 = T014;
    
%for ploting I have to gather all points from transformation matrics
if(is_plot)
    P0 = [0 0 0]; 
    P1 = T01(1:3,4)';
    P9 = T09(1:3,4)';
    P14 = T014(1:3,4)';
    
    pos = [P0; P1; P9; P14];
    
    P2 = T02(1:3,4)';
    pos1 = [P1; P2];
    
    P7 = T07(1:3,4)';
    P8 = T08(1:3,4)';
    pos2 = [P1; P7; P8; P9];
    
    P4 = T04(1:3,4)';
    pos3 = [P4; P2];
    
    P3 = T03(1:3,4)';
    pos4 = [P4; P3];
    
    P10 = T010(1:3,4)';
    P13 = T013(1:3,4)';
    pos5 = [P10; P13];
    
    figure;
    hold on
    grid on
    view(25, 25);
    
    
    % Ploting the main model
    plot3(pos(:,1), pos(:,2), pos(:,3), '-o', 'LineWidth', 1);
    plot3(pos1(:,1), pos1(:,2), pos1(:,3), '-o', 'LineWidth', 1);
    plot3(pos2(:,1), pos2(:,2), pos2(:,3), '-o', 'LineWidth', 1);
    
    plot3(pos3(:,1), pos3(:,2), pos3(:,3), '--o', 'LineWidth', 1);
    plot3(pos4(:,1), pos4(:,2), pos4(:,3), '--o', 'LineWidth', 1);
    plot3(pos5(:,1), pos5(:,2), pos5(:,3), '--o', 'LineWidth', 1);
end

end




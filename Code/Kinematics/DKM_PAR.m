function [T, LS1, LS2, LS3] = DKM_PAR(theta1, theta2, theta3, theta4, theta5, theta6, is_plot)

if nargin < 7
    is_plot = false;
end
%DKM Summary of this function goes here
%   Detailed explanation goes here

% Constants
l1 = 0.05; l2 = 0.05; l3 = 0.1; l4 = 0.1;l5 = 0.01; eps = 10^(-3);
Sm1 = l3/2; Sm2 = l4/4;
a = 0.05; Sa = a/2;
b = 0.05; Sb = b/2; Sc = b/2;
%

% Calculating the Transformation matrix for arm, wrist and end effector
T01 = Rz(theta1)*Tz(l1 + l2);

% First direction to the wrist
T02 = T01*Ry(theta2)*Tz(l3);
T_P0_S2 = T02*Tz(-(l3 - Sm1));

T0w = T02*Ry(theta3)*Tx(l4);
T_P0_S3 = T0w*Tx(-(l4  - Sm2)); 

% Second direction to the wrist
T_P1_p1 = T01*Ry(theta2+theta3)*Tx(a);
T_P1_S1 = T_P1_p1*Tx(-(a - Sa));
T_P1_S3 = T02*Ry(-theta2)*Tz(Sc); 
T_P1_p2 = T_P1_p1*Ry(-theta3)*Tz(l3);

% Third direction to the wrist
T_P2_p1 = T01*Tz(b);
T_P2_S0 = T_P2_p1*Tz(-(b - Sb));
T_P2_p2 = T_P2_p1*Ry(theta2)*Tz(l3);

T06 = T0w*Rx(theta4)*Ry(theta5)*Rx(theta6);
T = T06*Tx(l5);
    
%for ploting I have to gather all points from transformation matrics
if(is_plot)
    P0 = [0 0 0]; 
    P1 = T01(1:3,4)';
    P2 = T02(1:3,4)';
    P3 = T0w(1:3,4)';
    P4 = T(1:3,4)';
    
    S2_p2 = T_P0_S2(1:3,4)';
    
    P1p1  = T_P1_p1(1:3,4)';
    S1_p2 = T_P1_S1(1:3,4)';
    P1p2  = T_P1_p2(1:3,4)';
    
    P2p1 = T_P2_p1(1:3,4)';
    S12_p1 = T_P2_S0(1:3,4)';
    P2p2 = T_P2_p2(1:3,4)';
    
    S3_p1 = T_P1_S3(1:3,4)';
    S3_p2 = T_P0_S3(1:3,4)';
    
    pos = [P0; P1; P2; P3; P4];
    posp1 = [P1; P1p1; P1p2];
    posp2 = [P1; P2p1; P2p2; P2];
    
    S12 = [S1_p2; S12_p1; S2_p2]; 
    S3 = [S3_p1; S3_p2];
    
    figure;
    hold on
    grid on
    view(25, 25);
    
    % Ploting the main model
    plot3(pos(:,1), pos(:,2), pos(:,3), '-o', 'LineWidth', 1);
    % Ploting the first Paralleogram
    plot3(posp1(:,1), posp1(:,2), posp1(:,3), '-o', 'LineWidth', 1);
    % Ploting the second Paralleogram
    plot3(posp2(:,1), posp2(:,2), posp2(:,3), '-o', 'LineWidth', 1);
    
    % plot the springs
    plot3(S12(:,1), S12(:,2), S12(:,3), '--o', 'LineWidth', 1);
    plot3(S3(:,1), S3(:,2), S3(:,3), '--o', 'LineWidth', 1);
    
 
    LS1 = norm(S12_p1 - S1_p2);
    LS2 = norm(S12_p1 - S2_p2);
    LS3 = norm(S3_p1 - S3_p2);
end

end


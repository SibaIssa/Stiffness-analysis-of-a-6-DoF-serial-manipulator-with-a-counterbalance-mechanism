function [K_link, result] = manipulator_K_links(theta1, theta2, theta3)
%MANIPULATOR_DKM Summary of this function goes here
%   Detailed explanation goes here

K_link = zeros(168, 168);

% const
E = 70 *10e9;  % Young's modulus
G = 25.5*10e9; % Shear modulus
d = 10*10e-3;  % Diameter

l1 = 1; l2 = 1; l3 = 1; l4 = 0.5; 
a = 0.25; b = 0.25; c = 0.5;
% -------------------------------------------------------------------------

% Calculating the Transformation for the 1st link
T01 = Rz(theta1)*Tz(l1);
result.T1 = T01;

K1 = k_cylinder(E, G, d, T01, l1, 'z');

% Calculating the Transformation for the 2nd link
T02 = T01*Ry(theta2 + theta3)*Tx(a);
result.T2 = T02;

K2 = k_cylinder(E, G, d, T02, a, 'x');

% Calculating the Transformation for the 3rd link
T03 = T01*Ry(theta2)*Tz(c);
result.T3 = T03;

K3 = k_cylinder(E, G, d, T03, c, 'z');

% Calculating the Transformation for the 4th link
T04 = T01*Tz(b);
result.T4 = T04;

K4 = k_cylinder(E, G, d, T04, b, 'z');

% spring is link 5, 6
% calculating link length
ls1 = norm(T02(1:3,4) - T04(1:3,4));
ls2 = norm(T03(1:3,4) - T04(1:3,4));

K5 = k_cylinder(E, G, d, eye(3, 3), ls1, 's');
K6 = k_cylinder(E, G, d, eye(3, 3), ls2, 'z');

% Calculating the Transformation for the 7th link
T07 = T01*Tz(l4);
result.T7 = T07;

K7 = k_cylinder(E, G, d, T07, l4, 'z');

% Calculating the Transformation for the 8th link
T08 = T01*Tz(l4)*Ry(theta2)*Tz(l2);
result.T8 = T08;

K8 = k_cylinder(E, G, d, T08, l2, 'z');

% Calculating the Transformation for the 9th link
T09 = T01*Ry(theta2)*Tz(l2);
result.T9 = T09;

K9 = k_cylinder(E, G, d, T09, l2, 'z');

% Calculating the Transformation for the 10th link
T010 = T09*Ry(-theta2)*Tz(b);
result.T10 = T010;

K10 = k_cylinder(E, G, d, T010, b, 'z');

% Calculating the Transformation for the 11th link
T011 = T09*Ry(-theta2)*Tz(l4);
result.T11 = T011;

K11 = k_cylinder(E, G, d, T011, l4, 'z');


% Calculating the Transformation for the 13th link
T013 = T09*Ry(theta3)*Tx(a);
result.T13 = T013;

K13 = k_cylinder(E, G, d, T013, a, 'x');

% spring is link 12
% calculating link length
ls3 = norm(T010(1:3,4) - T013(1:3,4));
K12 = k_cylinder(E, G, d, eye(3, 3), ls3, 's');

% Calculating the Transformation for the 14th link
T014 = T09*Ry(theta3)*Tx(l3);
result.T14 = T014;

K14 = k_cylinder(E, G, d, T014, l3, 'x');

idx = 1;
shift = 12;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K1 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K2 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K3 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K4 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K5 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K6 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K7 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K8 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K9 ;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K10;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K11;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K12;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K13;idx = idx + shift;
K_link(idx:idx+shift-1, idx:idx+shift-1) = K14;
end




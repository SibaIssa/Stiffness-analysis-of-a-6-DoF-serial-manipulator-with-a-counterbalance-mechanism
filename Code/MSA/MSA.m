% Start
warning('off')
close all
clear
clc
% -------------------------------------------------------------------------

% const
w_e = [100, 100, 100, 0, 0, 0];

l1 = 1; l2 = 1; l3 = 1; l4 = 0.5; 
a = 0.25; b = 0.25; c = 0.5;

m1 = 50; m2 = 50; m3 = 50; ma = 10;
lc2 = l2/3 ; lc3 = l3/3; lca = a;

Kth1 = 1000000; % first actuated joint
Kth2 = 1000000; % second actuated joint
Kth3 = 1000000; % third actuated joint

l_r = eye(6,6);
l_p = l_r(5,:);
l_r(5,:) = [];
l_e = l_p;

% -------------------------------------------------------------------------

% A
A = zeros(91, 168);

A(1:5, 1:6) = l_r;

A(6:10, 19:24) = l_r;
A(6:10, 55:60) = -l_r;

A(11:15, 79:84) = l_r;
A(11:15, 85:90) = -l_r;

A(16:20, 91:96) = l_r;
A(16:20, 127:132) = -l_r;

A(21:25, 31:36) = l_r;
A(21:25, 67:72) = -l_r;

A(26:30, 121:126) = l_r;
A(26:30, 133:138) = -l_r;

A(31:35, 139:144) = l_r;
A(31:35, 151:156) = -l_r;

A(36:41, 31:36) = eye(6,6);
A(36:41, 97:102) = -eye(6,6);

A(42:47, 115:120) = eye(6,6);
A(42:47, 133:138) = -eye(6,6);

A(48:53, 151:156) = eye(6,6);
A(48:53, 157:162) = -eye(6,6);

A(54:58, 103:108) = l_r;
A(54:58, 109:114) = -l_r;

A(59:64, 7:12) = eye(6,6);
A(59:64, 37:42) = -eye(6,6);

A(65:70, 13:18) = eye(6,6);
A(65:70, 37:42) = -eye(6,6);

A(71:75, 25:30) = l_r;
A(71:75, 37:42) = -l_r;

A(76:80, 61:66) = l_r;
A(76:80, 73:78) = -l_r;

A(81:85, 43:48) = l_r;
A(81:85, 49:54) = -l_r;

A(86:91, 49:54) = eye(6,6);
A(86:91, 73:78) = -eye(6,6);

A_zeros = zeros(size(A));
% --------------------------------



% B
B = zeros(77, 168);

B(1:5, 19:24) = l_r;
B(1:5, 55:60) = l_r;

B(6, 19:24) = l_p;

B(7, 55:60) = l_p;

B(8:12, 79:84) = l_r;
B(8:12, 85:90) = l_r;

B(13, 79:84) = l_p;
B(14, 85:90) = l_p;

B(15:19, 91:96) = l_r;
B(15:19, 127:132) = l_r;

B(20, 91:96) = l_p;

B(21, 127:132) = l_p;

B(22:26, 31:36) = l_r;
B(22:26, 67:72) = l_r;
B(22:26, 97:102) = l_r;

B(27, 31:36) = l_p;
B(27, 97:102) = l_p;

B(28, 67:72) = l_p;

B(29:33, 115:120) = l_r;
B(29:33, 121:126) = l_r;
B(29:33, 133:138) = l_r;

B(34, 115:120) = l_p;
B(34, 133:138) = l_p;

B(35, 121:126) = l_p;

B(36:40, 139:144) = l_r;
B(36:40, 151:156) = l_r;
B(36:40, 157:162) = l_r;

B(41, 151:156) = l_p;
B(41, 157:162) = l_p;

B(42, 139:144) = l_p;

B(43:47, 103:108) = l_r;
B(43:47, 109:114) = l_r;
B(43:47, 145:150) = l_r;

B(48, 109:114) = l_p;

B(49:53, 7:12) = l_r;
B(49:53, 13:18) = l_r;
B(49:53, 25:30) = l_r;
B(49:53, 37:42) = l_r;

B(54:59, 25:30) = eye(6, 6);
B(54:59, 37:42) = eye(6, 6);

B(60:64, 43:48) = l_r;
B(60:64, 49:54) = l_r;

B(65, 49:54) = l_p;

B(66:70, 61:66) = l_r;
B(66:70, 73:78) = l_r;

B(71, 61:66) = l_p;

B(72:76, 43:48) = l_r;
B(72:76, 49:54) = l_r;
B(72:76, 61:66) = l_r;
B(72:76, 73:78) = l_r;

B(77, 43:48) = l_p;
B(77, 73:78) = l_p;


B_zeros = zeros(size(B));
% --------------------------------

% C
C = zeros(4, 168);

C(1, 1:6) = -l_e;

C(2, 103:108) = l_e;

C(3, 25:30) = l_e;

C(4, 103:108) = l_e;
C(4, 145:150) = l_e;
% --------------------------------

% D
D = zeros(4, 168);

D(1, 1:6) = Kth1*l_e;

D(2, 103:108) = -Kth3*l_e;
D(2, 145:150) = Kth3*l_e;

D(3, 25:30) = -Kth2*l_e;
D(3, 37:42) = Kth2*l_e;
% --------------------------------

% E
E = zeros(6, 168);
E(:, 163:168) = eye(6, 6);
% --------------------------------

% F
F = zeros(6, 168);
% --------------------------------

% right_side
RS = [zeros(1,340), w_e]';
% ---------------------------------

count = 1;
number_of_iteration = 10;
delta_t = zeros(1, number_of_iteration^3);
pos_x   = zeros(1, number_of_iteration^3);
pos_y   = zeros(1, number_of_iteration^3);
pos_z   = zeros(1, number_of_iteration^3);
% Starting Grid search
for theta1 = linspace(-pi/2, pi/2     , number_of_iteration) % -90 -> +90
    for theta2 = linspace(pi/12, 7*pi/12, number_of_iteration) % 15 -> 75
        for theta3 = linspace(-pi/12, pi/12, number_of_iteration) % -15 -> +15
            % Inssert actuated joint angles in Theta
            
            % Calculate position via fast_DKM
            [pos_x(count), pos_y(count), pos_z(count)] = manipulator_FDKM(theta1, theta2, theta3);

            [K_link, ~] = manipulator_K_links(theta1, theta2, theta3);
            I_links = eye(size(K_link));

            Agg = [-I_links, K_link ;
                   A_zeros , A      ;
                   B       , B_zeros;
                   C       , D      ;
                   E       , F     ];
   
            delta = Agg\RS;
            
            delta_t(count) = norm(delta(330:336));
            
            if(mod(((count*100)/number_of_iteration^3), 10) == 0)
                disp("Overall progress : " + (count*100)/number_of_iteration^3);
            end
            count = count + 1;
        end
    end
end

% Statistical Calculation
disp("Maximum Deflection = " + max(delta_t));
disp("Minimum Deflection = " + min(delta_t));


scatter3(pos_x, pos_y, pos_z, 50, delta_t)
cb = colorbar;                                     % create and label the colorbar
cb.Label.String = 'Deflection [m]';
xlabel('x')
ylabel('y')
zlabel('z')

manipulator_DKM(theta1, theta2, theta3, 1);
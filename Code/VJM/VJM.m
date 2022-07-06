
% Start
warning('off')
close all
clear
clc
% -------------------------------------------------------------------------

% const
F = [100, 100, 100, 0, 0, 0]';

E = 70 *10e9;  % Young's modulus
G = 25.5*10e9; % Shear modulus
d = 10*10e-3;  % Diameter

g = 9.8;

l1 = 1; l2 = 1; l3 = 1; l4 = 0.5;

Kth1 = 1000000; % first actuated joint
Kth2 = 1000000; % second actuated joint
Kth3 = 1000000; % third actuated joint

N_6_6  = zeros(6,6);
N_23_3 = zeros(23,3);
N_3_3  = zeros(3,3);

N_23_1 = zeros(23,1);
N_1_1  = zeros(1,1);

theta = zeros(1,23); % Initialize all thetas with zero

%constructing K_theta
K11 = Kth1;
K22 = k_cylinder(E, G, d, l1, 'z');
K33 = Kth2; % (Kth2 * ((Ks1 * Ks2)/(Ks1 + Ks2)))/(Kth2 + ((Ks1 * Ks2)/(Ks1 + Ks2)));
K44 = k_cylinder(E, G, d, l2, 'z');
K55 = Kth3; % (Kth3 * Ks3)/(Kth3 + Ks3);
K66 = k_cylinder(E, G, d, l3, 'x');

Ktheta = zeros(21, 21);

Ktheta(1, 1)         = K11;
Ktheta(2:7, 2:7)     = K22;

Ktheta(8, 8)         = K33;
Ktheta(9:14, 9:14)   = K44;

Ktheta(15, 15)       = K55;
Ktheta(16:21, 16:21) = K66; 
% -------------------------------------------------------------------------

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
            q  = [theta1, theta2, theta3];
            theta(1)  = theta1;
            theta(8)  = theta2;
            theta(16) = theta3;
            
            % Calculate position via fast_DKM
            [pos_x(count), pos_y(count), pos_z(count)] = manipulator_FDKM(theta1, theta2, theta3);
            
            % Jacobians Virtual thetas 
            J_theta = Jacobian(theta);
            System_matrix = [N_6_6     , J_theta; 
                             J_theta'  , -Ktheta];
             
            inv_system_matrix = inv(System_matrix);

            % Extracting Kc
            Kc = inv_system_matrix(1:6,1:6);
          
            delta= Kc\F;
            delta_t(count) = norm(delta(1:3));
            
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
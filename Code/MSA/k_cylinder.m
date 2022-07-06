function K = k_cylinder(E, G, d, R, L, flag)

    S = pi*d^2/4;
    Iy = pi*d^4/64;
    Iz = pi*d^4/64;
    J = Iy + Iz;
    
    K = zeros(12, 12);
    
    K11 = [-E*S/L ,        0,               0,          0,          0,          0;
              0,      -12*E*Iz/L^3,         0,          0,          0,      6*E*Iy/L^2;
              0,          0,           -12*E*Iy/L^3,    0,    -6*E*Iy/L^2,      0;
              0,          0,               0,        G*J/L,         0,          0;
              0,          0,           6*E*Iy/L^2,      0,       4*E*Iy/L,      0;
              0,       -6*E*Iy/L^2,        0,           0,          0,        4*E*Iz/L];

    
    
    K12 = [E*S/L ,        0,               0,          0,          0,          0;
              0,      12*E*Iz/L^3,         0,          0,          0,      6*E*Iy/L^2;
              0,          0,           12*E*Iy/L^3,    0,    -6*E*Iy/L^2,      0;
              0,          0,               0,        G*J/L,        0,          0;
              0,          0,           -6*E*Iy/L^2,    0        4*E*Iy/L,      0;
              0,       6*E*Iy/L^2,         0,          0           0,        4*E*Iz/L];
    
    K21 = K12';
    
    K22 = [E*S/L ,        0,               0,          0,          0,          0;
              0,      12*E*Iz/L^3,         0,          0,          0,      -6*E*Iy/L^2;
              0,          0,           12*E*Iy/L^3,    0,    -6*E*Iy/L^2,      0;
              0,          0,               0,        G*J/L,        0,          0;
              0,          0,           6*E*Iy/L^2,    0        4*E*Iy/L,      0;
              0,      -6*E*Iy/L^2,         0,          0           0,        4*E*Iz/L];
    
    K = [K11, K12;
         K21, K22];
    
    if(flag == 'z')
        R = Ry(-pi/2);
        R = [R(1:3,1:3), zeros(3, 3), zeros(3, 3), zeros(3, 3);
             zeros(3,3),  R(1:3,1:3), zeros(3, 3), zeros(3, 3);
             zeros(3,3), zeros(3, 3),  R(1:3,1:3), zeros(3, 3);
             zeros(3,3), zeros(3, 3), zeros(3, 3),  R(1:3,1:3)];
        K = R * K * R';
    elseif(flag == 's')
        R = Ry(pi/4);
        R = [R(1:3,1:3), zeros(3, 3), zeros(3, 3), zeros(3, 3);
             zeros(3,3),  R(1:3,1:3), zeros(3, 3), zeros(3, 3);
             zeros(3,3), zeros(3, 3),  R(1:3,1:3), zeros(3, 3);
             zeros(3,3), zeros(3, 3), zeros(3, 3),  R(1:3,1:3)];
        K = R * K * R';
    end
    
Q = zeros(12,12);
   
Q(1:3,1:3)     = R(1:3,1:3);
Q(4:6,4:6)     = R(1:3,1:3);
Q(7:9,7:9)     = R(1:3,1:3);
Q(10:12,10:12) = R(1:3,1:3);
    
K = Q*K*Q';
end
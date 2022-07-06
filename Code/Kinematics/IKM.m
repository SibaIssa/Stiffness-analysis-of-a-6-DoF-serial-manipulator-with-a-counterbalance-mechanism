function [res] = IKM(T)
%IDM Summary of this function goes here
%   Detailed explanation goes here

%constants
l1 = 0.05; l2 = 0.05; l3 = 0.1; l4 = 0.1;l5 = 0.01; eps = 10^(-3);
l1 = l1 + l2;
%

%posistion
%retract to wrist center in matlab inv(A) = 1/A
Tw= T / (Tx(l5));
%

%calculate q1 from robot top view.
Xw = Tw(1,4);
Yw = Tw(2,4);
Zw = Tw(3,4);

if(Xw == 0 && Zw == 0)
    disp('Singularity!!');
    res = [NaN, NaN, NaN, NaN, NaN, NaN];
    return;
end

q1(1) = atan2(Yw,  Xw);
q1(2) = atan2(-Yw, -Xw); 

q1(abs(q1) < eps) = 0;
%

% calculate q2
s = Zw - l1;
r = sqrt(Xw^2 + Yw^2);
lrs = sqrt(s^2 + r^2);

if(s == 0 && r == 0)
    disp('Singularity!!');
    res = [NaN, NaN, NaN, NaN, NaN, NaN];
    return;
end

q21 = atan2(-r,  -s);

cosq22 = (l4^2 - lrs^2 - l3^2)/(2*l3*lrs);

if abs(cosq22) > 1
    disp("singularity");
    res = [NaN, NaN, NaN, NaN, NaN, NaN];
    return;
end

q22(1) = atan2(sqrt(1 - cosq22^2), cosq22);
q22(2) = atan2(-sqrt(1 - cosq22^2), cosq22);

q2(1) = q22(1) + q21;
q2(2) = q22(2) + q21;
q2(3) = q22(1) - q21;
q2(4) = q22(2) - q21;

q2(abs(q2) < eps) = 0;

% calculate q3
cosq31 = (lrs^2 - l3^2 - l4^2)/(2*l3*l4);

if abs(cosq31) > 1
    disp("singularity");
    res = [NaN, NaN, NaN, NaN, NaN, NaN];
    return;
end

q31(1) = atan2(sqrt(1 - cosq31^2), cosq31);
q31(2) = atan2(-sqrt(1 - cosq31^2), cosq31);

q3(1) = -pi/2 + q31(1);
q3(2) = -pi/2 + q31(2);

q3(abs(q3) < eps) = 0;

% solution
q(1,:) = [q1(1), q2(1), q3(1)];         
q(2,:) = [q1(1), q2(2), q3(2)];         
q(3,:) = [q1(2), q2(3), q3(1)];
q(4,:) = [q1(2), q2(4), q3(2)];
%end position

%orientation
res = [];
[r, ~] = size(q);
for i = 1:r
    theta1 = q(i,1);
    theta2 = q(i,2);
    theta3 = q(i,3);
    
    T0w = Tz(l1)*Rz(theta1)*Ry(theta2)*Tz(l2)*Ry(theta3)*Tx(l3);
    T456 = T0w\T;
    if (abs(T456(1,1)) == 1)
        theta41 = 0;
        theta51 = 0;
        theta61 = atan2(T456(2,3), T456(3,3));
        Ts = DKM(theta1, theta2, theta3, theta41, theta51, theta61);
        if(norm(T - Ts) <= 1*10^(-5))
            res = [res; 
            theta1, theta2, theta3, theta41, theta51, theta61];
        end
    else
       theta41 = atan2(T456(2,1), -T456(3,1));
       theta61 = atan2(T456(1,2), T456(1,3));
       theta51 = atan2(sqrt(T456(1,3)^2 + T456(1,2)^2),T456(1,1));

       Ts = DKM(theta1, theta2, theta3, theta41, theta51, theta61);
       if(norm(T - Ts) <= 1*10^(-5))
           res = [res; 
           theta1, theta2, theta3, theta41, theta51, theta61];
       end
       
       theta42 = atan2(-T456(2,1), T456(3,1));
       theta62 = atan2(-T456(1,2), -T456(1,3));
       theta52 = atan2(-sqrt(T456(1,3)^2 + T456(1,2)^2),T456(1,1));
       
       Ts = DKM(theta1, theta2, theta3, theta42, theta52, theta62);
       if(norm(T - Ts) <= 1*10^(-5))
           res = [res; 
           theta1, theta2, theta3, theta42, theta52, theta62];
       end
    end
end
%end orientation

end


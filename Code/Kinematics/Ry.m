function res = Ry(theta)
%RZ Summary of this function goes here
%   Detailed explanation goes here
res = [cos(theta) , 0         , sin(theta), 0;
       0          , 1         , 0         , 0;
       -sin(theta), 0         , cos(theta), 0;
       0          , 0         , 0         , 1];
end
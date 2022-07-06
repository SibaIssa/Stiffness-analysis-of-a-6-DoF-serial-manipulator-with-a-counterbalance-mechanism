function Transformation = elastic_FK(passive_deflection)
t = passive_deflection;
% constanst
l1 = 1; l2 = 1; l3 = 1;
% ----------------------------------------------------------------------------

% q1 First passive joint
T01 = Rz(t(1))*Tz(l1);
T_sp1 = Rx(t(2))* Ry(t(3)) * Rz(t(4)) * Tx(t(5)) * Ty(t(6)) * Tz(t(7));

T1_s2 = Ry(t(8));
T_sp2 = Ry(t(9));
T12 = T1_s2*T_sp2*Tz(l2);
T_sp3 = Rx(t(10))* Ry(t(11)) * Rz(t(12)) * Tx(t(13)) * Ty(t(14)) * Tz(t(15));

T2_s4 = Ry(t(16));
T_sp4 = Ry(t(17));
T23 = T2_s4*T_sp4*Tx(l3);
T_sp5 = Rx(t(18))* Ry(t(19)) * Rz(t(20)) * Tx(t(21)) * Ty(t(22)) * Tz(t(23));

T03 = T01* T_sp1*T12*T_sp3*T23*T_sp5;
% ----------------------------------------------------------------------------
Transformation = T03;
end
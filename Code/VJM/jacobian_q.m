function J = jacobian_q(q, passive_deflection)
t = -passive_deflection;
q = -q;
% constanst
l1 = 0.1; l2 = 0.1; l3 = 0.1;
% ----------------------------------------------------------------------------

% q1 First passive joint
T01 = DRz(t(1))*DRz(q(1))*Tz(l1);
T_sp1 = Rx(t(2))* Ry(t(3)) * Rz(t(4)) * Tx(t(5)) * Ty(t(6)) * Tz(t(7));

T1_s2 = Ry(t(8))*Ry(q(2));
T_sp2 = Ry(t(9));
T12 = T1_s2*T_sp2*Tz(l2);
T_sp3 = Rx(t(10))* Ry(t(11)) * Rz(t(12)) * Tx(t(13)) * Ty(t(14)) * Tz(t(15));

T2_s4 = Ry(t(16))*Ry(q(3));
T_sp4 = Ry(t(17));
T23 = T2_s4*T_sp4*Tx(l3);
T_sp5 = Rx(t(18))* Ry(t(19)) * Rz(t(20)) * Tx(t(21)) * Ty(t(22)) * Tz(t(23));

T03 = T01* T_sp1*T12*T_sp3*T23*T_sp5;

J1 = [T03(1,4), T03(2,4), T03(3,4), T03(3,2), T03(1,3), T03(2,1)]';
% ----------------------------------------------------------------------------

% q2 First passive joint
T01 = DRz(t(1))*Rz(q(1))*Tz(l1);
T_sp1 = Rx(t(2))* Ry(t(3)) * Rz(t(4)) * Tx(t(5)) * Ty(t(6)) * Tz(t(7));

T1_s2 = Ry(t(8))*DRy(q(2));
T_sp2 = Ry(t(9));
T12 = T1_s2*T_sp2*Tz(l2);
T_sp3 = Rx(t(10))* Ry(t(11)) * Rz(t(12)) * Tx(t(13)) * Ty(t(14)) * Tz(t(15));

T2_s4 = Ry(t(16))*Ry(q(3));
T_sp4 = Ry(t(17));
T23 = T2_s4*T_sp4*Tx(l3);
T_sp5 = Rx(t(18))* Ry(t(19)) * Rz(t(20)) * Tx(t(21)) * Ty(t(22)) * Tz(t(23));

T03 = T01* T_sp1*T12*T_sp3*T23*T_sp5;

J2 = [T03(1,4), T03(2,4), T03(3,4), T03(3,2), T03(1,3), T03(2,1)]';
% ----------------------------------------------------------------------------

% q3 Third passive joint
T01 = DRz(t(1))*Rz(q(1))*Tz(l1);
T_sp1 = Rx(t(2))* Ry(t(3)) * Rz(t(4)) * Tx(t(5)) * Ty(t(6)) * Tz(t(7));

T1_s2 = Ry(t(8))*Ry(q(2));
T_sp2 = Ry(t(9));
T12 = T1_s2*T_sp2*Tz(l2);
T_sp3 = Rx(t(10))* Ry(t(11)) * Rz(t(12)) * Tx(t(13)) * Ty(t(14)) * Tz(t(15));

T2_s4 = Ry(t(16))*DRy(q(3));
T_sp4 = Ry(t(17));
T23 = T2_s4*T_sp4*Tx(l3);
T_sp5 = Rx(t(18))* Ry(t(19)) * Rz(t(20)) * Tx(t(21)) * Ty(t(22)) * Tz(t(23));

T03 = T01* T_sp1*T12*T_sp3*T23*T_sp5;

J3 = [T03(1,4), T03(2,4), T03(3,4), T03(3,2), T03(1,3), T03(2,1)]';
% ----------------------------------------------------------------------------

J = [J1 J2 J3];


end
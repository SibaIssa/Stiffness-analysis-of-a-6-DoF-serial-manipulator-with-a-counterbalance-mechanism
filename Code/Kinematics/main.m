%generates random values for testing
clc
clear
disp("start");
n = 1000;

fprintf('number of tests %i \n' , n);
m = 0;
nm = 0;
for i = 1 : n
   b1 = [-pi -pi/2 -pi/2 -pi -pi/2 -pi];
   b2 = [ pi  pi/2  pi/4  pi  pi/2  pi];
   test = (b2-b1).*rand(1,6) + b1;
   T = DKM(test(1),test(2),test(3),test(4),test(5),test(6));
   q = IKM(T);
   for j = 1 : size(q,1)
      Ts = DKM(q(j,1),q(j,2),q(j,3),q(j,4),q(j,5),q(j,6));
      if(norm(T - Ts) > 1*10^(-5))
          disp(q(j,:));
          nm = nm + 1;
      else
          m = m + 1;
      end
   end
   
end
disp(['Validation :' num2str(100*m/(m + nm)) '%']);
disp('finish');
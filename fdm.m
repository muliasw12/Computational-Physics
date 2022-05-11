clear 
clc
close all
%Input parameter
k = 81; %heat constants
L =0.83; %length of pipe
N = 1; %number of elements

x_vec = 0:L:N; 
dx = x_vec(2)-x_vec(1);

dt = 0.5*(dx^2)/(2*k); 
t_vec = 0:dt:10;



%Allocate memory of temperature
T_mat = zeros(length(x_vec),length(t_vec));

%Initial conditions for the Temperature of the pipe
T_mat(1,:) = 100; %the left of the pipe is 200 degrees
T_mat(end,:) = 20; %the right of the pipe is 150 degrees

%integrate using euler dan FDM put together
for tdx = 1:length(t_vec)-1
  for idx = 2:length(x_vec)-1
      T_mat(idx,tdx+1) = T_mat(idx,tdx)+k*dt/(dx^2) *(T_mat(idx+1,tdx)-2*T_mat(idx,tdx)+T_mat(idx-1,tdx));
  end
end

plot(x_vec,T_mat)
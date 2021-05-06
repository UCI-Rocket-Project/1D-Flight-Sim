% test simulation against known analytical solution

t = out.tout;
m = out.m.Data;
T = out.T.Data;
T_ave = out.T_ave.Data;
t_burn = out.t_burn.Data;
g = out.g.Data;

%% xdot
figure('DefaultAxesFontSize', 25)
tiledlayout(2,1)

nexttile
plot(t,xdot_a(t,m,T_ave,t_burn,g),'-',t,out.xdot.Data,'--','LineWidth',2)
legend('analytical solution', 'Simulink solution')
% xlabel('t')
ylabel('xdot')
title('velocity')
grid on

nexttile
plot(t,out.xdot.Data - xdot_a(t,m,T_ave,t_burn,g)','r','LineWidth',2)
xlabel('t')
ylabel('Simulink - analytical')
title('velocity error')
grid on

xdot_ave_error_abs = mean(abs(out.xdot.Data - xdot_a(t,m,T_ave,t_burn,g)'));

%% x
figure('DefaultAxesFontSize', 25)
tiledlayout(2,1)

nexttile
plot(t,x_a(t,m,T_ave,t_burn,g),'-',t,out.x.Data,'--','LineWidth',2)
legend('analytical solution', 'Simulink solution')
% xlabel('t')
ylabel('x')
title('altitude')
grid on

nexttile
plot(t,out.x.Data - x_a(t,m,T_ave,t_burn,g)','r','LineWidth',2)
xlabel('t')
ylabel('Simulink - analytical')
title('altitude error')
grid on

x_ave_error_abs = mean(abs(out.x.Data - x_a(t,m,T_ave,t_burn,g)'));

%% define analytical solutions
function xdot = xdot_a(t,m,T_ave,t_burn,g)
for i = 1:numel(t)
    if t(i) < t_burn(i)
        xdot(i) = (T_ave(i)/m(i) - g(i))*t(i);
    else
        xdot(i) = T_ave(i)*t_burn(i)/m(i) - g(i)*t(i);
    end
end
end

function x = x_a(t,m,T_ave,t_burn,g)
for i = 1:numel(t)
    if t(i) < t_burn(i)
        x(i) = (1/2)*T_ave(i)*t(i)^2/m(i) - (1/2)*g(i)*t(i)^2;
    else
        x(i) = T_ave(i)*t_burn(i)*t(i)/m(i) - (1/2)*g(i)*t(i)^2 - (1/2)*T_ave(i)*t_burn(i)^2/m(i);
    end
end

end
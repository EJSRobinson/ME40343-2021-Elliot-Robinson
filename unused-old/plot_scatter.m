% subplot(1, 2, 1)
% scatter3(results_theta0 * (180 / pi), results_thetaTw * (180 / pi), results_power)
% xlabel('\theta_{0}')
% ylabel('\theta_{tw}')
% zlabel('Ideal AEP - Real AEP')
% 
% subplot(1, 2, 2)
% scatter3(results_theta0 * (180 / pi), results_thetaTw * (180 / pi), results_power)
% xlabel('\theta_{0}')
% ylabel('\theta_{tw}')
% zlabel('Ideal AEP - Real AEP')

subplot(1, 2, 1)
scatter(results_theta0 * (180 / pi), results_thetaTw * (180 / pi), 30, results_power, 'filled')
c = colorbar;
c.Label.String = 'AEP_{Betz} - AEP';
xlabel('\theta_{0}');
ylabel('\theta_{tw}');
xlim([4 18])
ylim([-5.5 0.5])
caxis([0.0785 * 10^10, 2.5 * 10^10])
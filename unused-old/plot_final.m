subplot(1, 2, 1)
scatter(filtered_theta0, filtered_thetaTw, 30, filtered_power, 'filled')
d = colorbar;
d.Label.String = 'AEP_{Betz} - AEP';
xlabel('\theta_{0}');
ylabel('\theta_{tw}');
xlim([4 18])
ylim([-1.5 0])
caxis([7.846 * 10^8, 8.2 * 10^8])
hold on;

subplot(1,2,2)
filtRes = movmean(results, 75);
plot(theta0_range, filtRes);
xlabel('\theta_{0}')
ylabel('AEP_{Betz} - AEP')
hold on;
[val, ind] = min(filtRes);

rangeSize = size(theta0_range, 2);

hor = zeros(1, rangeSize);

hor = hor + val;

theta0_out = theta0_range(ind)

plot(theta0_range, hor,'--');
plot([theta0_out, theta0_out], [7.844 * 10^8, val],'--')
legend('Result','Minimum Ideal AEP - Real AEP', 'Optimal \theta_{0}')

thetaTw_out = (theta0_out * (-0.0631) + 0.0149)



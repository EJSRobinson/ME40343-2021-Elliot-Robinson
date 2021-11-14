rangeSize = size(results_power, 2);
threshold = 8.5 * 10^8;

filtered_power = [];
filtered_theta0 = [];
filtered_thetaTw = [];

for i = 1:rangeSize
    if results_power(i) < threshold
        filtered_power(end + 1) = results_power(i);
        filtered_theta0(end + 1) = results_theta0(i);
        filtered_thetaTw(end + 1) = results_thetaTw(i);
    end
end

filtered_theta0 = filtered_theta0  * (180 / pi);
filtered_thetaTw = filtered_thetaTw * (180 / pi);

subplot(1, 2, 1)
scatter(results_theta0 * (180 / pi), results_thetaTw * (180 / pi), 30, results_power, 'filled')
c = colorbar;
c.Label.String = 'Ideal AEP - Real AEP';
xlabel('\theta_{0}');
ylabel('\theta_{tw}');
xlim([4 18])
ylim([-5.5 0.5])
caxis([0.0785 * 10^10, 2.5 * 10^10])

subplot(1, 2, 2)
scatter(filtered_theta0, filtered_thetaTw, 30, filtered_power, 'filled')
d = colorbar;
d.Label.String = 'Ideal AEP - Real AEP';
xlabel('\theta_{0}');
ylabel('\theta_{tw}');
xlim([4 18])
ylim([-1.5 0])
caxis([0.0785 * 10^10, 2.5 * 10^10])
hold on;

fit = polyfit(filtered_theta0, filtered_thetaTw, 1)
plot([4, 18], [4, 18] * fit(1) + fit(2))
legend('Data Points', 'Linear Fit')



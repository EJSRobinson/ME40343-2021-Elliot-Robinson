% Calculate power at defined theta_0 range
% theta_tw calculated at every point based on defined linear relation with theta_0

% set chord_grad, range of theta_0 values, linear relation between theta_0 and theta_tw
chord_grad = 0.008;
theta0_range = 12:0.005:14;
relationGrad = -0.0631;
relationIntercept = 0.0149;

% calculate theta_tw
thetaTw_range = (theta0_range * relationGrad) + relationIntercept;

% convert to radians
theta0_range = theta0_range * (pi / 180);
thetaTw_range = thetaTw_range * (pi / 180);

% get range size
rangeSize = size(theta0_range, 2);

% initalise results array
results = zeros(1, rangeSize);

% calculate power at all theta_0 values
for i = 1:rangeSize
    results(i) = calcAnnualPower([theta0_range(i), thetaTw_range(i), chord_grad]);

    %display progress
    disp(string(round(100 * i / rangeSize,1)) + '% complete')
end

% convert to degrees
theta0_range = theta0_range * (180 / pi);
thetaTw_range = thetaTw_range * (180 / pi);

% clean results
results = movmean(results, 25);

% get minimum result and coresponding index
[minResult, ind] = min(results);

% pull theta_0 and theta_tw and at minimum AEPbetz - AEP value
theta0_out = theta0_range(ind);
thetaTw_out = thetaTw_range(ind);

% plot result
plot(theta0_range, results);
xlabel('\theta_{0}')
ylabel('AEP_{Betz} -  AEP')

%display result
disp('Complete: theta0 ->'+string(theta0_out)+', thetaTw: '+string(thetaTw_out));
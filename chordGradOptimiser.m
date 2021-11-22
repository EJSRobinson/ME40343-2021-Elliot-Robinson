% optimiser to find maximum chord_grad based on structural considerations

% import globals
global stress_max_limit;
global deflection_max_limit;
global safety_factor;

% theta_0 and theta_tw inputs
theta_0_init = 13.1250;
theta_tw_init = -0.8133;

% set worst case velocity condition
V0 = 25;

% set range of chord gradients
chord_grad_range = -0.09:0.001:0.06;

% get size of chord length range
rangeSize = size(chord_grad_range , 2);

% initalise deflection and stress lists
deflection_c = zeros(1, rangeSize);
deflection = zeros(1, rangeSize);
stress_max = zeros(1, rangeSize);

% conver to radians
theta_0 = theta_0_init * (pi / 180);
theta_tw = theta_tw_init * (pi / 180);

% calculate deflection and stress at all chord gradients
for i = 1:(rangeSize)
    [deflection(i), stress_max(i)] = WholeRotorBendingStress(theta_0, theta_tw, chord_grad_range(i), V0);
    
    % notify progress
    disp(string(round(100 * i / rangeSize,1)) + '% complete')
end

% plot results
subplot(1, 2, 1)
plot(chord_grad_range, stress_max)
hold on
plot(chord_grad_range, stress_max * safety_factor)
plot(chord_grad_range, zeros(1, rangeSize) + stress_max_limit)
xlabel('Y')
ylabel('Stress (Pa)')

subplot(1, 2, 2)
plot(chord_grad_range, deflection)
hold on
plot(chord_grad_range, deflection * safety_factor)
plot(chord_grad_range, zeros(1, rangeSize) + deflection_max_limit)
xlabel('Y')
ylabel('Deflection (m)')
function [deflection_tip, stress_max] = WholeRotorBendingStress(theta_0, theta_tw, chord_grad, V0)
% calculate maximum deflection and stress within blade
% theta_0, inital blade angle relative to geometric plane
% chord_grad, chord gradient
% V0, freestream velocity

% import globals
global y_root;
global y_step;
global y_tip;
global chord_mean;
global err_max_defAngle;
global relaxFact_defAngle;

% initalise y range
y_range = y_root:y_step:y_tip;

% get size of y range
rangeSize = size(y_range, 2);

% initalise theta range and chord range
theta_range = theta_0 + theta_tw * y_range;
chord_range = chord_mean + (y_range - ((R - y_root) / 2)) * chord_grad;

% initalise spanwise stress list
stress = zeros(1, rangeSize);

% initalise normal geometric moment and centrifugal force lists
Mn_g = zeros(1, rangeSize);
force_c = zeros(1, rangeSize);

% initalise normal geometric total moment running total and list
MtotT_g_running = 0;
MtotT_g = zeros(1, rangeSize);

% initalise deflection angle and deflection lists
v_angle = zeros(1, rangeSize);
v = zeros(1, rangeSize);

% loop though all elementrs and calculate moments acting on each elements, fetch centrifugal force at each point
for i = 1:(rangeSize)
    j = rangeSize - i + 1;
    [Mt_r, Mn_r, Mt_g, Mn_g] = SingleElement(y_range(j), y_step, theta_range(j), chord_range(j), V0);
     
    Mn_g(j) =  Mn_g;
    
    MtotT_g_running = MtotT_g_running + Mt_g;
    MtotT_g(j) = MtotT_g_running;
    
    force_c(j) = calcCentrifugalForce(y_range(j), chord_grad);
    
end

err = 1;
% iterate recalulating deflection angle and normal curvatue in the rotor plane each iteration
% loop until error is acceptable
while err > err_max_defAngle
    [v_angle_out, kappa, stress] = calcDefAngle(Mn_g, MtotT_g, theta_range, chord_range, force_c, v_angle * relaxFact_defAngle, y_range);
    err = abs(v_angle_out(rangeSize) - v_angle(rangeSize));
    v_angle = v_angle_out;
end

% calculate deflection across rotor
for i = 1:(rangeSize - 1)
    v(i + 1) = v(i) + (v_angle(i)  * y_step) + ((1 / 6) * kappa(i + 1) + (1 / 3) * kappa(i)) * y_step^2;
end

% get max stress and max deflection
v_tip = v(rangeSize);
stress_max = max(stress);

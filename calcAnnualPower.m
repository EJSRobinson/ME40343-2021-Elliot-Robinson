function [result] = calcAnnualPower(params)
% function to calculate estimated energy produced by design and compare to betz limit
% result is equal to AEP_betz - AEP, a lower number equates to more power

% split input paramaters
theta_0 = params(1);
theta_tw = params(2);
chord_grad = params(3);

%import globals
global v_min;
global v_max;
global v_step;
global k;
global A;
global row;
global discArea;

% define velocity range
velocity_range = v_min:v_step:v_max;

% get size of velocity range
rangeSize = size(velocity_range, 2);

% initalise probabilty function, power results, betz power results, power probability and power probability betz ranges.
freq = zeros(1, rangeSize - 1);
powerRange = zeros(1, rangeSize - 1);
betzRange = zeros(1, rangeSize - 1);
powerProb = zeros(1, rangeSize - 1);
powerProbBetz = zeros(1, rangeSize - 1);

% initalise total annual energy production (AEP) and AEP_betz variables to
AEP = 0;
AEP_betz = 0;

% calculate real and betz energy ratings at all velocities
for i = 1:(rangeSize - 1)

    freq(i) = exp(-((velocity_range(i)/A))^k)-exp(-(velocity_range(i+1)/A)^k);
    
    P_i1 = WholeRotor(theta_0, theta_tw, chord_grad, velocity_range(i));
    
    powerRange(i) = P_i1;
    
    P_i2 = WholeRotor(theta_0, theta_tw, chord_grad, velocity_range(i+1));
    
    powerProb(i) = 0.5 * (P_i1 + P_i2) * freq(i) * 8760;
    
    AEP = AEP + powerProb(i);
    
    P_i1_betz = (16 / 27) * 0.5 * row * velocity_range(i)^3 * discArea;
    
    betzRange(i) = P_i1_betz;
    
    P_i2_betz = (16 / 27) * 0.5 * row * velocity_range(i + 1)^3 * discArea;
    
    powerPropBetz(i) = 0.5 * (P_i1_betz + P_i2_betz) * freq(i) * 8760;
    
    AEP_betz = AEP_betz + powerPropBetz(i);
    
end

% return result
result = AEP_betz - AEP;

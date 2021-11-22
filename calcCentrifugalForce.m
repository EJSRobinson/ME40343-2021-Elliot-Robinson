function [F_c] = calcCentrifugalForce(y, chord_grad)
% function to calcualte centrifugal force at any point down rotor blade
% y input defined point down rotor length to calculate force at

% import globals
global omega;
global row_rotor;
global y_tip;
global y_step;
global chord_mean;
global y_root;

% initalise total force variable
F_c = 0;

% defined radial distance range
y_range = y:y_step:y_tip;

% calculate chord sizes at all y range
chord_range = chord_mean + (y_range - ((y_tip - y_root) / 2)) * chord_grad;

% get range size
rangeSize = size(y_range, 2);

% calculate force at all radial distances in y_range and sum
for j = 1:(rangeSize - 1)
    chord_av = 0.5 * (chord_range(j + 1) + chord_range(j));
    thickness_av = 0.2 * chord_av;
    massDist = chord_av * thickness_av * row_rotor;
    F_c = F_c + y_range(j + 1) * massDist * omega^2 * y_step;
end

function [P, MtotT_r, MtotN_r] = WholeRotor(theta_0, theta_tw, chord_grad, V0)
% calculate total power and bending moments of entire rotor
% theta_0, inital blade angle relative to geometric plane
% chord_grad, chord gradient
% V0, freestream velocity
global y_root;
global y_step;
global y_tip;
global chord_mean;
global Nb;
global omega;


% initalise y range
y_range = y_root:y_step:y_tip;

% get range size
rangeSize = size(y_range, 2)

% initalise theta range and chord range
theta_range = theta_0 + theta_tw * y_range;
chord_range = chord_mean + (y_range - (y_tip / 2)) * chord_grad;

% intialise total bending moment variables
MtotT_r = 0;
MtotN_r = 0;

% loop though all elementrs and calculate moments acting on each elements
for i = 1:(rangeSize)
    [Mt_r, Mn_r, Mt_g, Mn_g] = SingleElement(y_range(i), y_step, theta_range(i), chord_range(i), V0);
    MtotT_r = MtotT_r + Mt_r;  
    MtotN_r = MtotN_r + Mn_r;
end

% caluclate power from total tangential moment in rotor plane00
P = MtotT_r * Nb * omega;
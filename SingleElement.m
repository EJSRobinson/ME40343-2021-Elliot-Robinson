function [Mt_r, Mn_r, Mt_g, Mn_g] = SingleElement(y, deltaY, theta, chord, V0)
% calculate moments at given element along rotor blade length
% y, radial distance
% deltaY, distance step
% theta, angle of blade relative to rotor plane
% chord, chord length at this element
% V0, freestream velocity

%import globals
global a_init
global adash_init;
global row;
global err_max;
global omega;
global mu;
global Nb;

% set starting a and adash
a = a_init;
adash = adash_init;

% reynolds number and solidity at this element
Re = (row * V0 * chord) / mu;
sigma = (Nb * chord) / (2 * pi * y);

% loop induction calcs until err is small or count is above 100, i.e. the iteration has not converged
err = 1;
count = 1;
while (err > err_max) && (count < 100)
    [a_out, adash_out, Cn_r, Ct_r, Cn_g, Ct_g] = InducedCalcsSingleIteration(Re, a, adash, y, theta, sigma, V0);
    
    err = abs(a_out - a) + abs(adash_out - adash);
    a = a_out;
    adash = adash_out;
    Vrel = ((V0 * (1 - a))^2 + (omega * y * (1 + adash))^2)^(1/2);
    Re = (row * Vrel * chord) / mu;
    
    count = count + 1;
    
end

% repeat iteration without swirl if prebious iteration did not coverge
if count == 100
    err = 1;
    Re = (row * V0 * chord) / mu;
    a = a_init;
    
    count = 1;
    while (err > err_max) && (count < 100)
        [a_out, Cn_r, Ct_r, Cn_g, Ct_g] = InducedCalcsSingleIterationNoSwirl(Re, a, y, theta, sigma, V0);
        err = abs(a_out - a);
        a = a_out;
        Vrel = ((V0 * (1 - a))^2 + (omega * y)^2)^(1/2);
        Re = (row * Vrel * chord) / mu;
        
        count = count + 1;
    
    end
    
end

% calculate moment based on force coefficents

Mt_r = (0.5 * row * Vrel^2 * chord * Ct_r) * deltaY * y;
Mn_r = (0.5 * row * Vrel^2 * chord * Cn_r) * deltaY * y;

Mt_g = (0.5 * row * Vrel^2 * chord * Ct_g) * deltaY * y;
Mn_g = (0.5 * row * Vrel^2 * chord * Cn_g) * deltaY * y;




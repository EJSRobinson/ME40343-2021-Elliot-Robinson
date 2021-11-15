function [a, Cn_r, Ct_r, Cn_g, Ct_g] = InducedCalcsSingleIterationNoSwirl(Re, a, y, theta, sigma, V0)
% Single air induction calculations iteration with no swirl
% Single air induction calculations iteration
% Re, reynolds number
% a, proportion of velocity absorbed by blade
% y, radial distance
% theta, blade angle relative to rotor plane
% sigma, rotor solidity
% V0, freestream velocity

% import globals
global omega;
global Nb;
global y_tip;
global ac;

% calculate indunction angle
phi = atan(((1-a)*V0)/(omega*y));

% calculate AoA
alpha = phi - theta;

% get lift and drag co efs
[Cl, Cd] = ForceCoefficient(alpha, Re);

% calc tangential and normal force coefficents in rotor and geometric planes
Cn_r = Cl * cos(phi) + Cd * sin(phi);
Ct_r = Cl * sin(phi) - Cd * cos(phi);
Cn_g =  Cl * cos(alpha) + Cd * sin(alpha);
Ct_g =  Cl * sin(alpha) - Cd * cos(alpha);

% calculate f for prandlt's tip loss factor
f = (Nb/2) * (y_tip - y) / (y * sin(phi));

% calculate Prandl't tip loss factor
if phi < pi/2 && phi > 0
    F = (2 / pi) * acos(exp(-f));
else
    F = 1;
end

% calculate new s

% calculate K to be used in calculation of a
K = (4*F*(sin(phi)^2))/(sigma * Cn_r);

% include Gluert factor
if a > ac && phi < pi/2 && phi > 0 
    if K < 0
        K = 0;
    end
    a_out = 0.5 * (2 + K * (1 - 2 * ac) - ((K*(1-2*ac)+2)^2 + 4*(K * ac^2 - 1))^(1/2));
else
    a_out = 1/(((4 * F * sin(phi)^2) / (sigma * Cn_r)) + 1);
end

a = a_out;

end


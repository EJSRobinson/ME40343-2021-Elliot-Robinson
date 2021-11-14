function [v_angle_out, kappa, stress] = calcDefAngle(Mn_g, MtotT_g, theta, chord_range, centrifugalForce, v_angle_in, y_range)
% Single iteration to calculate blade deflection angle based on previous angle and centrifugal force
%
% Mn_g, normal geometric moment list
% MtotT_g, total tangential geometic moment list (bending moment)
% Theta range down blade
% Chord range down blade
% centrifugal force, centrifugal force to be applied to moments
% v_angle, input deflection angle for previous iteration
% y_range, range of radial distances

% import globals
global modulus_elasticity;
global y_step;
global thickness_chord_ratio;

% apply centrifugal force to normal geometric moments and all pointss
Mn_g = Mn_g - centrifugalForce .* sin(v_angle_in) .* y_range;

% get range size
rangeSize = size(Mn_g, 2);

% intalise noraml geometric bending moment, normal and tangential geometric curvature, normal rotor curvature, resulting deflection angle and stress, ranges
MtotN_g = zeros(1, rangeSize);
kappaN_g = zeros(1, rangeSize);
kappaT_g = zeros(1, rangeSize);
kappa = zeros(1, rangeSize);
v_angle_out = zeros(1, rangeSize);
stress = zeros(1, rangeSize);

% calculate normal geometric bending moment at all points down blade
for i = 1:rangeSize
    j = rangeSize - i + 1;
    MtotN_g(j) = sum(Mn_g(j:rangeSize));
end

% calculate init conditions
In = (chord_range(1) * (thickness_chord_ratio * chord_range(1))^3) / 12;    % normal second moment of area
It = (chord_range(1)^3 * (thickness_chord_ratio * chord_range(1))) / 12;    % tangential second moment of area
kappaN_g(1) = MtotN_g(1) / (modulus_elasticity * In);
kappaT_g(1) = MtotT_g(1) / (modulus_elasticity * It);
kappa(1) = kappaN_g(1) * cos(theta(1)) - kappaT_g(1) * sin(theta(1));
stress(1) = MtotN_g(1) * (0.5 * thickness_chord_ratio * chord_range(1)) / I1;

% calculate stress, curvatures and new deflection angle
for i = 1:(rangeSize - 1)
    
    In = (chord_range(i + 1) * (thickness_chord_ratio * chord_range(i + 1))^3) / 12;
    It = (chord_range(i + 1)^3 * (thickness_chord_ratio * chord_range(i + 1))) / 12;
    
    stress(i + 1) = MtotN_g(i + 1) * (0.5 * thickness_chord_ratio * chord_range(i + 1)) / I1;
    
    kappaN_g(i + 1) = MtotN_g(i + 1) / (modulus_elasticity * I1);
    kappaT_g(i + 1) = MtotT_g(i + 1) / (modulus_elasticity * I2);
    kappa(i + 1) = kappaN_g(i + 1) * cos(theta(i + 1)) - kappaT_g(i + 1) * sin(theta(i + 1));
    
    v_angle_out(i + 1) = v_angle_out(i) + 0.5 * (kappa(i) + kappa(i + 1)) * y_step;
    
end



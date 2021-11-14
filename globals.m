%Rotor Properties
global y_tip
global Nb;
global y_root;
global chord_mean;
global omega;
global v_min;
global v_max;
global row_rotor;
global bladeLength;
global modulus_elasticity;
global discArea;
global thickness_chord_ratio;
y_tip = 20;
Nb = 3;
y_root = 1;
chord_mean = 1;
omega = (30 / 60) * 2 * pi;
v_min = 5;
v_max = 25;
row_rotor = 2000;
bladeLength = R - y_root;
modulus_elasticity = 40 * 10^9;
discArea = pi * bladeLength^2;
thickness_chord_ratio = 0.2;

%constrains
global Fy_max;
global stress_max_limit;
global deflection_max_limit;
global safety_factor;
Fy_max = 70000;
stress_max_limit = 2875 * 10^6;
deflection_max_limit = 3;
safety_factor = 1.5;

%Air Properties
global row;
global mu;
row = 1.225;
mu = 18.03 * 10^(-6);

%Mathematical Settings
global v_step;
global y_step;
global adash_init;
global a_init;
global relaxFact;
global err_max;
global err_max_defAngle;
global relaxFact_defAngle;
y_step = 0.5; %m
v_step = 0.5; %m/s
a_init = 0;
adash_init = 0;
relaxFact = 0.1;
err_max = 0.00001;
err_max_defAngle = 0.18 * pi / 180;
relaxFact_defAngle = 1 / 50000;


%Misc Constants
global k;
global A;
global g;
global ac;
k = 1.8;
A = 7;
g = 9.81;
ac = 0.2;




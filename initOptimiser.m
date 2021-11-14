% first optimiser, based on inital guesses
% used to find accurate estimates of theta_0 and theta_tw

% Set lower bounds, upper bounds and inital guesses
% theta_0 and theta_tw set in degrees
LBs = [6, -5 , 0];
guess = [13.3304, -0.82676, 0.008];
UBs = [16, -0.02, 0.008];

% convert all to radians
LBs(1) = LBs(1) * (pi / 180);
LBs(2) = LBs(2) * (pi / 180);
UBs(1) = UBs(1) * (pi / 180);
UBs(2) = UBs(2) * (pi / 180);
guess(1) = guess(1) * (pi / 180);
guess(2) = guess(2) * (pi / 180);


% set fminsearchbnd options
opts = optimset('fminsearch');
opts.Display = 'iter'; %What to display in command window
opts.TolX = 0.001; %Tolerance on the variation in the parameters
opts.TolFun = 0.001; %Tolerance on the error
opts.MaxFunEvals = 50; %Max number of iterations
opts.FunValCheck = 'off';

% run optimisation
finals = fminsearchbnd(@calcAnnualPower, guess, LBs, UBs, opts);

% convert results to degrees
finals(1) = finals(1) * (180 / pi);
finals(2) = finals(2) * (180 / pi);

% display outcome
disp('Complete: Theta0 ->'+string(finals(1))+', ThetaTw ->'+string(finals(2)))


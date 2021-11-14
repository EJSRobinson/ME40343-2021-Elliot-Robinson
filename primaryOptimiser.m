% primary optimiser to run optimsation at range of theta_0 and theta_tw guesses

% set lower and upper bounds, theta_0 and theta_tw in degrees
LBs = [6, -5 , 0.005];
UBs = [16, -0.02, 0.008];

% conver to radians
LBs(1) = LBs(1) * (pi / 180);
LBs(2) = LBs(2) * (pi / 180);
UBs(1) = UBs(1) * (pi / 180);
UBs(2) = UBs(2) * (pi / 180);

% guess lists for theta_0 and theta_tw in degrees
guesses_theta0 = [6, 8, 10, 12, 14, 16] * (pi / 180);
guesses_thetaTw = [-5, -4, -3, -2, -1, 0] * (pi / 180);
chord_grad = 0.008;

% get rangeSizes of theta_0 and theta_tw guesses
rangeSizei = size(guesses_theta0, 2);
rangeSizej = size(guesses_thetaTw, 2);

% initalise results arrays
results_power = [];
results_theta0 = [];
results_thetaTw = [];
results_chordGrad = [];

% set fminsearchbnd properties
opts = optimset('fminsearch');
opts.Display = 'iter'; %What to display in command window
opts.TolX = 0.001; %Tolerance on the variation in the parameters
opts.TolFun = 0.001; %Tolerance on the error
opts.MaxFunEvals = 50; %Max number of iterations
opts.FunValCheck = 'off';

% run optimisation at all guess combinations and store results
for i = 1:rangeSizei
    for j = 1:rangeSizej
        disp('Guess' + string(6*(i-1) + j) + '/' + string(rangeSizei * rangeSizej));
        guess = [guesses_theta0(i), guesses_thetaTw(j), chord_grad]
        finals = fminsearchbnd(@calcAnnualPower, guess, LBs, UBs, opts);
        results_power(end + 1) = calcAnnualPower(finals);
        results_theta0(end + 1) = finals(1);
        results_thetaTw(end + 1) = finals(2);
        results_chordGrad(end + 1) = finals(3);
    end
end

% notify of completion
disp('Complete')


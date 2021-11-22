# ME40343-2021-Elliot-Robinson

University of Bath 2021 - ME40343 - Advanced Helicopter Dynamics Coursework - Wind Turbine Blade Design - MATLAB

Elliot Robinson,
CN: 12858

## Scope of Code Analysis

- Base BEMT Analysis based on BET and ADT, derived from helicopter blade analysis
- Effect of swirl
- Prandtl correction factor
- Glauert correction factor
- Stress within blade
- Deflection of blade
- Effect centrifugal force has on blade

## Use of Globals

Globals are used throughout the code base. Most function use the same base properties, i.e. fixed geometry, air properties and mathematical settings. As such, passing all these through the layers of function as 'variables' is messy and not clear as these values do not truly vary. As such, to mitigate this, all fixed properties are defined in globals.m. Use globals.m to edit base properties of the system.

**Ensure:**

- **globals.m is run before any optimisation work**
- **globals.m is run after any changes to global.m have been made**

Using globals in this manner has also be done to allow the user to easily change properties in a single location, without having to go through and change the definition of a property in many different files. This allows for rapid comparison of different run states, especially useful when finding optimal relaxation factors, distance steps and time steps.

## Instructions for use

1. Check globals.m and ensure properties are defined as required
2. Run globals.m to set properties
3. Run initOptimiser.m with sensible inital guesses to get inital optimal values for theta0, thetaTw and Cgrad
4. Run chordGradOptimiser.m with previously found theta0 and thetaTw values. This will perform stress and defelection analysis to allow the maximum (optimal) Cgrad to be found
5. Run primaryOptimiser.m with previously found optimal Cgrad. Ensure guesses for theta0 and thetaTw span a wide search range. The optimiser will perform a wide search in the AEPbetz - AEP plane. If successful, optimised values for theta0 and thetaTw should all finalise within the same valley in the AEPbetz - AEP surface. This allows for a linear relation between theta0 and thetaTw to be determined.
6. Run finalOptimiser.m using previously calculated optimal Cgrad and theta0/thetaTw linear relationship. This will run through all theta0 allowing for an optimum theta0 to be found. Use the calculated linear relationship to find thetaTw.
7. (Optional) Re-run chordGradOptimiser.m with optimised theta0 and thetaTw values to ensure previously found optimal Cgrad does not violate deflection limit.
8. (Optional) Re-run initOptimiser.m with now optimal values. This will perform final value trimming.

## High-Accuracy vs High-Speed

From experimentation, values for the velocity and distance steps were found to give high-accuracy results and for the code to run quickly. The below values are guidelines and therefore can be adjusted in globals.m to fit user preference.

- To run Code in high-accuracy mode: deltaV = 0.1, deltaY = 0.25
- To run code in high-speed mode: deltaV = 0.5, deltaY = 0.5

High-accuracy mode should be used for all steps excluding step 5.

## FMINSEARCHBND

FMINSEARCHBND is a 3rd party MATLAB function used to perform multivariate minimisation. This assignment dictated the use of this function. It is used in the following scripts:

- initOptimiser.m
- primaryOptimiser.m

All code relating to FMINSEARCHBND is found within the FMINSEARCHBND folder.

## Unused-old

This folder contains code which is not useful for solving the BEMT optimisation problem. Code in here was either used to plot result for the report based on this study, or for experimentation while the code was being written. As such, it is unlikely any user will find this of interest.

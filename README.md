# ME40343-2021-Elliot-Robinson

University of Bath 2021 - ME40343 - Advanced Helicopter Dynamics Coursework - Wind Turbine Blade Design - MATLAB

Elliot Robinson
CN: 12858

## Scope of Code Analysis

- Base BEMT Analysis based on BET and ADT, derived helicopter blade analysis
- Effect of swirl
- Prandlt correction factor
- Glauert correction factor
- Stress within blade
- Deflection of blade
- Effect centrifugal force has on blade

## Use of Globals

Globals are used throughout the code base. Most function use the same base properties, i.e. fixed geometry, air properties and mathemtical settings. As such, passing all these through the later of function as 'variables' is messy and not clear as these value do not truely vary. As such, to mitigate this, all fixed properties are defined in global.m. Use global.m to edit base properties of the system.

**
Ensure:
-global.m is run before any optimisation work
-global.m is run after any changes to global.m have been made
**

## Unused-old

This folder contains code which is not useful for solving the BEMT optimisation problem. Code in here was either used to plot result for the report based on this study, or for experimentation while the code was being written. As such, it is unlikely any user will find this of interest

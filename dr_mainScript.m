%% This code was developed by Daniel Riofrio.
%% main:

p = dr_particle;
p.x = [1, 2];
p.v = [0, 0];

%%
function_handler = @dr_f3;
N = 500;
max_time = 100;

[P, S, t, best_val, best_particle] = dr_pso(function_handler, ...
                              N, ...
                              max_time);
                          
best_particle,
best_val


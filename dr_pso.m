function [P, S, t, best_val, best_particle] = dr_pso(function_handler, ...
                              N, ...
                              max_time)
   t = 0;
   S = dr_initialize_swarm(N);
   P = S;
   [best_val, g] = dr_evaluate(function_handler, P);
   best_particle = P(g);
   
   for t = 1:max_time
      S = dr_updateSwarm(S, P, g);
      P = dr_updateGlobal(function_handler, S, P);
      [best_val, g] = dr_evaluate(function_handler, P);
      best_particle = P(g);
   end
                          
end

function [S] = dr_initialize_swarm(N)
    S(N,1) = dr_particle;
    a = -10;
    b = 10;
    for i=1:N
        S(i).x = a + (b-a).*rand(2,1);
        S(i).v = [0;0];
    end
end

function [val, best] = dr_evaluate(function_handler, P)
    N = size(P,1);
    eval_array = zeros(N,1);
    for i=1:N
        eval_array(i) = function_handler(P(i).x(1), P(i).x(2));
    end
    [val, best] = min(eval_array);
end

function [S] = dr_updateSwarm(S, P, g)
    % velocity calculation
    alpha_1 = 0.5;
    alpha_2 = 0.5;
    phi_1 = rand();
    phi_2 = rand();
    N = size(S,1);
    pg = P(g);
    for i=1:N
        particle_i = S(i);
        pi = P(i);
        particle_i.v = particle_i.v +...
                       alpha_1*phi_1*(pi.x-particle_i.x)+...
                       alpha_2*phi_2*(pg.x-particle_i.x);
        particle_i.x = particle_i.x + particle_i.v;
        S(i) = particle_i;
    end
end

function [P] = dr_updateGlobal(function_handler, S, P)
    N = size(S, 1);
    for i=1:N
        particle_s_i = S(i);
        particle_p_i = P(i);
        val_s_i = function_handler(particle_s_i.x(1), particle_s_i.x(2));
        val_p_i = function_handler(particle_p_i.x(1), particle_p_i.x(2));
        if(val_s_i <= val_p_i)
            P(i) = particle_s_i;
        end
    end
end
function [nu_min, nu_avg, nu] = hw2_1(N_exp)
% solution for hw2 number 1.

% N_exp = 100000;
% N_exp = 1000;
nu = zeros(N_exp, 3);
for i=1:N_exp
    nu(i, :) = flip_exp()';
end
nu_avg = mean(nu);
nu_min = nu_avg(3);


function nu = flip_exp()
% just make the script as fucntion to use local functions.
% [1000x10]
% 1000 coins to flip/test
% 10: 10 flips result, 0-tail, 1-head
N_coins = 1000;
N_flips = 10;

experiment = rand(N_coins, N_flips)>0.5;

coin_rand = ceil(rand()*1000);
coin_1 = 1;
chosen = [coin_rand; coin_1];
coin_min = find_min(chosen, experiment);
coins = [   coin_1;
            coin_rand;
            coin_min;
            ];

nu = experiment(coins,:)*ones(N_flips,1)/N_flips;

function coinmin = find_min(chosen, experiment)
% find the one with the minimum ?.
% chosen: indices of the chosen coins: 1, and rand.
% chosen: [2x1]
heads = experiment * ones(10,1);
heads(chosen)=10;
[val, coinmin] = min(heads);
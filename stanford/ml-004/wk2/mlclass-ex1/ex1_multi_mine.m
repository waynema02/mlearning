%% Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
price = 0; % You should change this

% find optimal alpha
num_iters = 50;

% using below alphas, 0.03 gives good convergence on 50 iter
% larger alpha will diverge
% smaller alpha will NEVER get to a low-enought J on 50 iter
%n = 21;
%alphas = logspace(-5,5,n);
% With the above scanning, try search with finer granularity
n = 11;
alphas = logspace(-0.01, 0.1, n);
% it turns out they are all pretty good, just go with 0.03

theta = zeros(3, n);
J_l = eye(num_iters, n);

[X, mu, sigma] = featureNormalize(X);
X = [ones(m, 1) X];

for i = 1:n
    [theta(:,i), J_l(:,i)] = gradientDescentMulti(X, y, theta(:,i), alphas(i), num_iters);
end

for i = 1:n
    figure(i);
    plot(J_l(:,i));
end

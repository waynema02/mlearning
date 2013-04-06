function [ xdata, ydata, target ] = PLA_setup( N, is_plot )
%set up for PLA linear regression classification
% demo for PLA: Perceptron Learning Algorithm
%Generate random target function: mapping X->{-1,1}, using linear boundary
%Generate N random data points: 2-dimensional data points x
%Generate N correct answer: y


% generate random target function

% generate desicion boundary
points_x = (rand(2,1)-0.5)*2;
points_y = (rand(2,1)-0.5)*2;
w = inv([ones(2,1),points_x])*points_y;
target = [-w;1];
disp('Target for y = x*target ');
disp(target');

% generate random data points
xdata = [ones(N,1), (rand(N,2)-0.5)*2];
ydata = target_func(xdata, target);

% Visualize the result by plotting decision boundary and data points.
if (is_plot==1)
    % plot the decision boundary
    xx = linspace(-1,1,101);
    yy = [ones(1,length(xx));xx]'*w;
    figure(1)
    hold on
    ep = 0.1;
    axis = [-1-ep, 1+ep, -1-ep, 1+ep];
    plot(xx,yy);
    title('Target Decision Boundary')
    plot(points_x,points_y,'co');

    good = ydata==1;
    bad = ydata==-1;
    ind_good = find(good);
    ind_bad = find(bad);
    plot(xdata(ind_good,2), xdata(ind_good,3), 'r^');
    plot(xdata(ind_bad, 2), xdata(ind_bad, 3), 'kx');
    hold off
end


end

function y=target_func(x, target)
% This is the target function.
% It is a linear function to x, using weight from target vector.

%     [feature, sample] = size(x)
%     XX = [ones(sample,1),x']
    yy = x*target;
    y = (yy>=0)*2-1;
end


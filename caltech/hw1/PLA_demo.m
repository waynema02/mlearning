% demo for PLA: perceptron learning algorithm

% generate random target function

% generate desicion boundary w
x = (rand(2,1)-0.5)*2;
y = (rand(2,1)-0.5)*2;
w = inv([ones(2,1),x])*y;
target = [-w;1];
disp('Target');
disp(target');

% plot the x/y
xx = linspace(-1,1,101);
yy = [ones(1,length(xx));xx]'*w;
figure()
plot(xx,yy)
hold on
title('Target Decision Boundary')
plot(x,y,'ro')


% PLA
N=10;

% generate random data points
xdata = [ones(1,N); (rand(2,N)-0.5)*2];
ydata = target_func(xdata, target);
good = ydata==1;
bad = ydata==-1;
ind_good = find(good);
ind_bad = find(bad);
plot(xdata(2,ind_good), xdata(3,ind_good), 'r^');
plot(xdata(2, ind_bad), xdata(3, ind_bad), 'kx');


w_init = [0;0;0];
y_test = hypothesis(xdata, w_init);
mask = y_test ~= ydata;

ind = find(mask, 1);
w = w_init;
i=1;
while ind;
    input(' ');
    a=sprintf('Iteraion %d', i);
    i = i+1;
    disp(a);
    w = w + ydata(ind)*xdata(:,ind);
    disp(w');
    % plot new line based on w
    xp1 = linspace(-1,1,101);
    xp2 = -(1/w(3))*[ones(1,101);xp1]'*w(1:2);
    plot(xp1, xp2, 'y');
    
    y_test = hypothesis(xdata, w);
    mask = y_test ~= ydata;
    ind = find(mask, 1);
end

    % plot new line based on w
    xp1 = linspace(-1,1,101);
    xp2 = -(1/w(3))*[ones(1,101);xp1]'*w(1:2);
    plot(xp1, xp2, 'cs');

    
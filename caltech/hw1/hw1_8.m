% Find the probability for f ~= g

% generate random target function

iter=1000
loop_P=zeros(1,iter);
for j=1:iter
    
% generate desicion boundary w
x = (rand(2,1)-0.5)*2;
y = (rand(2,1)-0.5)*2;
w = inv([ones(2,1),x])*y;
target = [-w;1];
disp('Target');
disp(target');

% Number of sampling
N=100;

% generate random data points
xdata = [ones(1,N); (rand(2,N)-0.5)*2];
ydata = target_func(xdata, target);
good = ydata==1;
bad = ydata==-1;
ind_good = find(good);
ind_bad = find(bad);

% PLA
w_init = [0;0;0];
w = w_init;
y_test = hypothesis(xdata, w);
mask = y_test ~= ydata;
ind = find(mask, 1);

i=0;
while ind;
    w = w + ydata(ind)*xdata(:,ind);
    i = i+1;
    
    y_test = hypothesis(xdata, w);
    mask = y_test ~= ydata;
    ind = find(mask, 1);
end

% find difference between target and hypothesis
NN = 2000;
xtest = [ones(1,NN); (rand(2,NN)-0.5)*2];
ytest = target_func(xtest, target);
yhypo = hypothesis(xtest, w);
% plot for visual
% plot(xtest(2,find(ytest==1)), xtest(3,find(ytest==1)), 'b*', xtest(2, find(ytest==-1)), xtest(3, find(ytest==-1)), 'b^');
% hold on;
% plot(xtest(2,find(yhypo==1)), xtest(3,find(yhypo==1)), 'r*', xtest(2, find(yhypo==-1)), xtest(3, find(yhypo==-1)), 'r^');
%     xp1 = linspace(-1,1,101);
%     xp2 = -(1/w(3))*[ones(1,101);xp1]'*w(1:2);
%     xtarg = -(1/target(3))*[ones(1,101);xp1]'*target(1:2);
%     plot(xp1, xp2, 'c-s', xp1, xtarg, 'g-d');

diff = ytest ~= yhypo;
Pdiff = sum(diff)/NN;
disp(sprintf('Probability is %f', Pdiff));

loop_P(j)=Pdiff;
end
length(loop_P)
avg = mean(loop_P);
disp(sprintf('avg Probability is %f', avg));
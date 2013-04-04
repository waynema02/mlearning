function y = hypothesis( x, w )
%Hypothesis function
%   Detailed explanation goes here
%     [feature, sample] = size(x)
%     xx = [ones(1,sample);x]
    yy = x'*w;
    y = (yy>=0)*2-1;
end


function y=target_func(x, target)
%     [feature, sample] = size(x)
%     XX = [ones(sample,1),x']
    yy = x'*target;
    y = (yy>=0)*2-1;
end


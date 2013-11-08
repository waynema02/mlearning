function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

i = 1;
j = 1;
err = 1000000000000;
indexi = i;
indexj = j;

%C_l = [.001, .01, .1, 10],
%sigma_l = [.003, .03, .3, 30],

C_l = [.01, 10],
sigma_l = [.03, 30],

for i = 1:length(C_l),
	for j = 1:length(sigma_l),
		C = C_l(i),
		sigma = sigma_l(j),
		model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
		predictions = svmPredict(model, Xval);
		error_l(i,j) = mean(double(predictions ~= yval))
		if error_l(i,j) < err,
			err = error_l(i,j);
			indexi = i;
			indexj = j;
		end
		j++
	end
	i++;
end

error_l,

C = C_l(indexi),
sigma = sigma_l(indexj),





% =========================================================================

end

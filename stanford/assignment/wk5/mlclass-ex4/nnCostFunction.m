function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

a1 = X';

z2 = Theta1 * [ones(1, size(a1, 2)); a1];
a2 = sigmoid(z2);

z3 = Theta2 * [ones(1, size(a2, 2)); a2];
a3 = sigmoid(z3);

H = a3;

% map the result vector to label matrix: 5 -> [0,0,0,0,1,0,0,0,0,0]';
% each column is a vector of the label result, the none-zero index indicates the class.
Y = zeros(num_labels, m);
for i = 1:m;
    Y(y(i), i) = 1;
end

% NON-vectorized version
%J = 0;
%for i = 1:m;
    %for j = 1:num_labels
        %J = J - 1/m*(Y(j,i)*log(H(j,i)) + (1-Y(j,i))*log(1-H(j,i)));
    %end
%end

% vectorize for sample number, not for the num_labels.
%J = 0;
%for j = 1:num_labels
    %temp = - 1/m*(Y(j,:)*log(H(j,:)') + (1-Y(j,:))*log(1-H(j,:)'));
    %J = J + temp;
%end

% fully vectorize:
% basically, J is the fully-inner-product of matrix H and Y.
J = -1/m*sum(sum(Y.*log(H) + (1-Y).*(log(1-H))));

% regularized cost function
J = J + lambda/2/m*(    sum(sum(Theta1(:,2:end).^2)) + ...
                        sum(sum(Theta2(:,2:end).^2)) ...
                   );

%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
Delta1 = zeros(size(Theta1));
Delta2 = zeros(size(Theta2));
for i = 1:m
    a1 = X(i,:)';

    a1 = [ones(1, size(a1,2)); a1];
    z2 = Theta1 * a1;
    a2 = sigmoid(z2);

    a2 = [ones(1, size(a2,2)); a2];
    z3 = Theta2 * a2;
    a3 = sigmoid(z3);

    h = a3;
    y = Y(:,i);

    delta3 = h - y;

    % This is for debug purpose.
    %size(Theta2)
    %size(delta3)
    %size(z2)

    delta2 = Theta2(:, 2:end)' * delta3 .* sigmoidGradient(z2);
    %delta2 = delta2(2:end);

    Delta2 = Delta2 + delta3 * a2';
    Delta1 = Delta1 + delta2 * a1';
end

Theta1_grad = 1/m*Delta1;
Theta2_grad = 1/m*Delta2;



%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



Theta1_reg = [zeros(size(Theta1,1), 1) Theta1(:, 2:end)];
Theta2_reg = [zeros(size(Theta2,1), 1) Theta2(:, 2:end)];

Theta1_grad = Theta1_grad + lambda/m*Theta1_reg;
Theta2_grad = Theta2_grad + lambda/m*Theta2_reg;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end

% Define the number of nodes
numNodes = 6;

% Create a homogeneous transition probability matrix with 1/6
P = ones(numNodes, numNodes) / numNodes;

% Plot the Markov chain graph
graphObj = digraph(P);
plot(graphObj, 'EdgeLabel', graphObj.Edges.Weight);
title('Homogeneous and Regular Markov Chain');


% Number of states
n = size(P, 1);

% Initialize MFPT matrix
MFPT = zeros(n);

% Identity matrix
I = eye(n);

% Loop through each target state j
for j = 1:n
    % Create P_j, the transition matrix with state j absorbing
    P_j = P;
    P_j(j, :) = 0;
    P_j(j, j) = 1;
    disp(P_j)
    
    % Fundamental matrix: N = inv(I - Q)
    % Exclude the j-th row and column to get Q
    Q = P_j;
    Q(j, :) = [];
    Q(:, j) = [];
    disp(Q)
    % Compute N = (I - Q)^-1
    T = inv(I(1:n-1, 1:n-1) - Q);
    
    % Mean first passage times to state j from all i ≠ j
    t = T * ones(n-1, 1);
    
    % Place into MFPT matrix
    idx = [1:j-1, j+1:n];
    MFPT(idx, j) = t;
end
disp(MFPT)
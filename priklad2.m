% Define the number of nodes
numNodes = 6;

% Create a homogeneous transition probability matrix with 1/6
transitionMatrix = ones(numNodes, numNodes) / numNodes;

% Plot the Markov chain graph
graphObj = digraph(transitionMatrix);
plot(graphObj, 'EdgeLabel', graphObj.Edges.Weight);
title('Homogeneous and Regular Markov Chain');


% Initialize target state
targetState = 3; % Example target state j

% Calculate fundamental matrix
Q = transitionMatrix; 
Q(:,targetState) = 0; % Remove transitions to target state
N = inv(eye(numNodes) - Q); % Fundamental matrix
disp(N)
% Expected steps to reach state j from state i
M = N(:,targetState);
disp('Expected steps to reach state j from state i:');
disp(M)


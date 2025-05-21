clc
clear all
%%

% Define the number of nodes
numNodes = 6;

% Create a homogeneous transition probability matrix with 1/6
% P = ones(numNodes, numNodes) / numNodes;

P = [ 
    1 0 0 0 0 0;
    1 0 0 0 0 0;
    0 0.5 0 0.5 0 0;
    0 0 0.5 0 0.5 0;
    0 0 0 0 0 1;
    0 0 0 0 0 1;
];
absorbing = [1 6]
transient = [2 3 4 5]



%P = [ 
%    0   1     0    0   0    0;
%    1/2 0     1/2  0   0    0;
%    0   0     1    0   0    0; 
%    0   9/10  0    0   0    1/10;
%    0   0     0    0   1    0;
%    2/5 0     0    0   3/5  0;
%];
%absorbing = [3 5]
%transient = [1 2 4 6]



% Plot the Markov chain graph
graphObj = digraph(P);
plot(graphObj, 'EdgeLabel', graphObj.Edges.Weight);
title('Homogeneous Markov Chain with absorbing states.');


%%

% Extract Q matrix (transient-to-transient)
Q = P(transient, transient);
disp("Matice Q:")
disp(Q)


I = eye(size(Q));
T = inv(I - Q);  % Fundamental matrix
size_T = size(T,1);

empty = zeros(size_T + length(absorbing));
row_start = 2; 
col_start = 2; 
empty(row_start:row_start+size(T,1)-1, col_start:col_start+size(T,2)-1) = T;
modified_T = empty;
% Display expected number of times in each transient state before absorption
%disp('Expected number of times in transient state j starting from i:');
disp('Stredni pocet pruchodu stavem j, pokud se vychazi ze stavu i, nez dojde k pohlceni. Matice T:');
disp(T);

t = T * ones(size_T, 1);
% t = modified_T * ones(6, 1);
disp("Doba pobytu v tranzientnich stavech. Vektor t.")
disp(t)
%% Ppst konce v danem stavu ... 
syms d2 d3 d4 d5
%% ... pro absorpcni stav s_1

d = [1 d2 d3 d4 d5 0]';

eqs = P * d == d;

% Vyřeš jen rovnice, kde jsou neznámé: d1 až d4
sol = solve(eqs(2:5), [d2 d3 d4 d5]);

disp("Ppst absorpce ve stavu s_1 pro stavy 2 - 5: (vektor d pro stav s_1)")
disp(sol)

%% ... pro absorpcni stav s_6

d = [0 d2 d3 d4 d5 1]';

eqs = P * d == d;
% Vyřeš jen rovnice, kde jsou neznámé: d1 až d4

sol = solve(eqs(2:5), [d2 d3 d4 d5]);

disp("Ppst absorpce ve stavu s_6 pro stavy 2 - 5: (vektor d pro stav s_6)")
disp(sol)
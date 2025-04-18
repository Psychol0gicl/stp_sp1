% Idea vypoctu stredniho poctu kroku pro prvni dosazeni stavu j ze stavu i
% je takova, ze z j-teho stavu udelam umele absorpcni a zbytek uzlu tedy
% bude tranzientnich. Pote mohu vyuzit k vypoctu nasi ulohy maticovy
% vypocet pro stredni pocet prechodu pres dany tranzientni stavy (prednaska
% 7, str 26)
numNodes = 6;

P = ones(numNodes, numNodes) / numNodes;

P= rand(numNodes, numNodes);
P = P ./ sum(P, 2); 

disp(P)
graphObj = digraph(P);
plot(graphObj, 'EdgeLabel', graphObj.Edges.Weight);
title('Homogeneous and Regular Markov Chain');

n = size(P, 1);

% inicializace
MFPT = zeros(n);

% jednotkova matice
I = eye(n);

% iterace pres kazdy cilovy stav `j`
for j = 1:n
    % P_j je prechodova matice, kde cilovy stav je absorpcni, abychom
    % simulovali to, ze pri prvnim prichodu z nej nevyleze
    P_j = P;
    P_j(j, :) = 0;
    P_j(j, j) = 1;
    % disp(P_j)
    
    
    % Q vznika vynechanim radku a sloupcum absorpcnich stavu (coz je v
    % nasem pripade vzdycky j-ty rade/sloupec)
    Q = P_j;
    Q(j, :) = [];
    Q(:, j) = [];

    % disp(Q)
    
    % T = (I-Q)^{-1} = inv(I - Q)
    T = inv(I(1:n-1, 1:n-1) - Q);
    
    % disp('T:')
    % disp(T)
    
    % Mean first passage times to state j from all i ≠ j
    % Kdyz vynasobim matici T zprava jednotkovou matici, 
    % dostanu tim vektor ocekavanych poctu kroku pred absorpci pro kazdy
    % pocatecni stavu
    t = T * ones(n-1, 1);
    
    
    % Matlab krici ze by bylo lepsi to zapsat takto:
    % T_not_inv = I(1:n-1, 1:n-1) - Q
    % t = T_not_inv \ ones(n-1,1);
    % ale za me je lepsi to zapsat tak jak jsem to udelal, protoze to
    % odpovida postupu v prednaskach
    
    
    % disp("t:")
    % disp(t)

    % Place into MFPT matrix
    idx = [1:j-1, j+1:n];
    MFPT(idx, j) = t;
end
disp(MFPT)


%%
% Finalni ppsti
% Resime problem vlastnich cisel pro pi = pi P
% strana 16 v prednasce 7



[V, D] = eig(P.');
disp(V)
disp(D)


[~, idx] = min(abs(diag(D) - 1));
% idx na prvni pohled vypada, ze je vzdycky prvni sloupec

pi_vec = V(:, idx);
% disp(pi_vec)

pi_vec = pi_vec / sum(pi_vec);
% disp(pi_vec)

pi_vec = real(pi_vec);


disp("Final probabilities (stationary distribution):")
disp(pi_vec)

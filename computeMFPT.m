function M = computeMFPT(P)
    n = size(P, 1);
    M = zeros(n);
    for j = 1:n
        % Build linear system for m_{ij} for all i ≠ j
        I = eye(n);
        A = I - P;
        A(j,:) = 0;
        A(j,j) = 1;
        b = ones(n,1);
        b(j) = 0;
        m_j = A \ b;
        M(:,j) = m_j;
        M(j,j) = 0;
    end
end
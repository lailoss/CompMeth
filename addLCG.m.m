function output = addLCG(maxVal)
    % Additive LCG (Fibonacci-style): Xn = (Xn-1 + Xn-2) mod m

    m = 2^31 - 1;
    
    % Generate two seeds using rand
    x1 = floor(rand() * (m - 1)) + 1;
    x2 = floor(rand() * (m - 1)) + 1;

    % Compute next number using additive rule
    x3 = mod(x1 + x2, m);

    % Normalize to [1, maxVal]
    r = floor((x3 / m) * maxVal) + 1;
end

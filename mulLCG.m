function r = mulLCG(maxVal)
    a = 77;  % Multiplier
    c = 0;   % Increment (unused here)
    m = 100;

    % FreeMat-compatible integer seed from 1 to m-1
    seed = floor(rand() * (m - 1)) + 1;

    % LCG formula
    x = mod((a * seed + c), m);
    r = floor(x / m * maxVal) + 1;
end
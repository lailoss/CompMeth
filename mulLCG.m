function r = mulLCG(maxVal)
    a = 77;  % Multiplier
    c = 0;   % Increment (unused here)
    m = 1000;

    %insert seed
    seed = floor(rand() * (m - 1)) + 1;

    % LCG formula
    x = mod((a * seed + c), m);
    r = mod(x, maxVal)+1;
end

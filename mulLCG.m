function r = mulLCG(maxVal)
    a = 16807;
    c = 0;
    m = 2^31 - 1;
    seed = floor(rand() * (m - 1)) + 1;
    r = mod((a * seed + c), m);
    r = floor(r / m * maxVal) + 1;
end

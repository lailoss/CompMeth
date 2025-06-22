function output = mixedLCG(maxVal)
    a = 5;
    c = 3;
    m = 8;

    seed = floor(rand() * (m - 1)) + 1;
    x = mod((a * seed + c), m);
    output = floor(x / m * maxVal) + 1;
end

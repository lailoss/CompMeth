function output = mixedLCG(maxVal)
    a = 5;
    c = 3;
    m = 1000;

    seed = floor(rand() * (m - 1)) + 1;
    x = mod((a * seed + c), m);
    r = mod(x, maxVal)+1; %ensures range [1,maxVal]
end

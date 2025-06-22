function r = mulLCG(maxVal)
    a = 77; %multiplier
    c = 0; %required
    m = 100
    seed = randi([1, m - 1]); %seed in valid range : 1-m-1
    x = mod((a * seed + c),m); %LCG 
    r = floor(x / m * maxVal) + 1; %cuts to desired range
end

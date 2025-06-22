function IAT = interArrivalTime(status)
    switch status
        case 'p'  % Peak hours
            IAT.n = [1, 2, 3];
            probs = [0.50, 0.30, 0.20];

        case 'n'  % Non-peak hours
            IAT.n = [1,2,3,4,5];
            probs = [0.10, 0.20, 0.30, 0.25, 0.15];

        otherwise
            error('Mode must be ''p'' (peak) or ''n'' (non-peak)');
    end

    IAT.cdf = cumsum(probs);  % ✅ both use same output struct
end

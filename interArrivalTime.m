function IAT = interArrivalTime(status)
    switch status
<<<<<<< HEAD
        case 'p'  % Peak hours
            IAT.n = [1, 2, 3];
            probs = [0.50, 0.30, 0.20];
=======
        case 'p'  % Peak hours (shorter interarrival times)
            IAT.n = [1, 2, 3];
            probs = [0.50, 0.35, 0.15];  % Higher chance for 1 and 2 minutes
>>>>>>> 44c6c7a69395fe3f86aa80d3bf9606c02e5cfb07

        case 'n'  % Non-peak hours
            IAT.n = [1,2,3,4,5];
            probs = [0.10, 0.20, 0.30, 0.25, 0.15];

        otherwise
            error('Mode must be ''p'' (peak) or ''n'' (non-peak)');
    end

    IAT.cdf = cumsum(probs);
end

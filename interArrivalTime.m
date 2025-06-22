function IAT=interArrivalTime(status)
     switch status
        case 'p'  % Peak hours: shorter gaps, more frequent cars
            IAT.n = [1, 2, 3, 4, 5];  % in minutes
            probs   = [0.30, 0.25, 0.20, 0.15, 0.10]; %MAY CHANGE 
        
        case 'n'  % Non-peak hours: longer gaps
            table.n = [3, 4, 5, 6, 7];
            probs   = [0.10, 0.20, 0.30, 0.25, 0.15]; %MAY CHANGE

        otherwise
            error('Mode must be ''p'' (peak) or ''n'' (non-peak)');
    end

    IAT.cdf = cumsum(probs);  % compute cumulative distribution
end
    
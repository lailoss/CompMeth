function refuel = refuelingTime()
% refuelingTime - Returns typical refueling durations with CDF
% Output:
%   table.time = possible refueling durations (in minutes)
%   table.cdf  = cumulative probabilities for each duration

    refuel.time = [2, 3, 4, 5, 6];         % Refueling durations in minutes
    probs       = [0.10, 0.25, 0.35, 0.20, 0.10];  % Probabilities

    refuel.cdf = cumsum(probs);  % Convert to cumulative form
end

function PType = petrolType()
% petrolType - Returns fuel types, prices, and their CDF
% Output:
%   table.petrol = cell array of petrol type names
%   table.price  = price per liter (in RM)
%   table.cdf    = cumulative distribution for selection

    PType.petrol = {'Primax95', 'Primax97', 'Dynamic Diesel'};
    PType.price  = [2.05, 3.47, 2.15];  % Example prices (RM/liter)

    probs = [0.50, 0.30, 0.20];  % Adjust probabilities as needed

    PType.cdf = cumsum(probs);  % Convert to cumulative distribution
end

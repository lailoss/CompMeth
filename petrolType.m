function PType = petrolType()


    PType.petrol = {'RON95', 'RON97', 'Diesel'};
    PType.price  = [2.05, 3.14, 2.81];  % Example prices (RM/liter)

    probs = [0.50, 0.30, 0.20];  % Adjust probabilities as needed

    PType.cdf = cumsum(probs);  % Convert to cumulative distribution
end

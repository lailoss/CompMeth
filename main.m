% main.m
% feqhahsimulateQueuedelilah - member 1 (main simulation n coordination)
function main()
    clc;
    clear;

    cust = input('How many vehicles to simulate? '); % ---ask user how many vehicles to simulate---

   
    disp('Select Random Number Generator:');  % ---select RNG method---
    disp('1. Mixed LCG');
    disp('2. Additive LCG');
    disp('3. Multiplicative LCG');
    rngChoice = input('Enter 1, 2 or 3: ');

    % input peak or non-peak
    disp('Choose Time Type:');
    disp('0 - Non Peak Hours');
    disp('9 - Peak Hours');
    peakTime = input('Enter 0 or 9: ');

    if ~ismember(rngChoice, [1,2,3]) || ~ismember(peakTime, [0,9])
        disp('Invalid input. Please restart the simulation and try again.');
        return;
    end

    % ---call the main simulation function --- pass in number of vehicles, rng type, and peak type
    simulateQueue(cust, rngChoice, peakTime);

    disp('Simulation complete.');
end

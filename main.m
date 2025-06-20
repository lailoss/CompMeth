function main()
    clc;
    clear;

    % ask how many vehicles to simulate
    cust = input('How many vehicles to simulate? ');

    % select RNG method
    disp('Select Random Number Generator:');
    disp('1. Mixed LCG');
    disp('2. Additive LCG');
    disp('3. Multiplicative LCG');
    rngChoice = input('Enter 1/2/3: ');

    % input peak or non-peak
    disp('Select Simulation Time:');
    disp('0 - Non-Peak Hours');
    disp('9 - Peak Hours');
    peakTime = input('Enter 0 or 9: ');

    % basic validation
    if ~ismember(rngChoice, [1,2,3]) || ~ismember(peakTime, [0,9])
        disp('Invalid input. Please restart the simulation and try again.');
        return;
    end

    % call the main simulation function
    % pass in number of vehicles, rng type, and peak type
    simulateQueue(cust, rngChoice, peakTime);

    % done
    disp('Simulation complete.');
end

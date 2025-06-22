% main.m
% feqhah delilah main - member 1 (main simulation n coordination)

function main()
    clc;
    clear;

    cust = input('How many vehicles to simulate? '); % --- ask user how many vehicles to simulate ---

    % input peak or non-peak
    disp('Choose Time Type:');
    disp('0 - Non Peak Hours');
    disp('9 - Peak Hours');
    peakTime = input('Enter 0 or 9: ');

    if peakTime ~= 0 && peakTime ~= 9
        disp('Invalid input. Please restart the simulation and try again.');
        return;
    end

    % --- call the main simulation function using Mixed LCG only ---
    simulateQueue(cust, peakTime);

    disp('Simulation complete.');
end

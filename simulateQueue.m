% simulateQueue.m (handles vehicle arrivals. queue assign , refueling, logs)
% feqhahdelilah - member 1 (main simulation n coordination)

function simulateQueue(cust, peakTime, rngChoice)

    petrolTypeArr = cell(1, cust);  % --type of minyak--
    literArr = zeros(1, cust);      % --fuel quantity--
    pricePerLiter = zeros(1, cust); % --price per litre--
    totalPrice = zeros(1, cust);    % --total cost--

    arrivalTime = zeros(1, cust);
    interArrTime = zeros(1, cust);
    RN_arrival = zeros(1, cust);

    refuelTime = zeros(1, cust);
    RN_refuel = zeros(1, cust);

    timeStart = zeros(1, cust);
    timeEnd = zeros(1, cust);
    waiting = zeros(1, cust);

    pumpUsed = zeros(1, cust);
    lineUsed = zeros(1, cust);

    pumpTime = zeros(1,4);
    lineMap = [1 1 2 2];

    % -- load interarrival time based on peak hours or not --
    if peakTime == 9
       inter = interArrivalTime('p');
    else
       inter = interArrivalTime('n');
    end

    pt = petrolType();
    rt = refuelingTime();

    for i = 1:cust
        % Use selected RNG for all random numbers
        num = getRandom(100, rngChoice);

        % -- determine petrol type by CDF --
        if num <= pt.cdf(1)*100
           petrolTypeArr{i} = pt.petrol{1};
           pricePerLiter(i) = pt.price(1);
        elseif num <= pt.cdf(2)*100
           petrolTypeArr{i} = pt.petrol{2};
           pricePerLiter(i) = pt.price(2);
        else
           petrolTypeArr{i} = pt.petrol{3};
           pricePerLiter(i) = pt.price(3);
        end

        % -- determine quantity of fuel --
        literArr(i) = getRandom(50, rngChoice);
        totalPrice(i) = literArr(i) * pricePerLiter(i);

        % -- inter-arrival RNG --
        RN_arrival(i) = getRandom(100, rngChoice);

        % -- determine inter arrival time --
        for j = 1:length(inter.cdf)
            if RN_arrival(i) <= inter.cdf(j)*100
                interArrTime(i) = inter.n(j);
                break;
            end
        end

        if i == 1
            arrivalTime(i) = 0;
        else
            arrivalTime(i) = arrivalTime(i-1) + interArrTime(i);
        end

        % -- refueling time RNG --
        RN_refuel(i) = getRandom(100, rngChoice);

        % determine refueling duration
        for j = 1:length(rt.cdf)
            if RN_refuel(i) <= rt.cdf(j)*100
                refuelTime(i) = rt.time(j);
                break;
            end
        end

        % check for available pump
        assigned = false;
        for j = 1:4
            if pumpTime(j) <= arrivalTime(i)
                timeStart(i) = arrivalTime(i);
                waiting(i) = 0;
                timeEnd(i) = timeStart(i) + refuelTime(i);
                pumpTime(j) = timeEnd(i);
                pumpUsed(i) = j;
                lineUsed(i) = lineMap(j);
                assigned = true;
                break;
            end
        end

        % if all pumps busy
        if ~assigned
            [soonest, whichPump] = min(pumpTime);
            timeStart(i) = max(arrivalTime(i), soonest);
            waiting(i) = timeStart(i) - arrivalTime(i);
            timeEnd(i) = timeStart(i) + refuelTime(i);
            pumpTime(whichPump) = timeEnd(i);
            pumpUsed(i) = whichPump;
            lineUsed(i) = lineMap(whichPump);
        end

        % adjust first vehicle for clean output
        if i == 1
            RN_refuel(i) = -1;
            interArrTime(i) = 0; %nani was here
            timeStart(i) = 0;
            waiting(i) = 0;
        end
    end

    % -- Display Summary --
    fprintf(' ');
    fprintf('\n---------------- SIMULATION RESULT ----------------\n');
    fprintf('%3s %10s %8s %8s %10s %10s %6s\n',...
    'VehicleNo', 'Petrol', 'Qty', 'Total', 'Arrival', 'Start', 'Pump');
    for i = 1:cust
        fprintf('%3d %10s %8.0f %8.2f %10.0f %10.0f %6d\n',...
        i, petrolTypeArr{i}, literArr(i), totalPrice(i), arrivalTime(i), timeStart(i), pumpUsed(i));
    end

    fprintf('\n---------- FULL VEHICLE DETAILS TABLE ----------\n');
    fprintf('%-10s %-10s %-6s %-8s %-8s %-10s %-8s %-8s %-6s %-6s\n', ...
        'VehicleNo', 'Petrol', 'Qty', 'Total', 'Arrival', 'InterArr', 'Start', 'End', 'Pump', 'Wait');

    for i = 1:cust
        fprintf('%-10d %-10s %-6.0f %-8.2f %-8.0f %-10.0f %-8.0f %-8.0f %-6d %-6.0f\n', ...
            i, petrolTypeArr{i}, literArr(i), totalPrice(i), ...
            arrivalTime(i), interArrTime(i), timeStart(i), timeEnd(i), pumpUsed(i), waiting(i));
    end
    
    % -- Display Pump Usage -- 
    fprintf(' ');
    fprintf('\n---------------- PETROL PUMP USAGE ----------------\n');
    fprintf('%-10s | %-20s %-15s %-15s | %-20s %-15s %-15s\n',...
    'VehicleNo', 'Pump1:RefuellingTime', 'Pump1:Start', 'Pump1:End',...
    'Pump2:RefuellingTime', 'Pump2:Start', 'Pump2:End');
    for i = 1:cust
        if (pumpUsed(i)== 1)
            fprintf('%-10d | %-20.0f %-15.0f %-15.0f | %-20s %-15s %-15s\n',...
            i, refuelTime(i), timeStart(i), timeEnd(i), '-','-', '-');
        elseif (pumpUsed(i)== 2)
            fprintf('%-10d | %-20s %-15s %-15s | %-20.0f %-15.0f %-15.0f\n',...
            i, '-','-', '-', refuelTime(i), timeStart(i), timeEnd(i));
        end
    end
    
    fprintf(' ');
    fprintf('%-10s | %-20s %-15s %-15s | %-20s %-15s %-15s\n',...
    'VehicleNo', 'Pump3:RefuellingTime', 'Pump3:Start', 'Pump3:End',...
    'Pump4:RefuellingTime', 'Pump4:Start', 'Pump4:End');
    for i = 1:cust
        if (pumpUsed(i)== 3)
            fprintf('%-10d | %-20.0f %-15.0f %-15.0f | %-20s %-15s %-15s\n',...
            i, refuelTime(i), timeStart(i), timeEnd(i), '-','-', '-');
        elseif (pumpUsed(i)== 4)
            fprintf('%-10d | %-20s %-15s %-15s | %-20.0f %-15.0f %-15.0f\n',...
            i, '-','-', '-', refuelTime(i), timeStart(i), timeEnd(i));
        end
    end

    % -- Log actions by time --
    fprintf(' ');
    fprintf('\n---------------- LOG ----------------\n');
    for t = 0:max(timeEnd)
        for i = 1:cust
            if arrivalTime(i) == t
                fprintf('Vehicle %d arrived at %dmin and started refueling at Pump %d with %s.\n',...
                i, t, pumpUsed(i), petrolTypeArr{i});
            end
            if timeEnd(i) == t
                fprintf('Vehicle %d finished and left at %dmin.\n', i, t);
            end
        end
    end

    % --- Evaluation Statistics ---
    avgWait = mean(waiting);
    avgSystemTime = mean(timeEnd - arrivalTime);
    probWait = sum(waiting > 0) / cust;
    avgServiceTime = mean(refuelTime);

    fprintf('\n---------- SIMULATION EVALUATION ----------\n');
    fprintf('Average waiting time: %.2f minutes\n', avgWait);
    fprintf('Average time in system: %.2f minutes\n', avgSystemTime);
    fprintf('Probability that a vehicle has to wait: %.2f%%\n', probWait * 100);
    fprintf('Average refueling time: %.2f minutes\n', avgServiceTime);
end

% --- Helper function to choose RNG ---
function r = getRandom(maxVal, rngChoice)
    if rngChoice == 1
        r = mixedLCG(maxVal);
    elseif rngChoice == 2
        r = mulLCG(maxVal);
    else
        error('Invalid RNG type selected.');
    end
end

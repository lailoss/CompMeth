% simulateQueue.m (handles vehicle arrivals. queue assign , refueling, logs)
% feqhahdelilah - member 1 (main simulation n coordination)

function simulateQueue(cust, x, y)

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

    % -- load interarrival time basedd on peak hours or not --
    if y == 9
       inter = interArrivalTime('p');
    else
       inter = interArrivalTime('n');
    end

    pt = petrolType();
    rt = refuelingTime();

    for i = 1:cust
        % RNG for petrol type
        if x == 1
            num = mixedLCG(100);
        elseif x == 2
            num = addLCG(100);
        else
            num = mulLCG(100);
        end

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
        if x == 1
            literArr(i) = mixedLCG(50);
        elseif x == 2
            literArr(i) = addLCG(50);
        else
            literArr(i) = mulLCG(50);
        end

        totalPrice(i) = literArr(i) * pricePerLiter(i);

        % -- interval time RNG --
        if x == 1
            RN_arrival(i) = mixedLCG(100);
        elseif x == 2
            RN_arrival(i) = addLCG(100);
        else
            RN_arrival(i) = mulLCG(100);
        end

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

        % RNG for refueling time
        if x == 1
            RN_refuel(i) = mixedLCG(100);
        elseif x == 2
            RN_refuel(i) = addLCG(100);
        else
            RN_refuel(i) = mulLCG(100);
        end

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
            interArrTime(i) = -1;
            timeStart(i) = 0;
            waiting(i) = 0;
        end
    end

    % Display Summary
    fprintf('\n---------------- SIMULATION RESULT ----------------\n');
    fprintf('%3s %10s %8s %8s %10s %10s %6s\n', 'No', 'Petrol', 'Qty', 'Total', 'Arrival', 'Start', 'Pump');
    for i = 1:cust
        fprintf('%3d %10s %8.0f %8.2f %10.0f %10.0f %6d\n', i, petrolTypeArr{i}, literArr(i), totalPrice(i), arrivalTime(i), timeStart(i), pumpUsed(i));
    end

    % Log actions by time
    fprintf('\n---------------- LOG ----------------\n');
    for t = 0:max(timeEnd)
        for i = 1:cust
            if arrivalTime(i) == t
                fprintf('Vehicle %d arrived at %dmin and started refueling at Pump %d with %s.\n', i, t, pumpUsed(i), petrolTypeArr{i});
            end
            if timeEnd(i) == t
                fprintf('Vehicle %d finished and left at %dmin.\n', i, t);
            end
        end
    end
end



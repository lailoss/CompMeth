function output = MixedLCG(n,a,c,m)
    %   n - Number of random numbers to generate
%   a - Multiplier
%   c - Increment
%
% Output:
%   r - Row vector of random numbers in [0, 1)
    %Xn=(aXn-1 + c) mod m
    seed=floor(rand()*(m-1))+1; %this is Xo, generates seed in rage[1, m-1]
    m=2^31-1 %large prime numbers
    
    
    if a==1
       if a == 1
        % --- Additive LCG ---
        % Requires two initial seeds
        x0 = floor(rand() * (m - 1)) + 1;
        x1 = floor(rand() * (m - 1)) + 1;
        x = [x0, x1];

        for i = 3:n
            x(i) = mod(x(i-1) + x(i-2), m);
        end

        r = x(1:n) / m;
          elseif c == 0
        % --- Multiplicative LCG ---
        x = floor(rand() * (m - 1)) + 1;

        for i = 1:n
            x = mod(a * x, m);
            r(i) = x / m;
        end

    else
        % --- Mixed LCG ---
        x = floor(rand() * (m - 1)) + 1;

        for i = 1:n
            x = mod(a * x + c, m);
            r(i) = x / m;
        end
    end
end
    
    
    
    
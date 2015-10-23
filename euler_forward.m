function [x,y]= euler_forward(f, xinit, yinit, xfinal, n)
    
    % Euler approximation of ODE for initial value problems
    % Euler Forward method
    % Argument description
    % f - the function handle, can also intake coupled equations
    % xinit - the initial value for the independent variable, dimensions
    %             must match with f
    % yinit - the initial value for the dependent variable , dimensions
    %             must match with f
    % xfinal - the final value of the dependent variable
    % n - are the number of divisions
    % 
    % 
    % For example: this is possible : f = @(t, y) [y(2);
    %                                              0.1*(1-y(1)^2)*y(2)-y(1)]
    %
    %                                  to represent a system of equations
    %
    %                                            dy1/dt = y2 &
    %                                            dy2/dt = 0.1*(1-y1^2)*y2-y1
    %
    %                                  with initial conditions to
    %                                  be represented as 
    %
    %                                             xinit = [0; 0]
    %                                             yinit = [1; 0] 
    %
    %                                  and final conditions as 
    %
    %                                             yfinal = [10; 10]
    %
    %                                   Call the function as 
    % 
    %           [t, y] = euler_forward(f,[0; 0], [1; 0], [10; 10], 100)
    
    % Code adapted from
    % https://www.mccormick.northwestern.edu/docs/efirst/ode.pdf 
    
    

    % Calculation of h from xinit, xfinal and n
    % calculate step size
    h = (xfinal - xinit)/n;

    % Initialization of x and y as column vectors
    
    % Find the number of equations we have, although both should be same, 
    % we calculate both for clarity 
    xrow_count = size(xinit);
    yrow_count = size(yinit);
    
    % Fill x with initial values, and initialize the rest to zero
    x = [xinit zeros(xrow_count,n)]; 
    y = [yinit zeros(yrow_count,n)];

    % Calculation of x and y
    for i = 1:n
        for j = 1:xrow_count
            x(j, i+1) = x(j, i) + h(j);
            y(j, i+1) = y(j, i) + h(j)* builtin('_paren', f(x(j, i), y(:, i)), j, 1);  % An undocumented matlab feature/hack, solution taken from http://stackoverflow.com/questions/3627107/how-can-i-index-a-matlab-array-returned-by-a-function-without-first-assigning-it 
        end
    end
    
   for j = 1:xrow_count
       plot(x(j, :), y(j, :));
       hold all;
   end
   
end

    
function [xZero, abortFlag, iters] = myNewton(varargin)
% myNewton - The function estimates the zero cross point by using Newtons
% algorithm
%
% Syntax:  [xZero, abortFlag, iters] = myNewton('function', func, 
%           'derivative', dfunc, 'startValue', x0, 'maxIter', maxIter,
%           'feps', feps, 'xeps', xeps, 'livePlot', livePlot)
%
% Inputs:
%       'function' func: A function for finding the zero cross point of it
%       'derivative', dfunc (optional): Derivative of above function. When
%       not provided, the zero cross point will be calculated numerically.
%       'startValue', x0 (optional): First guess of where a zero crossing
%       point might be located. Default 0.
%       'maxIter', maxIter (optional): Maximum count of iterations. Default
%       50.
%       feps', feps (optional): Uncertainity of function value. Default: 10^-6
%       'xeps', xeps (optional): Uncertainity of first guessed x value.
%       Default: 10^-6.
%       'livePlot', livePlot (optional): Show the function and algorithm in
%       real time as it runs. Default: 'off'.
%
% Outputs:
%    xZero: Approximated x-Position after Newtons algorithm is terminated.
%    abortFlag: Retuerns the reason why the algorithm has been aborted.
%    iters: Total count of iterations
%
% Example: 
%    
%   >> [x, flag, iters] = myNewton('function', @(x) x^2, 'startValue', 1)
%
% Other m-files required: numDiff.m
% Subfunctions: none
% MAT-files required: numDiff.m
%
% See also: numDiff.m
%
% Author: Marvin G
% Work address: none
% email: inf21168@lehre.dhbw-stuttgart.de
% Website: none
% March 2023; Last revision: 28-Mar-2023

%------------- BEGIN CODE --------------

%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end
    
if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

%% start of algorithm
if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';

if ~exist('dfunc', 'var')
    methodByUserInput = questdlg("Which Method shall be used?", "Derivation Method Selector", 'forwardDiff', 'reverseDiff' , 'centralDiff', 'centralDiff')
end

for i = 1:maxIter
    f = func(xOld);
    if abs(f) < feps
        abortFlag = 'feps';
        break;
    end
    
    if exist('dfunc', 'var')
        df = dfunc(xOld);
    else
        df = numDiff(func, xOld, methodByUserInput)
    end
    
    
    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
end
% ------------- END OF CODE --------------
function df = numDiff(func, x, method)
% numDiff - The function perfors either a forward, backwards or a central
% differentiation step
% with a given function passed as an argument. The differentiation method
% is selected by the "method" argument
%
% Syntax:  df = numDiff(inputFunction, xValue, input3)
%
% Inputs:
%    func: Polynomic function with at least one zero crossing point

%    x - Guessed x-value in y(x)-diagram where a zero crossing point of the
%    polynomic function might be in close proximity. It is the entry-point where
%    the tangent is getting calculated in the beginning.

%    method - Select the differentiation method for the next step. CHoose
%    between: 'forwardDiff', 'reverseDiff' or 'centralDiff'.
%
% Outputs:
%    ans: Result after a iteration of the selected method.
%
% Example: 
%    
%    >> numDiff(@(x) x^2, 1, 'forwardDiff')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: none

% Author: Marvin G
% Work address: none
% email: inf21168@lehre.dhbw-stuttgart.de
% Website: none
% March 2023; Last revision: 28-Mar-2023

%------------- BEGIN CODE --------------

switch method

    case 'forwardDiff'
        df = (func(x + 10^(-8)) - func(x)) / (10^(-8));
    case 'reverseDiff'
        df = (func(x) - func(x - 10^(-8))) / (10^(-8));
    case 'centralDiff'
        df = (func(x + 10^(-6)) - func(x - 10^(-6))) / (2 * (10^(-6)));
    otherwise
        error("Invalid numeric-differentiation-method identifier. As allowed input strings are only: method = ['forwardDiff','reverseDiff','centralDiff'] allowed")
end

end
% ------------- END OF CODE --------------
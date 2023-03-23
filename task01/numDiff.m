function df = numDiff(func, x, method)

switch method

    case 'forwardDiff'
        df = (func(x + 10^(-8)) - func(x)) / (2 * 10^(-8));
    case 'reverseDiff'
        df = (func(x) - func(x - 10^(-8))) / (10^(-8));
    case 'centralDiff'
        df = (func(x + 10^(-8)) - func(x - 10^(-8))) / (2 * (10^(-8)));
    otherwise

end

end
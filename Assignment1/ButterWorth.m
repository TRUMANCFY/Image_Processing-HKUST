function f = ButterWorth(sze, cutoff, n)

% TODO:
% Complete the butterworth filter
if (length(sze) == 1) 
    rows = sze; cols = sze;
else rows = sze(1); cols = sze(2);
end
if (mod(cols,2)) 
    xrange=[-(cols-1)/2:(cols-1)/2]/(cols-1); 
    else xrange=[-cols/2:(cols/2-1)]/cols;
end
if (mod(rows,2)) 
    yrange=[-(rows-1)/2:(rows-1)/2]/(rows-1); 
else yrange = [-rows/2:(rows/2-1)]/rows;
end
[x, y] = meshgrid(xrange, yrange);
radius = sqrt(x.^2 + y.^2);
f = 1.0 ./ (1.0 + (radius./cutoff).^(2*n));
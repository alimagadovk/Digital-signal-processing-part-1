function res = uquantizer(f, min, max, level_count)
    levels = min:(max-min)/(level_count):max;
    res = zeros(size(f));
    for i = 1:1:length(f)
        n = find(levels>=f(i));
        res(i) = (levels(n(1)) + levels(n(1)-1))/2;
    end
end
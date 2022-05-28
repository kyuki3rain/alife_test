t = 1:500;
a = 2.4:0.001:4.0;
x = ones(size(a)) / 2;

figure
hold on

for i = t
    x = a .* x .* (1 - x);
    if i > 100
        scatter(a, x, 2, 'filled');
    end
end

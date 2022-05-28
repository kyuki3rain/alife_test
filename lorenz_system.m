p = 10;
r = 28;
b = 8 / 3;

dt = 0.01;

xs = zeros(1, 501);
ys = zeros(1, 501);
zs = zeros(1, 501);

xs(1) = 1;
ys(1) = 1;
zs(1) = 1;

for i = 1:10000
    xs(i+1) = xs(i) + dt * (- p * xs(i) + p * ys(i));
    ys(i+1) = ys(i) + dt * (- xs(i) * zs(i) + r * xs(i) - ys(i));
    zs(i+1) = zs(i) + dt * (xs(i) * ys(i) - b * zs(i));
end

figure
plot3(xs, ys, zs);
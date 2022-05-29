f = ;

field = zeros(500, 600);    
field(1, :) = int32(randi([0, 1], [1, 600]));

for i = 2:500
    l(2:599) = field(i-1, 1:598);
    s(2:599) = field(i-1, 2:599);
    r(2:599) = field(i-1, 3:600);

    l(1) = field(i - 1, 1);
    s(1) = field(i - 1, 1);
    r(1) = field(i - 1, 2);
    l(599) = field(i - 1, 599);
    s(599) = field(i - 1, 600);
    r(599) = field(i - 1, 600);

    p = l * 4 + s * 2 + r;

    rule = f;
    for j = 0:7
        if rem(rule, 2) == 1
            field(i, p == j) = 1;
        end
        rule = floor(rule / 2);
    end
end

figure
imagesc(field)
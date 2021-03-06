figure
hold on
windowSize = 50;
sss = zeros(1, 9);
counttt = zeros(1, 9);

for f = 0:255
    field = zeros(500, 600);  
    field_filt = zeros(500, 600);
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
        count = 0;
        for j = 0:7
            count = count + int32(rem(rule, 2)); 
            if rem(rule, 2) == 1
                field(i, p == j) = 1;
            end
            rule = floor(rule / 2);
        end

        field_filt(i, :) = filter((1/windowSize)*ones(1,windowSize), 1, field(i, :));
    end
%     scatter(count/8, sum(abs(field_filt(400:500, 300) - field_filt(399:499, 300)))/100);
    sss(1, int32(count) + 1) = sss(1, int32(count) + 1) + sum(abs(field_filt(350:450, 300) - field_filt(349:449, 300)))/100;
    counttt(1, int32(count) + 1) = counttt(1, int32(count) + 1) + 1;
end

sss = sss ./ counttt;
plot(0:0.125:1, sss);
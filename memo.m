% パラメータ
x_min = -30; % x の最小値
x_max = 30; % x の最大値
dx = 0.5; % x 方向の細かさ
y_min = -30; % y の最小値
y_max = 30; % y の最大値
dy = 0.5; % y 方向の細かさ
p = 10; % dxとdtの比
k = 0.005; % 減衰係数
t_min = 0;% t の最小値
t_max = 30; % t の最大値
dt = dx / p; % t 方向の細かさ

dtdx = (dt / dx) ^ 2;
dtdy = (dt / dy) ^ 2;

% 初期化処理
u = zeros((t_max - t_min) / dt, (x_max - x_min) / dx, (y_max - y_min) / dy);
for x = 1:(x_max - x_min) / dx
    for y = 1:(y_max - y_min) / dy
        u(1, x, y) = u(1, x, y) + exp(- ((x * dx + x_min)^2 + (y * dy + y_min)^2) / 2);
    end
end
for yi = 20:20:40
    for x = 1:(x_max - x_min) / dx
        for y = 1:(y_max - y_min) / dy
            u(1,x,y)=u(1,x,y)+exp(-((x*dx+x_min)^2+((y -yi)* dy + y_min)^2) / 2);
            u(1,x,y)=u(1,x,y)+exp(-((x*dx+x_min)^2+((y +yi)* dy + y_min)^2) / 2);
        end
    end
end
 
 % グラフィック初期化
[X, Y] = meshgrid(1:(x_max - x_min) / dx, 1:(y_max - y_min) / dy);
Z = squeeze(u(1,:,:));

figure
mesh(X, Y, Z)
axis([0, (x_max - x_min) / dx, 0, (y_max - y_min) / dy, -1.5 * p, 1.5 * p])
ax = gca;
ax.NextPlot = 'replaceChildren';
F((t_max - t_min) / dt) = struct('cdata',[],'colormap',[]);
v = VideoWriter('newfile.mp4','MPEG-4'); v.Quality = 100;
v.FrameRate = 30;
open(v)

% シミュレーション実行
for t = 1:(t_max - t_min) / dt
    if t >= (t_max - t_min) / dt
        break;
    end
    Z = squeeze(u(t,:,:));
    mesh(X, Y, Z);
    drawnow
    F(t) = getframe(gcf);
    writeVideo(v,F(t));

    for x = 1:(x_max - x_min) / dx 
        for y = 1:(y_max - y_min) / dy
        u(t + 1, x, y) = 0;
            if x == 1
                u(t + 1, x, y) = u(t + 1, x, y) + dtdx * (u(t, x + 1, y) - 2 * u(t, x, y) + 0);
            elseif x == (x_max - x_min) / dx
                u(t + 1, x, y) = u(t + 1, x, y) + dtdx * (0 - 2 * u(t, x, y) + u(t, x - 1, y));
            else
                u(t + 1, x, y) = u(t + 1, x, y) + dtdy * (u(t, x + 1, y) - 2 * u(t, x, y) + u(t, x - 1, y));
            end
            if y == 1
                u(t + 1, x, y) = u(t + 1, x, y) + dtdx * (u(t, x, y + 1) - 2 * u(t, x, y) + 0);
            elseif y == (y_max - y_min) / dy
                u(t + 1, x, y) = u(t + 1, x, y) + dtdy * (0 - 2 * u(t, x, y) + u(t, x, y - 1));
            else
                u(t + 1, x, y) = u(t + 1, x, y) + dtdy * (u(t, x, y + 1) - 2 * u(t, x, y) + u(t, x, y - 1));
            end
            if t == 1
                u(t + 1, x, y) = u(t + 1, x, y) + (2 - k) * u(t, x, y) - 0;
            else
                u(t + 1, x, y) = u(t + 1, x, y) + (2 - k) * u(t, x, y) - (1 - k);
            end
        end
    end
end

close(v);
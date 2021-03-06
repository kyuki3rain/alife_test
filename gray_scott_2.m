% シミュレーションの各パラメタ
SPACE_GRID_SIZE = 256;
dx = 0.01;
dt = 1;
VISUALIZATION_STEP = 8; % 何ステップごとに画面を更新するか。
FLAME_RATE = 1000;

% モデルの各パラメタ
Du = 2e-5;
Dv = 1e-5;

k = 0.05;

figure
hold on

for f = 0.01:0.001:0.05
    % 初期化
    u = ones(SPACE_GRID_SIZE, SPACE_GRID_SIZE);
    v = zeros(SPACE_GRID_SIZE, SPACE_GRID_SIZE);

    u(128, 128) = 0.5;
    v(128, 128) = 0.25;

    % 対称性を壊すために、少しノイズを入れる
    u = u + rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE) * 0.1;
    v = v + rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE) * 0.1;

    for i = 1:500
    
        % ラプラシアンの計算
        laplacian_u = (circshift(u, 1, 1) + circshift(u, -1, 1) + circshift(u, 1, 2) + circshift(u, -1, 2) - 4 * u) / (dx * dx);
        laplacian_v = (circshift(v, 1, 1) + circshift(v, -1, 1) + circshift(v, 1, 2) + circshift(v, -1, 2) - 4 * v) / (dx * dx);
        % Gray - Scottモデル方程式
        dudt = Du * laplacian_u - u .* v .* v + f * (1.0 - u);
        dvdt = Dv * laplacian_v + u .* v .* v - (f + k) * v;
        u = u + dt * dudt;
        v = v + dt * dvdt;

        if i > 400
            scatter(f, u(128, 128), 2, 'filled');
        end
    end

end
% シミュレーションの各パラメタ
SPACE_GRID_SIZE = 256;
dx = 0.01;
dt = 1;
VISUALIZATION_STEP = 8; % 何ステップごとに画面を更新するか。
FLAME_RATE = 1000;

% モデルの各パラメタ
Du = 2e-5;
Dv = 1e-5;
% f = 0.04; k = 0.06; % amorphous
% f = 0.035; k = 0.065; % spots
f = 0.012; k = 0.05; % wandering bubbles
% f = 0.02504; k = 0.05; % waves
% f = 0.022; k = 0.051; % stripe

% 初期化
u = ones(SPACE_GRID_SIZE, SPACE_GRID_SIZE);
v = zeros(SPACE_GRID_SIZE, SPACE_GRID_SIZE);

% 中央にSQUARE_SIZE四方の正方形を置く
SQUARE_SIZE = 2;
SPACE_GRID_SIZE_DIV2 = floor(SPACE_GRID_SIZE / 2);
SQUARE_SIZE_DIV2 = floor(SQUARE_SIZE / 2);
u(SPACE_GRID_SIZE_DIV2 - SQUARE_SIZE_DIV2:SPACE_GRID_SIZE_DIV2 + SQUARE_SIZE_DIV2, SPACE_GRID_SIZE_DIV2 - SQUARE_SIZE_DIV2:SPACE_GRID_SIZE_DIV2 + SQUARE_SIZE_DIV2) = 0.5;
v(SPACE_GRID_SIZE_DIV2 - SQUARE_SIZE_DIV2:SPACE_GRID_SIZE_DIV2 + SQUARE_SIZE_DIV2, SPACE_GRID_SIZE_DIV2 - SQUARE_SIZE_DIV2:SPACE_GRID_SIZE_DIV2 + SQUARE_SIZE_DIV2) = 0.25;

% 対称性を壊すために、少しノイズを入れる
u = u + rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE) * 0.1;
v = v + rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE) * 0.1;

figure
imagesc(u, [0 1])
pause(1 / FLAME_RATE)

while true

    for t = 1:VISUALIZATION_STEP
        % ラプラシアンの計算
        laplacian_u = (circshift(u, 1, 1) + circshift(u, -1, 1) + circshift(u, 1, 2) + circshift(u, -1, 2) - 4 * u) / (dx * dx);
        laplacian_v = (circshift(v, 1, 1) + circshift(v, -1, 1) + circshift(v, 1, 2) + circshift(v, -1, 2) - 4 * v) / (dx * dx);
        % Gray - Scottモデル方程式
        dudt = Du * laplacian_u - u .* v .* v + f * (1.0 - u);
        dvdt = Dv * laplacian_v + u .* v .* v - (f + k) * v;
        u = u + dt * dudt;
        v = v + dt * dvdt;
    end

    % 表示をアップデート
    imagesc(u, [0 1])
    pause(1 / FLAME_RATE)
end

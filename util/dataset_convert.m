% 資料路徑
input_dir = 'F:\PointCloud_Attack\adv_data\pc_adv_depth';
depth_output_dir = 'F:\PointCloud_Attack\adv_data\depth';
normal_output_dir = 'F:\PointCloud_Attack\adv_data\normal';

% 影像大小
img_size = 256;

% 檢查並建立輸出資料夾
if ~exist(depth_output_dir, 'dir')
    mkdir(depth_output_dir);
end
if ~exist(normal_output_dir, 'dir')
    mkdir(normal_output_dir);
end

subdirs = dir(input_dir);
for k = 3:length(subdirs)
    input_root = [input_dir '\' subdirs(k).name];
    depth_outdir = [depth_output_dir '\' subdirs(k).name];
    normal_outdir = [normal_output_dir '\' subdirs(k).name];
    
    % 建立子資料夾
    if ~exist(depth_outdir, 'dir')
        mkdir(depth_outdir);
    end
    if ~exist(normal_outdir, 'dir')
        mkdir(normal_outdir);
    end
    
    secsubdirs = dir(input_root);
    parfor i = 3:length(secsubdirs)
        fin_name = [input_root '\' secsubdirs(i).name];
        vertex = dlmread(fin_name, ' ');

        % 設定參數
        scale = 1.0;  % 可根據需要調整比例
        Use_preprocess = true;

        % 計算深度圖和法向量
        [depth, mask] = calcDepthAndNormal(vertex, scale, Use_preprocess);
        normal = calcNormal(depth);

        % 調整大小
        depth = imresize(depth, [img_size img_size]);
        normal = imresize(normal, [img_size img_size]);

        % 寫入輸出圖像
        imwrite(uint8(depth), [depth_outdir '\' secsubdirs(i).name(1:end-4) '_depth.png']);
        imwrite(uint8(normal), [normal_outdir '\' secsubdirs(i).name(1:end-4) '_normal.png']);
    end
    disp(['convert complete for ', subdirs(k).name, ' ...']);
end

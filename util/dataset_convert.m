% ��Ƹ��|
input_dir = 'F:\PointCloud_Attack\adv_data\pc_adv_depth';
depth_output_dir = 'F:\PointCloud_Attack\adv_data\depth';
normal_output_dir = 'F:\PointCloud_Attack\adv_data\normal';

% �v���j�p
img_size = 256;

% �ˬd�ëإ߿�X��Ƨ�
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
    
    % �إߤl��Ƨ�
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

        % �]�w�Ѽ�
        scale = 1.0;  % �i�ھڻݭn�վ���
        Use_preprocess = true;

        % �p��`�׹ϩM�k�V�q
        [depth, mask] = calcDepthAndNormal(vertex, scale, Use_preprocess);
        normal = calcNormal(depth);

        % �վ�j�p
        depth = imresize(depth, [img_size img_size]);
        normal = imresize(normal, [img_size img_size]);

        % �g�J��X�Ϲ�
        imwrite(uint8(depth), [depth_outdir '\' secsubdirs(i).name(1:end-4) '_depth.png']);
        imwrite(uint8(normal), [normal_outdir '\' secsubdirs(i).name(1:end-4) '_normal.png']);
    end
    disp(['convert complete for ', subdirs(k).name, ' ...']);
end

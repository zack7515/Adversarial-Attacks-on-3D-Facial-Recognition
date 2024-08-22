type='_ShapeVariation';
img_size=256;

% 資料路徑
% input_dir={'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\Fall2003range_abs2xyz'};
input_dir={'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\Fall2003range_abs2xyz',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\Spring2003range_abs2xyz',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\Spring2004range_abs2xyz'};
depth_output_dir={'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Depth\Fall2003range',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Depth\Spring2003range',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Depth\Spring2004range'};
normal_output_dir={'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Normal\Fall2003range',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Normal\Spring2003range',...
    'E:\3D_dataset\FRGC\FRGC-2.0-dist\nd1\0908newData\Normal\Spring2004range'};

for m=1:length(input_dir)
    input_root=input_dir{m};
    depth_outdir=depth_output_dir{m};
    normal_outdir=normal_output_dir{m};
    disp(input_root);
    %    建立資料夾
    if ~exist([depth_outdir])
        mkdir([depth_outdir]);
    end
    if ~exist([normal_outdir])
        mkdir([normal_outdir]);
    end
    subdirs=dir(input_root);
    %     讀取檔案並寫檔
    parfor i=3:length(subdirs)
        fin_name= [input_root '\' subdirs(i).name];
        % 使用 dlmread 函式讀取.xyz檔案，指定delimiter為空格
        face_vertex = dlmread(fin_name, ' ');
        if size(vertex,2)<2000
            continue;
        end
        [depth,mask]=calcDepthAndNormal(vertex,1.0,true);
        if size(depth,1)<50
            continue;
        end
        depth_source=normalizeValue(depth);%imshow(uint8(depth));
        depth_source=normalizeSize(depth_source);
        normal_source=calcNormal(depth_source);%imshow(uint8(normal));
        depth_source=imresize(depth_source,[img_size img_size]);
        normal_source=imresize(normal_source,[img_size img_size]);
        
        [ depth_noise,normal_noise ] = noise( depth,mask,'gaussian',0,0.00002 );
        depth_noise=imresize(depth_noise,[img_size img_size]);
        normal_noise=imresize(normal_noise,[img_size img_size]);
        imwrite(uint8(depth_noise),[depth_outdir '\'  subdirs(i).name(1:end-4) ,'_noise.png']);
        imwrite(uint8(normal_noise),[normal_outdir '\'  subdirs(i).name(1:end-4) ,'_noise.png']);
        
        %     坫苤醱窒⑹郖
        scale=1.1;
        [depth_shrink,normal_shrink]=shrink(depth,mask,scale);
        depth_shrink=imresize(depth_shrink,[img_size img_size]);
        normal_shrink=imresize(normal_shrink,[img_size img_size]);
        imwrite(uint8(depth_noise),[depth_outdir '\'  subdirs(i).name(1:end-4) ,'_shrink.png']);
        imwrite(uint8(normal_noise),[normal_outdir '\'  subdirs(i).name(1:end-4) ,'_shrink.png']);
        
        disp([depth_outdir '\'  subdirs(i).name(1:end-4) ,'_noise.png']);
        disp([normal_outdir '\'  subdirs(i).name(1:end-4) ,'_shrink.png']);
    end
    disp('convert complete...')
end




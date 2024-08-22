type='_PoseVariation';
degree=15;
degree_1=30;
degree_2=40;
rotation=[[0,0,0];
          [0,degree/180*pi,0];[0,-degree/180*pi,0];
          [degree/180*pi,0,0];[-degree/180*pi,0,0];
          [0,degree_1/180*pi,0];
          [0,-degree_1/180*pi,0];
          [0,degree_2/180*pi,0];
          [0,-degree_2/180*pi,0]];
rotation_type={'nu',...
    'yaw=15','yaw=-15','pitch=15','pitch=-15',...
    'yaw=30','yaw=-30',...
    'yaw=40','yaw=-40',};
img_size=256;

% 資料路徑
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
    for i=3:length(subdirs)
        fin_name= [input_root '\' subdirs(i).name];
        % 使用 dlmread 函式讀取.xyz檔案，指定delimiter為空格
        face_vertex = dlmread(fin_name, ' ');
        parfor r_i =1:size(rotation,1)
            vertex=(face_vertex* RotationMatrix(rotation(r_i,1), rotation(r_i,2), rotation(r_i,3)))';
            [depth,mask]=calcDepthAndNormal(vertex,1.0,true);
            if size(depth,1)<50
                continue;
            end
            depth=normalizeValue(depth);%imshow(uint8(depth));
            depth=normalizeSize(depth);
            mask=normalizeSize(mask);
            normal=calcNormal(depth);%imshow(uint8(normal));
                
            depth=imresize(depth,[img_size img_size]);
            normal=imresize(normal,[img_size img_size]);
            disp([depth_outdir '\'  subdirs(i).name(1:end-4) ['_' rotation_type{r_i}] '.png']);
            imwrite(uint8(depth),[depth_outdir '\'  subdirs(i).name(1:end-4) ['_' rotation_type{r_i}] '.png']);
            imwrite(uint8(normal),[normal_outdir '\'  subdirs(i).name(1:end-4) ['_' rotation_type{r_i}] '.png']);
%             imwrite(uint8(depth),[depth_outdir variation '\' persondirs(j).name '\' strrep(objlist(k).name,'.obj' ,['_' rotation_type{r_i}]) '.jpg']);
%             imwrite(uint8(normal),[normal_outdir variation '\' persondirs(j).name '\' strrep(objlist(k).name,'.obj' ,['_' rotation_type{r_i}]) '.jpg']);
        end
    end
    disp('convert complete...')
end



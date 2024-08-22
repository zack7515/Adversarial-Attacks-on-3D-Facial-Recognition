function [ normal ] = calcNormal( depth )
    [u,v,w]=surfnorm(depth); 
    normal_x=uint8((u+1)*128-1);
    normal_y=uint8((v+1)*128-1);
    normal_z=uint8((w+1)*128-1);
    normal=uint8(zeros([size(depth,1) size(depth,2) 3]));
    normal(:,:,1)=normal_x;normal(:,:,2)=normal_y;normal(:,:,3)=normal_z;
end
% function [ normal ] = calcNormal( depth )
%     [u,v,w] = surfnorm(depth);  % 使用surfnorm函數計算法線的三個分量（u、v、w）
%     
%     % 將法線分量映射到範圍 [0, 255]
%     normal_x = uint8((u + 1) * 128 - 1);
%     normal_y = uint8((v + 1) * 128 - 1);
%     normal_z = uint8((w + 1) * 128 - 1);
%     
%     % 創建一個3通道的法線貼圖
%     normal = uint8(zeros([size(depth, 1), size(depth, 2), 3]));
%     normal(:, :, 1) = normal_x;
%     normal(:, :, 2) = normal_y;
%     normal(:, :, 3) = normal_z;
% end


function [ normal ] = calcNormal( depth )
    [u,v,w]=surfnorm(depth); 
    normal_x=uint8((u+1)*128-1);
    normal_y=uint8((v+1)*128-1);
    normal_z=uint8((w+1)*128-1);
    normal=uint8(zeros([size(depth,1) size(depth,2) 3]));
    normal(:,:,1)=normal_x;normal(:,:,2)=normal_y;normal(:,:,3)=normal_z;
end
% function [ normal ] = calcNormal( depth )
%     [u,v,w] = surfnorm(depth);  % �ϥ�surfnorm��ƭp��k�u���T�Ӥ��q�]u�Bv�Bw�^
%     
%     % �N�k�u���q�M�g��d�� [0, 255]
%     normal_x = uint8((u + 1) * 128 - 1);
%     normal_y = uint8((v + 1) * 128 - 1);
%     normal_z = uint8((w + 1) * 128 - 1);
%     
%     % �Ыؤ@��3�q�D���k�u�K��
%     normal = uint8(zeros([size(depth, 1), size(depth, 2), 3]));
%     normal(:, :, 1) = normal_x;
%     normal(:, :, 2) = normal_y;
%     normal(:, :, 3) = normal_z;
% end


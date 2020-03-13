function num = extract_plate(img,img_D)  
%   extract_plate 用于从原始图像提取车牌并保存  
%   - img 原始图像
%   - img_D 车牌定位后的图像
%   - num 提取车牌数量
    Iprops=regionprops(img_D,'BoundingBox','Area', 'Image');
    count = numel(Iprops);
    a = 0;
    
    for i=1:count
       boundingBox = Iprops(i).BoundingBox;
       im = imcrop(img, boundingBox);
       [h,w,~] = size(im);
       
       %由已有图片可知车牌的大概尺寸，由此可知初次切割的图像包含车牌的数量，依据不同情况进行二次分割重叠车牌
       if (h<300) && (w<600)%只有单张车牌情况
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im,Path);
           
       elseif (300 < h)&&(h < 600)%竖直方向包含两个车牌情况

               Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
               imwrite(im(1:floor(h/2),:,:),Path);
               
               a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
               imwrite(im(floor(h/2):h,:,:),Path);
               
       elseif h >= 600%竖直方向包含三个车牌情况
           
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(1:floor(h/3),:,:),Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(floor(h/3):floor(2*h/3),:,:),Path);
           
           a = a+1;s = 'plates';s = strcat(s, int2str(i+a));s = strcat(s,'.jpg');Path = fullfile('Plate', s);%更新存储路径
           imwrite(im(floor(2*h/3):h,:,:),Path);
           
       elseif (600 < w)&&(w < 1200)%水平方向包含两个车牌情况
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(:,1:floor(w/2),:),Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(:,floor(w/2):w,:),Path);
          
       elseif w>1200 %水平方向包含三个车牌情况
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(:,1:floor(w/3),:), Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%更新存储路径
           imwrite(im(:,floor(w/3):floor(2*w/3),:),Path);
           
           a = a+1;s = 'plates';s = strcat(s, int2str(i+a));s = strcat(s,'.jpg');Path = fullfile('Plate', s);%更新存储路径
           imwrite(im(:,floor(2*w/3):w,:),Path);
       end
    end  
    num = i+a;
    disp(['提取车牌张数:',num2str(i+a)]);
end
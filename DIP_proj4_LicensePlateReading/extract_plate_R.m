function num = extract_plate_R(img,img_D)  
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
       [h,w,l] = size(im);
       
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
    
    % 倾斜矫正
    % 利用hough变换实现车牌图像的倾斜校正
    for n_plates = 1:38
        filePath = ['./Plate/plates', int2str(n_plates),'.jpg'];
        I = imread(filePath);  % read image into workspace
%         figure;
%         subplot(131), imshow(I); 
        I1 = rgb2gray(I);  % 将原始图像转换为灰度图像
        I2 = wiener2(I1, [5, 5]);  % 对灰度图像进行维纳滤波
        I3 = edge(I2, 'canny');  % 边缘检测
%         subplot(132), imshow(I3); 
        [m, n] = size(I3);  % compute the size of the image
        rho = round(sqrt(m^2 + n^2)); % 获取ρ的最大值，此处rho=282
        theta = 180; % 获取θ的最大值
        r = zeros(rho, theta);  % 产生初值为0的计数矩阵
        for i = 1 : m
           for j = 1 : n
              if I3(i,j) == 1  % I3是边缘检测得到的图像
                  for k = 1 : theta
                     ru = round(abs(i*cosd(k) + j*sind(k)));
                     r(ru+1, k) = r(ru+1, k) + 1; % 对矩阵计数 
                  end
              end
           end
        end
        r_max = r(1,1); 
        for i = 1 : rho
           for j = 1 : theta
               if r(i,j) > r_max
                  r_max = r(i,j); 
                  c = j; % 把矩阵元素最大值所对应的列坐标送给c
               end
           end
        end
        if c <= 90
           rot_theta = -c;  % 确定旋转角度
        else
            rot_theta = 180 - c; 
        end
        I4 = imrotate(I1, rot_theta, 'crop');  % 对图像进行旋转，校正图像
%         subplot(133), imshow(I4);
        set(0, 'defaultFigurePosition', [100, 100, 1200, 450]); % 修改图像位置的默认设置
        set(0, 'defaultFigureColor', [1, 1, 1]); % 修改图像背景颜色的设置

        Path = fullfile('Plate_R', strcat('plates',int2str(n_plates), '.jpg'));%更新存储路径
        imwrite(I4, Path);
        
        
    end


    
    
end
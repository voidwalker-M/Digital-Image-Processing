function img_D = detection_plate(img)  
%   detection 用于检测目标图片中车牌位置   
%   - img 输入目标图像
%   - img_D 车牌经过定位处理的图片，用白色填充矩形表示车牌位置 

    % 彩色图像转灰度图
    if ndims(img) == 3
        I = rgb2gray(img);
    else
        I = img;
    end
    
    % 采用中值滤波滤除噪声
    H = medfilt2(I,[3 3]);
%     figure();imshow(H);
    
    %用 canny 算子提取边缘
    H1 = edge(H, 'canny');
%     figure();imshow( H1);
    
    %卷积操作加强边缘
    H1 = double(H1);
    H1 = conv2(H1, [1 1:1 1]);

    %填充孔洞
    gdiff = imfill(H1,'holes');
%     figure();imshow( gdiff);
    
    %形态学开操作链接部分开环轮廓
    se = strel('disk',1);
    gdiff = imclose(gdiff,se);
    gdiff = imfill(gdiff,'holes');
    
    %开操作平滑边缘并去除面积小于8000的部分
    img_D = imopen(gdiff,strel('disk',1));
    img_D = bwareaopen(img_D, 8000);
    
end



function result = preprocessing(img0)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说

%黑白转化
%img0 = 1 - img0;

%zero-padding
K = 4;
[m,n] = size(img0);
img = zeros(m+2*K,n+2*K);
img(K:m+K-1, K:n+K-1) = img0;

%平滑运算
h = fspecial('gaussian');
I=imfilter(img,h);
% figure;
% subplot(1,2,1);imshow(img);
% xlabel('(a)原始图像');
% subplot(1,2,2);imshow(I);
% xlabel('(c)平滑后图像');

%膨胀收缩
B=[0 1 0
   1 1 1
   0 1 0];
% figure;
I=imdilate(I,B);
% subplot(1,3,1),imshow(I);
I=imdilate(I,B);
% subplot(1,3,2),imshow(I);
B1=strel('disk',3);%这里是创建一个半径为3的平坦型圆盘结构元素
I=imerode(I,B1);
% subplot(1,3,3),imshow(I)

% % 细化
% % I=bwmorph(I,'skel',Inf);
% I=bwmorph(I,'thin',Inf);
% % subplot(1,3,3),imshow(I);

result = I(K:m+K-1, K:n+K-1);
% figure;
% imshow(result)


end


function result = preprocessing(img0)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵

%�ڰ�ת��
%img0 = 1 - img0;

%zero-padding
K = 4;
[m,n] = size(img0);
img = zeros(m+2*K,n+2*K);
img(K:m+K-1, K:n+K-1) = img0;

%ƽ������
h = fspecial('gaussian');
I=imfilter(img,h);
% figure;
% subplot(1,2,1);imshow(img);
% xlabel('(a)ԭʼͼ��');
% subplot(1,2,2);imshow(I);
% xlabel('(c)ƽ����ͼ��');

%��������
B=[0 1 0
   1 1 1
   0 1 0];
% figure;
I=imdilate(I,B);
% subplot(1,3,1),imshow(I);
I=imdilate(I,B);
% subplot(1,3,2),imshow(I);
B1=strel('disk',3);%�����Ǵ���һ���뾶Ϊ3��ƽ̹��Բ�̽ṹԪ��
I=imerode(I,B1);
% subplot(1,3,3),imshow(I)

% % ϸ��
% % I=bwmorph(I,'skel',Inf);
% I=bwmorph(I,'thin',Inf);
% % subplot(1,3,3),imshow(I);

result = I(K:m+K-1, K:n+K-1);
% figure;
% imshow(result)


end


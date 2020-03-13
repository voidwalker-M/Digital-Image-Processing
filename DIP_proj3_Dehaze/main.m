% function: haze removel
clc;clear
%% import data 
img = imread('fog2.jpg');
img = imresize(double(img)/255, 0.4);
[h, w, ~] = size(img);

%% parameters 
win_size = 5;   % window size in dark channel
omega = 0.95;   % parameter to control transmission               
r = 4;         % window radius in guided filter
eps = 0.001;    % regularization parameter in guided filter

%% steps to haze removal

% 1.������ͼ��İ�ͨ��
dark_channel = get_dark_channel(img, win_size);
% 2.����ȫ�ִ�����ֵ A
atmosphere = get_atmosphere(img, dark_channel);
% 3.����͸����ͼ t(x)
transmission = get_transmission(img, atmosphere, omega, win_size);
% 4.���õ����˲���ȡ����ϸ��͸����ͼ
transmission_guided = guided_filter(rgb2gray(img), transmission, r, eps);
transmission_guided = reshape(transmission_guided, h, w);
% 5.�ָ�Ϊȥ��ͼ��
radiance = get_radiance(img, transmission_guided, atmosphere);

%% image show
figure;
subplot(2,2,1);imshow(img);title('original image')
subplot(2,2,2);imshow(dark_channel);title('dark channel')
subplot(2,2,3);imshow(transmission_guided);title('transmission after guide filter')
subplot(2,2,4);imshow(radiance);title('processed image (radius=4)')
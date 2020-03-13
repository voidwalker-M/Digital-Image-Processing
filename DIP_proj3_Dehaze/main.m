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

% 1.计算雾化图像的暗通道
dark_channel = get_dark_channel(img, win_size);
% 2.估算全局大气光值 A
atmosphere = get_atmosphere(img, dark_channel);
% 3.估算透射率图 t(x)
transmission = get_transmission(img, atmosphere, omega, win_size);
% 4.利用导向滤波获取更精细的透射率图
transmission_guided = guided_filter(rgb2gray(img), transmission, r, eps);
transmission_guided = reshape(transmission_guided, h, w);
% 5.恢复为去雾图像
radiance = get_radiance(img, transmission_guided, atmosphere);

%% image show
figure;
subplot(2,2,1);imshow(img);title('original image')
subplot(2,2,2);imshow(dark_channel);title('dark channel')
subplot(2,2,3);imshow(transmission_guided);title('transmission after guide filter')
subplot(2,2,4);imshow(radiance);title('processed image (radius=4)')
function atmosphere = get_atmosphere(img, dark_channel)
% function: atmosphere A estimation

% step1: 从暗通道图中按照亮度的大小取前1%的像素
[h, w, ~] = size(img);
num_pixels = h*w;
PERCENT = 0.01;
num_rank_pixels = floor(num_pixels*PERCENT);
dark_channel_vec = reshape(dark_channel, num_pixels, 1);
img_vec = reshape(img, num_pixels, 3);
[~, indices] = sort(dark_channel_vec, 'descend');

% step2: 在这些位置中，在原始有雾图像img中寻找对应的具有最高亮度的点的值，作为A值。
max1 = 0; max2 = 0;max3 = 0;  % max value of channel, channel2, channel3
for i = 1:num_rank_pixels
    if max1 < img_vec(indices(i), 1)
        max1 = img_vec(indices(i), 1);
    end
    if max2 < img_vec(indices(i), 2)
        max2 = img_vec(indices(i), 2);
    end
    if max3 < img_vec(indices(i), 3)
        max3 = img_vec(indices(i), 3);
    end 
end

atmosphere = [max1 max2 max3];

end
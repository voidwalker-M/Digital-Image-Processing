function dark_channel = get_dark_channel(image, win_size)
% function: to get dark channel from haze image.

[h, w, ~] = size(image);
pad_size = floor(win_size/2);
padded_img = padarray(image, [pad_size pad_size], Inf);
dark_channel = zeros(h, w); 

% 计算暗通道：从每个patch的3个RGB channel中选取最小值
for i = 1:h 
    for j = 1:w
        patch = padded_img(i:i+(win_size-1), j:j+(win_size-1),:);
        dark_channel(i,j) = min(patch(:));
     end
end
end
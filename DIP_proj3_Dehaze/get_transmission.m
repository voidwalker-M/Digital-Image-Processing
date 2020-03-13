function transmission = get_transmission(img, atmosphere, omega, win_size)
% function: transmission estimation according by formulation.
% paremeters:
% win_size - window size
% omega - parameter to control transmission 

[h, w, ~] = size(img);
atmosphere_ = reshape(atmosphere, [1, 1, 3]);
atmosphere_ = repmat(atmosphere_, h, w);  %to reproduce and generate h*w*3 matrix, size = [size(A,1)*h, size(A,2)*w, size(A,3)]
transmission = 1 - omega*get_dark_channel(img./atmosphere_, win_size);

end
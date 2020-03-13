function radiance = get_radiance(img, transmission, atmosphere)
% function: haze removal
% parameters:
% image - observed intensity(haze image)
% transmission - transmission maps t(x)
% atmosphere - atmosphere light A

[m, n, ~] = size(img);
atmosphere_ = reshape(atmosphere, [1, 1, 3]);
atmosphere_ = repmat(atmosphere_, m, n);
transmission_ = repmat(max(transmission, 0.1), [1, 1, 3]);
radiance = ((img - atmosphere_)./transmission_) + atmosphere_;

end
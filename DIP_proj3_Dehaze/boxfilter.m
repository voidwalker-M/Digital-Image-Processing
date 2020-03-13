function imgDst = boxfilter(img, r)
% function: boxfilter
[h, w, ~] = size(img);
imgDst = zeros(size(img));

imgCum = cumsum(img, 1);
imgDst(1:r+1,:) = imgCum(1+r:2*r+1,:);  %考虑首部的h个像素
imgDst(r+2:h-r,:) = imgCum(2*r+2:h,:) - imgCum(1:h-2*r-1, :);  %考虑中间像素
imgDst(h-r+1:h,:) = repmat(imgCum(h,:),[r, 1]) - imgCum(h-2*r:h-r-1,:);  %考虑尾部h个像素

imgCum = cumsum(imgDst,2);
imgDst(:,1:r+1) = imgCum(:,1+r:2*r+1);  %考虑首部的像素
imgDst(:,r+2:w-r) = imgCum(:,2*r+2:w) - imgCum(:,1:w-2*r-1);  %考虑中间像素
imgDst(:,w-r+1:w) = repmat(imgCum(:,w), [1,r]) - imgCum(:,w-2*r:w-r-1);   %考虑尾部像素

end


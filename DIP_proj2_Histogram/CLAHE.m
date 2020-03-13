function result = CLAHE(img,W,T)
% CLAHE - Contrast Limited Adaptive histgram equalization
% img: input image
% W: window size W*W
% T: histogram threshold
% result: output image
%%
% TO DO 
% zero padding
[height, width] = size(img);
padRow = W - mod(height,W);
padCol = W - mod(width,W);
padRowPre  = floor(padRow/2); % 负无穷取整
padRowPost = ceil(padRow/2);  % 正无穷取整
padColPre  = floor(padCol/2);
padColPost = ceil(padCol/2);
padSrc = padarray(img,[padRowPre padColPre ],'symmetric','pre');
padSrc = padarray(padSrc,[padRowPost padColPost],'symmetric','post');
[heightPad,widthPad] = size(padSrc);

% 图像分块，对每块直方图均衡化
numTiles(1) = heightPad/W;      %求分割块数 行数
numTiles(2) = widthPad/W;       %求分割块数 列数
tileMappings = cell(numTiles);  %求分块后每个块的CDF
imgCol = 1;
for col = 1:numTiles(2)
   imgRow = 1;
   for row = 1:numTiles(1)
       tile = padSrc(imgRow:imgRow+W-1,imgCol:imgCol+W-1);
       tileHist = getclipHist(tile,T);       %直方图裁剪
       tileMapping = pixel_map(tileHist,W);  %求每块对应的CDF
       tileMappings{row,col} = tileMapping;
       imgRow = imgRow + W; 
   end
   imgCol = imgCol + W;
end

result = BilIterp(img, tileMappings, W);

% END OF YOUR CODE 
end

% You can write other functions here and comment them:
%%

function clipHist = getclipHist(img, T)
% T:threshold
% img:image
    GRAY_LENGTH = 256;
    
    % 获取直方图，计算超出部分
    hist = GetHist(img);
    over = 0;
    for i = 1:GRAY_LENGTH
        if hist(i,1) > T
            over = over + (hist(i,1) - T);
        end
    end
    avgIncrease = floor(over/GRAY_LENGTH);

    % 裁剪并分配
    clipHist = hist;
    for i = 1:GRAY_LENGTH
        if hist(i) > T                      % hist(i) > T,直接赋值T
            clipHist(i) = T;    
        elseif hist(i) + avgIncrease > T    % hist(i) + avgIncrease > T,赋值为T,over里面减去hist增加的值。
            clipHist(i) = T;
            over = over - (hist(i,1) + avgIncrease - T);
        else                                % hist(i) + avgIncrease < T, 赋值为hist + avgIncrease
            clipHist(i) = hist(i) + avgIncrease;
            over = over - avgIncrease;      % over里面减去hist增加的值,即avgIncrease
        end
    end

    % 再次分配
    while(over > 0)
        for i = 1:GRAY_LENGTH
            if clipHist(i) + 1 <= T && over > 0
                clipHist(i) = clipHist(i) + 1;
                over = over - 1;
            end
        end
    end
end

function newPixelVal = pixel_map(hist,W)  %求映射函数
    GRAY_LENGTH = 256;
    prob = hist / (W * W);
    accum = zeros(GRAY_LENGTH,1);
    accum(1,1)=prob(1,1);
    for i = 2:GRAY_LENGTH
        accum(i,1) = accum(i-1,1) + prob(i,1);
    end
    
    newPixelVal = floor(accum * (GRAY_LENGTH-1));
end
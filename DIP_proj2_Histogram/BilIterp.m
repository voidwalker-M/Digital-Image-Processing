function result = BilIterp(img, tileMappings, W)
% interp - Bilinear interpolation
% img: input image
% result: output image
%% 
% TO DO 

% zero padding
[height, width] = size(img);
padRow = W - mod(height,W);
padCol = W - mod(width,W);
padRowPre  = floor(padRow/2);   % 负无穷取整
padRowPost = ceil(padRow/2);    % 正无穷取整
padColPre  = floor(padCol/2);
padColPost = ceil(padCol/2);
padSrc = padarray(img,[padRowPre padColPre ],'symmetric','pre');
padSrc = padarray(padSrc,[padRowPost padColPost],'symmetric','post');
[heightPad,widthPad] = size(padSrc);
numTiles(1) = heightPad/W;      % 求分割块数 行数
numTiles(2) = widthPad/W;       % 求分割块数 列数

resultImg = img;
resultImg(:) = 0;

% 对每个Tile求映射
pixelTileRow = 1;
for i=1:numTiles(1) + 1
    if i == 1                   % 第一行，窗口大小为W/2
        imgTileHeight = W/2; 
        mapTileRows = [1 1];
    elseif i == numTiles(1)+1   % 最后一行，窗口大小为W/2
        imgTileHeight = W/2;
        mapTileRows = [numTiles(1) numTiles(1)];
    else                        % 其他情况，窗口大小为W
        imgTileHeight = W; 
        mapTileRows = [i-1, i]; 
    end

    pixelTileCol = 1;
    for j=1:numTiles(2) + 1
        if j == 1                   % 第一列，窗口大小为W/2
            imgTileWidth = W/2;
            mapTileCols = [1, 1];
        elseif j == numTiles(2)+1   % 最后一列，窗口大小为W/2
            imgTileWidth = W/2;
            mapTileCols = [numTiles(2), numTiles(2)];
        else                        % 其他情况，窗口大小为W
            imgTileWidth = W;
            mapTileCols = [j-1, j]; 
        end
       
        ulMapTile = tileMappings{mapTileRows(1), mapTileCols(1)}; %获取对应CDF
        urMapTile = tileMappings{mapTileRows(1), mapTileCols(2)};
        blMapTile = tileMappings{mapTileRows(2), mapTileCols(1)};
        brMapTile = tileMappings{mapTileRows(2), mapTileCols(2)};
        
        normFactor = imgTileHeight * imgTileWidth; 
        subImage = padSrc(pixelTileRow:pixelTileRow+imgTileHeight-1,pixelTileCol:pixelTileCol+imgTileWidth-1);
        sImage = uint8(zeros(size(subImage)));
        for m = 0:imgTileWidth-1                % x
            inverseI = imgTileWidth - m;        % 1-x
            for n = 0:imgTileHeight-1           % y
                inverseJ = imgTileHeight - n;   % 1-y
                val = subImage(n+1,m+1);
                sImage(n+1, m+1) = (inverseJ*(inverseI*ulMapTile(val+1)+m*urMapTile(val+1))+...
                n*(inverseI*blMapTile(val+1)+m*brMapTile(val+1)))/normFactor;
            end
        end
        resultImg(pixelTileRow:pixelTileRow+imgTileHeight-1,pixelTileCol:pixelTileCol+imgTileWidth-1) = sImage;
        pixelTileCol = pixelTileCol + imgTileWidth;
    end
    pixelTileRow = pixelTileRow + imgTileHeight;
end
result = resultImg(padRowPre:padRowPre+height-1,padColPre:padColPre+width-1);


% end of your code 
end


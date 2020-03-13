function result = AHE(img,W,S)
% AHE - Adaptive histgram equalization
% W : window size W*W
% S : stride 
% result: output image
%% AHE
% % TO DO 

% zero-padding
padSize = W/2;
padSrc = padarray(img,[padSize,padSize],'symmetric','both');
[height,width]=size(padSrc);
result = zeros(height,width);

for i=1:S:height-W+1
    for j=1:S:width-W+1
        kernel = zeros(W,W);  
        kernel = padSrc(i:i+W-1,j:j+W-1); % 对窗赋值
        kernelHE = HE(kernel);            % 对窗进行直方图均衡化
        result(i+(W-S)/2-1:i+(W+S)/2-1,j+(W-S)/2-1:j+(W+S)/2-1) = kernelHE((W-S)/2:(W+S)/2,(W-S)/2:(W+S)/2); % 对影响区域赋值。影响区域大小：S*S
    end
end

result = uint8(result(padSize:height-padSize-1,padSize:width-padSize-1)); % 裁剪

% END OF YOUR CODE 
end

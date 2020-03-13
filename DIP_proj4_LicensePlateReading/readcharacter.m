function letters = readcharacter(chars,plate,a)
%  用于读取字符含义
%  chars：经detection_character获得字符位置
%  plate:车牌
%  letters:字符实际含义

numChars = size(chars,1);
if ndims(plate) == 3
    I = rgb2gray(plate);
else
    I = plate;
end

% 将背景置零

b = 1:max(max(I));
[~, max_index] = max(histc(plate,b));
max_element = b(max_index);
r = size(plate, 1);
c = size(plate, 2);
for i = 1:r
    for j= 1:c
        if plate(i,j)==max_element
            plate(i,j)= 0;
        end
    end
end



% 将车牌转化为二值图像
level=graythresh(plate);
bwPlate = im2bw(plate,level);

%将车牌转换二值图像时有时会字符置0，背景置1
% 为保证字符置1，背景为0，作如下判断
r = size(plate, 1);
c = size(plate, 2);
whitePix=0;
for i = 1:r
    for j= 1:c
        if bwPlate(i,j)==1
            whitePix=whitePix+1;
        end
    end
end

whiteRate=whitePix/(r*c);

if whiteRate > 0.5 
    bwPlate = ~bwPlate;
end

% 制作模板
mySet0 = creaSet();
r_pic=size(mySet0, 1);
c_pic=size(mySet0, 2);
mySet = zeros(r_pic,c_pic,36);

for k = 1:36
    level=graythresh(mySet0(:,:,k));
    mySet0(:,:,k) = im2bw(mySet0(:,:,k),level);
    mySet(:,:,k) = preprocessing(mySet0(:,:,k));
end

dictionary=['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',...
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',...
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',...
            'U', 'V', 'W', 'X', 'Y', 'Z'];
        
% 从字符中提取车牌并与模板比较相似度
letters = [];
for i = 1:numChars
    myChar=imcrop(bwPlate, chars(i,:));   
    % 改变myChar尺寸使其与mySet一致
    myChar = imresize(myChar,[r_pic,c_pic]);
    
    %pre-processing
    myChar = preprocessing(myChar);
    Path = fullfile('Character/',int2str(a), strcat('character', int2str(i),'.jpg'));%更新存储路径
    imwrite(myChar, Path);
    %compare
    minIndex = compare2set(myChar, mySet);
    letter = dictionary(minIndex);
    letters = [letters letter];
end

end

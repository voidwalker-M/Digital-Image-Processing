function letters = readcharacter(chars,plate,a)
%  ���ڶ�ȡ�ַ�����
%  chars����detection_character����ַ�λ��
%  plate:����
%  letters:�ַ�ʵ�ʺ���

numChars = size(chars,1);
if ndims(plate) == 3
    I = rgb2gray(plate);
else
    I = plate;
end

% ����������

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



% ������ת��Ϊ��ֵͼ��
level=graythresh(plate);
bwPlate = im2bw(plate,level);

%������ת����ֵͼ��ʱ��ʱ���ַ���0��������1
% Ϊ��֤�ַ���1������Ϊ0���������ж�
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

% ����ģ��
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
        
% ���ַ�����ȡ���Ʋ���ģ��Ƚ����ƶ�
letters = [];
for i = 1:numChars
    myChar=imcrop(bwPlate, chars(i,:));   
    % �ı�myChar�ߴ�ʹ����mySetһ��
    myChar = imresize(myChar,[r_pic,c_pic]);
    
    %pre-processing
    myChar = preprocessing(myChar);
    Path = fullfile('Character/',int2str(a), strcat('character', int2str(i),'.jpg'));%���´洢·��
    imwrite(myChar, Path);
    %compare
    minIndex = compare2set(myChar, mySet);
    letter = dictionary(minIndex);
    letters = [letters letter];
end

end

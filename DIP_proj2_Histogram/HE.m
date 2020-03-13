function result = HE(img)
% HE - histogram equalization
% img: input image
% result: output image
%%
% TO DO 
GRAY_LENGTH = 256;
[height, width] = size(img);
count = double(GetHist(img));
T = double(zeros(GRAY_LENGTH,1));
result = double(img);

% $s=T(r)=(L-1)\sum_{j=0}^{k}p_r(r_j)$
% ����ÿ�����س��ֵĸ���p,��$p_r(r_j)$
for i = 1 : GRAY_LENGTH
    T(i, 1) = count(i, 1) / (height * width);
end
% ����CDF,��$sum_{j=0}^{k}p_r(r_j)$
for i = 2 : GRAY_LENGTH
    T(i, 1) = T(i-1, 1) + T(i, 1);
end
% ����s=T(r)=(L-1)*CDF
for i = 1 : GRAY_LENGTH
    T(i, 1) = T(i, 1) * (GRAY_LENGTH - 1);
end
% ʹ��ӳ�亯��
for i = 1 : height
    for j = 1 : width
        result(i, j) = T(result(i, j) + 1,1); %result��0��ʼ��T��1��ʼ
    end
end

result = uint8(result);

% END OF YOUR CODE 
end

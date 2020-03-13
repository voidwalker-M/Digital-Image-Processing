clc;clear all;close all;
% main.m

% %% load data
img = imread('License_plates.jpg');
%  
% %% License Plate Detection
img_DP = detection_plate(img);
% figure();imshow(img_DP);title("��λ��ͼ��");
% % ���ݶ�λ��ͼ���ԭͼ����ȡ���Ʋ�������Plate�ļ����²�������ȡ��������
% % num = extract_plate(img,img_DP);
num = extract_plate_R(img,img_DP);%��ȡ�����н�������б����

%% �ַ���ȡ
sumCorrRate = double(0);
labels = {'381Z';'32701';'*';'56DYG';'28VFB';'23RA5';'7YN089';'J11277';'839VGA';'771746';
    'UMM579';'J11137';'AJ4382';'DDU478';'391377';'IX2585';'X243499';'AMP299';'922RIE';
    '8KHD70';'RZJ80D';'5NNY092';'5ZJC907';'HP3192';'OLR472';'SXN9714';'A32383';'B49SNN';
    '4XDWW';'AIE982';'4HFX108';'Z27925';'B588779';'539X';'5CE';'143';'5FD';'K42'};

for i = 1:num  %����ȡ��38�ų���(������һ���ǿյģ�plates3)
    image = ['plates',num2str(i),'.jpg'];
    way = 'Plate_R/';

    plate = imread ([way image]);
    chars = detection_character(plate);
    if chars==0
        disp(['Plate ',num2str(i),' is invalid']);
    else
        letters = readcharacter(chars,plate,i);
        % ����׼ȷ��
        label = labels{i};
        numChar = size(letters);
        numChar = numChar(2);
        numLabelChar = size(label);
        n = double(0);
        for u = 1:numChar
            for v = 1:numLabelChar(2)
                if(letters(u) == label(v))
                    n = n + 1;
                    label(v) = '#'; %��ǳ��ò������ַ�����ֹ����
                    break;
                end
            end
        end
        corrRate = n/double(numLabelChar(2));
        sumCorrRate = sumCorrRate + corrRate;
        disp(['Plate ',num2str(i),': Result:',letters, '   Label:',labels{i},'   CorrRate:',num2str(corrRate)]);
    end 
end

corrRate = sumCorrRate/(num-1) * 100; %��һ���ǿյ�,plates3����num-1
disp(['Correct Rate = ',num2str(corrRate),'%']);







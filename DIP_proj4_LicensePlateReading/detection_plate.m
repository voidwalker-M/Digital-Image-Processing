function img_D = detection_plate(img)  
%   detection ���ڼ��Ŀ��ͼƬ�г���λ��   
%   - img ����Ŀ��ͼ��
%   - img_D ���ƾ�����λ�����ͼƬ���ð�ɫ�����α�ʾ����λ�� 

    % ��ɫͼ��ת�Ҷ�ͼ
    if ndims(img) == 3
        I = rgb2gray(img);
    else
        I = img;
    end
    
    % ������ֵ�˲��˳�����
    H = medfilt2(I,[3 3]);
%     figure();imshow(H);
    
    %�� canny ������ȡ��Ե
    H1 = edge(H, 'canny');
%     figure();imshow( H1);
    
    %���������ǿ��Ե
    H1 = double(H1);
    H1 = conv2(H1, [1 1:1 1]);

    %���׶�
    gdiff = imfill(H1,'holes');
%     figure();imshow( gdiff);
    
    %��̬ѧ���������Ӳ��ֿ�������
    se = strel('disk',1);
    gdiff = imclose(gdiff,se);
    gdiff = imfill(gdiff,'holes');
    
    %������ƽ����Ե��ȥ�����С��8000�Ĳ���
    img_D = imopen(gdiff,strel('disk',1));
    img_D = bwareaopen(img_D, 8000);
    
end



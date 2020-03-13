function num = extract_plate(img,img_D)  
%   extract_plate ���ڴ�ԭʼͼ����ȡ���Ʋ�����  
%   - img ԭʼͼ��
%   - img_D ���ƶ�λ���ͼ��
%   - num ��ȡ��������
    Iprops=regionprops(img_D,'BoundingBox','Area', 'Image');
    count = numel(Iprops);
    a = 0;
    
    for i=1:count
       boundingBox = Iprops(i).BoundingBox;
       im = imcrop(img, boundingBox);
       [h,w,~] = size(im);
       
       %������ͼƬ��֪���ƵĴ�ųߴ磬�ɴ˿�֪�����и��ͼ��������Ƶ����������ݲ�ͬ������ж��ηָ��ص�����
       if (h<300) && (w<600)%ֻ�е��ų������
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im,Path);
           
       elseif (300 < h)&&(h < 600)%��ֱ������������������

               Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
               imwrite(im(1:floor(h/2),:,:),Path);
               
               a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
               imwrite(im(floor(h/2):h,:,:),Path);
               
       elseif h >= 600%��ֱ������������������
           
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(1:floor(h/3),:,:),Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(floor(h/3):floor(2*h/3),:,:),Path);
           
           a = a+1;s = 'plates';s = strcat(s, int2str(i+a));s = strcat(s,'.jpg');Path = fullfile('Plate', s);%���´洢·��
           imwrite(im(floor(2*h/3):h,:,:),Path);
           
       elseif (600 < w)&&(w < 1200)%ˮƽ������������������
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(:,1:floor(w/2),:),Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(:,floor(w/2):w,:),Path);
          
       elseif w>1200 %ˮƽ������������������
           Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(:,1:floor(w/3),:), Path);
           
           a = a+1;Path = fullfile('Plate', strcat('plates', int2str(i+a),'.jpg'));%���´洢·��
           imwrite(im(:,floor(w/3):floor(2*w/3),:),Path);
           
           a = a+1;s = 'plates';s = strcat(s, int2str(i+a));s = strcat(s,'.jpg');Path = fullfile('Plate', s);%���´洢·��
           imwrite(im(:,floor(2*w/3):w,:),Path);
       end
    end  
    num = i+a;
    disp(['��ȡ��������:',num2str(i+a)]);
end
function num = extract_plate_R(img,img_D)  
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
       [h,w,l] = size(im);
       
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
    
    % ��б����
    % ����hough�任ʵ�ֳ���ͼ�����бУ��
    for n_plates = 1:38
        filePath = ['./Plate/plates', int2str(n_plates),'.jpg'];
        I = imread(filePath);  % read image into workspace
%         figure;
%         subplot(131), imshow(I); 
        I1 = rgb2gray(I);  % ��ԭʼͼ��ת��Ϊ�Ҷ�ͼ��
        I2 = wiener2(I1, [5, 5]);  % �ԻҶ�ͼ�����ά���˲�
        I3 = edge(I2, 'canny');  % ��Ե���
%         subplot(132), imshow(I3); 
        [m, n] = size(I3);  % compute the size of the image
        rho = round(sqrt(m^2 + n^2)); % ��ȡ�ѵ����ֵ���˴�rho=282
        theta = 180; % ��ȡ�ȵ����ֵ
        r = zeros(rho, theta);  % ������ֵΪ0�ļ�������
        for i = 1 : m
           for j = 1 : n
              if I3(i,j) == 1  % I3�Ǳ�Ե���õ���ͼ��
                  for k = 1 : theta
                     ru = round(abs(i*cosd(k) + j*sind(k)));
                     r(ru+1, k) = r(ru+1, k) + 1; % �Ծ������ 
                  end
              end
           end
        end
        r_max = r(1,1); 
        for i = 1 : rho
           for j = 1 : theta
               if r(i,j) > r_max
                  r_max = r(i,j); 
                  c = j; % �Ѿ���Ԫ�����ֵ����Ӧ���������͸�c
               end
           end
        end
        if c <= 90
           rot_theta = -c;  % ȷ����ת�Ƕ�
        else
            rot_theta = 180 - c; 
        end
        I4 = imrotate(I1, rot_theta, 'crop');  % ��ͼ�������ת��У��ͼ��
%         subplot(133), imshow(I4);
        set(0, 'defaultFigurePosition', [100, 100, 1200, 450]); % �޸�ͼ��λ�õ�Ĭ������
        set(0, 'defaultFigureColor', [1, 1, 1]); % �޸�ͼ�񱳾���ɫ������

        Path = fullfile('Plate_R', strcat('plates',int2str(n_plates), '.jpg'));%���´洢·��
        imwrite(I4, Path);
        
        
    end


    
    
end
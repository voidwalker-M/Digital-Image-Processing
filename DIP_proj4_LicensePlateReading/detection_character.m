function img_DC = detection_character (plate)
%   detection_character ���ڴӳ����м���ַ�λ�ã��Ժ�ɫ���ο��� 
%   - plate ���복��
%   - img_DC �ַ���λ���λ��
    
    % ͼ��Ԥ����
    if ndims(plate) == 3
        I = rgb2gray(plate);
    else
        I = plate;
    end
    
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


    
    level=graythresh(plate);%��ȡ��ֵ  
    th=im2bw(plate,level); %������ֵת��Ϊ��ֵͼ
%     figure(); imshow(th);

    % �˲���ȡ��Ե����
    shapes=imfilter(th, fspecial('laplacian', 0.2), 'replicate');
%     figure(2);imshow(shapes);

    % ����������λ�ַ���������λ����λ�ô洢��"init"��
    carac = regionprops(shapes, 'BoundingBox', 'Image');
    numObj=numel(carac);
    init = carac(1).BoundingBox;
    for k = 2 : numObj
        init = cat(3,init,carac(k).BoundingBox);
    end

    % ����λ����Ϣ��Ӻ�ɫ���α߿�
    %figure();imshow(shapes);
    for i=1:numObj
            rectangle('Position', carac(i).BoundingBox, 'EdgeColor', 'r');
    end

    %ɸѡ�޹��ַ�������ɸѡ��λ����Ϣ�洢��"results"��
    % ɸѡ����:1.Ŀ���ַ���Ϊ���Σ���(��/��<1; 2.Ŀ����ο򲻻�̫С��
    results=0;
    for k = 1 : numObj
        r = size(plate, 1);
        c = size(plate, 2);
        if (( init(1,3,k)/init(1,4,k) ) < 1 && init(1,4,k) > 0.31*r && init(1,4,k) < 0.7*r && init(1,3,k)< 0.18*c)
            results=cat(2,results,k); 
        end
    end
    if (results == 0)
        img_DC = 0;
    else
        numRes = size(results,2);
    %    figure ();imshow(shapes);
        for i=2:numRes
            rectangle('Position', carac(results(i)).BoundingBox, 'EdgeColor', 'r');
        end
        % ����ɸѡ���λ����Ϣ���¼ӿ�
        sameCarac=zeros(1,numObj);
        for i=2:numRes
            aireMax=init(1,4,results(i))+10;
            aireMin=init(1,4,results(i))-10;
            for j=2:numRes
                if i~=j &&init(1,4,results(j)) < aireMax && init(1,4,results(j)) > aireMin
                    sameCarac(1,i)=sameCarac(1,i)+1;
                end
            end
        end
        biggest=sameCarac(1,2);
        for i=3:numRes % For each area after the first one:
            if biggest < sameCarac(1,i) % Checking if the number is bigger.
                biggest = sameCarac(1,i); % If so the number is the new challenger.
            end
        end
        indexMatch=0;
        for i=1:numRes
            if sameCarac(1,i)==biggest
                indexMatch=cat(2, indexMatch, i);
            end
        end
        
%         disp(indexMatch);
%         disp(results);
%         disp(results(indexMatch(2)));
        if (results(indexMatch(2)) == 0)
            img_DC = 0;
            
        else
            numRes2 = size(indexMatch,2);
   %         figure ();imshow(shapes);
            for i=2:numRes2
%                 disp(results(indexMatch(i)));
                rectangle('Position',carac(results(indexMatch(i))).BoundingBox,'EdgeColor','r');
            end

            img_DC=carac(results(indexMatch(2))).BoundingBox;
            for i=3:numRes2
                img_DC=cat(1,img_DC, carac(results(indexMatch(i))).BoundingBox);
            end
        end
    end
end
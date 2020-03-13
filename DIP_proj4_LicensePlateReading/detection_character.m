function img_DC = detection_character (plate)
%   detection_character 用于从车牌中检测字符位置，以红色矩形框标记 
%   - plate 输入车牌
%   - img_DC 字符定位后的位置
    
    % 图像预处理
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


    
    level=graythresh(plate);%获取阈值  
    th=im2bw(plate,level); %根据阈值转换为二值图
%     figure(); imshow(th);

    % 滤波获取边缘轮廓
    shapes=imfilter(th, fspecial('laplacian', 0.2), 'replicate');
%     figure(2);imshow(shapes);

    % 根据轮廓定位字符，并将定位到的位置存储到"init"中
    carac = regionprops(shapes, 'BoundingBox', 'Image');
    numObj=numel(carac);
    init = carac(1).BoundingBox;
    for k = 2 : numObj
        init = cat(3,init,carac(k).BoundingBox);
    end

    % 根据位置信息添加红色矩形边框
    %figure();imshow(shapes);
    for i=1:numObj
            rectangle('Position', carac(i).BoundingBox, 'EdgeColor', 'r');
    end

    %筛选无关字符，并将筛选后位置信息存储在"results"中
    % 筛选条件:1.目标字符框为矩形，即(长/宽）<1; 2.目标矩形框不会太小；
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
        % 根据筛选后的位置信息重新加框
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
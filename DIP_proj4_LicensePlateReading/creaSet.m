function set = creaSet()
%   creaSet函数用于制作模板集

    % 读取模板图片，并将其存储到"set"中
    set = imresize(imread('set/0.jpg'),[62,40]);
    set = cat(3,set,imresize(imread('set/1.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/2.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/3.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/4.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/5.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/6.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/7.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/8.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/9.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/A.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/B.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/C.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/D.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/E.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/F.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/G.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/H.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/I.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/J.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/K.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/L.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/M.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/N.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/O.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/P.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/Q.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/R.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/S.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/T.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/U.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/V.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/W.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/X.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/Y.jpg'),[62,40]));
    set = cat(3,set,imresize(imread('set/Z.jpg'),[62,40]));

    % 将图片转化为二值图像
%     level=graythresh(set(:,:,1)); % 所有图片具有相同阈值
%     for i = 1:36
%         set(:,:,i) = im2bw(set(:,:,i), level);
%     end
        
end
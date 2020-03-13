function count=GetHist(img)
% GetHist - get the image histogram
% img:input image
% count:count the number of grayscale
%%
count = zeros(256,1);
% TO DO 

[height, width] = size(img);
for i = 1:height  
    for j = 1:width
        count(img(i,j)+1, 1) = count(img(i,j)+1, 1) + 1;
    end
end
% 
% figure;
% x = linspace(1,256,256)
% bar(x,count)
% END OF YOUR CODE 
end
function index = compare2set(myChar, mySet)
%  用于比较提取字符与模板相似程度
%  myChar:输入提取字符
%  mySet: 模板
%  注：以下可使用不同的方法：取消掉注释即可。


%% 判断距离
MAXNUM = 100000;
[H,W] = size(myChar);
Diff = 0;
minDiff = MAXNUM;
index = 1;
v1 = myChar(:)';
for k = 1:36
    tmp = mySet(:,:,k);
    v2 = tmp(:)';
    v = [v1; v2];
    Diff = pdist(v,'euclidean'); % 60.2831%
   % Diff = pdist(v,'cityblock'); % 58.9318%
   % Diff = pdist(v, 'chebychev'); % 14.9%
   % Diff = pdist(v,'seuclidean',[0.5,1]) %bug
   % Diff = pdist(v,'mahalanobis'); %bug
   % Diff = 1 - pdist(v,'cosine'); % 5.8172%
   % Diff = pdist(v,'hamming');  % 57.7091%
   % Diff = pdist(v,'jaccard');  % 52.22%
   % C = corrcoef(v');   %将返回相关系数矩阵
   % Diff = pdist(v, 'correlation'); 59.897%
    if minDiff > Diff
        minDiff = Diff;
        index = k;
    end
end



%% Radon变换  
% % 58.6808%
% Diff = zeros(36,1);
% for theta=0:180
%     charR = radon(myChar, theta);
%     for n = 1:36
%         maskR = radon(mySet(:,:,n), theta);
%         sum(abs(charR-maskR));
%         K = size(charR,1);
%         Diff_ = 0;
%         for k = 1:K
%             Diff_ = Diff_ + (charR(k)-maskR(k))*(charR(k)-maskR(k));
%         end
%         Diff(n,1) = Diff(n,1) + Diff_;
%     end
% end
% Diff = Diff / 10000000;
% minDiff = 1000000;
% index = 1;
% for n = 1:36
%    if minDiff > Diff(n)
%       minDiff = Diff(n);
%       index = n;
%    end
% end



end
   
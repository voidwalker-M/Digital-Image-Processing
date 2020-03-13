close all;clc;clear;
%% read
origin = imread('astronaut.jpg');
figure(1);subplot(221);imshow(origin);title('origin');
% histogram equalization
% TO DO

img_1(:,:,1) = HE(origin(:,:,1));
img_1(:,:,2) = HE(origin(:,:,2));
img_1(:,:,3) = HE(origin(:,:,3));

% END OF YOUR CODE
subplot(222);imshow(img_1);title('HE');

% %% Adaptive histgram equalization
% % TO DO

img_2(:,:,1) = AHE(origin(:,:,1),128,8);
img_2(:,:,2) = AHE(origin(:,:,2),128,8);
img_2(:,:,3) = AHE(origin(:,:,3),128,8);

% % END OF YOUR CODE
subplot(223);imshow(img_2);title('AHE');
% 
% %% Contrast Limited Adaptive histgram equalization
% TO DO
img_3(:,:,1) = CLAHE(origin(:,:,1),128,200);
img_3(:,:,2) = CLAHE(origin(:,:,2),128,200);
img_3(:,:,3) = CLAHE(origin(:,:,3),128,200);
% 
% 
% % END OF YOUR CODE
subplot(224);imshow(img_3);title('CLAHE');
% % 
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % % %  rock.jpg  % % % % % % % % % % % % % % % % % % % 
% %% read
origin1 = imread('rock.jpg');
figure(2);subplot(221);imshow(origin1);title('origin');

%% histogram equalization
% TO DO
img_11(:,:,1) = HE(origin1(:,:,1));
img_11(:,:,2) = HE(origin1(:,:,2));
img_11(:,:,3) = HE(origin1(:,:,3));


% END OF YOUR CODE
subplot(222);imshow(img_11);title('HE');

%% Adaptive histgram equalization
% TO DO
img_21(:,:,1) = AHE(origin1(:,:,1),128,64);
img_21(:,:,2) = AHE(origin1(:,:,2),128,64);
img_21(:,:,3) = AHE(origin1(:,:,3),128,64);


% END OF YOUR CODE
subplot(223);imshow(img_21);title('AHE');

% Contrast Limited Adaptive histgram equalization
% TO DO
img_31(:,:,1) = CLAHE(origin1(:,:,1),128,200);
img_31(:,:,2) = CLAHE(origin1(:,:,2),128,200);
img_31(:,:,3) = CLAHE(origin1(:,:,3),128,200);



% END OF YOUR CODE
subplot(224);imshow(img_31);title('CLAHE');
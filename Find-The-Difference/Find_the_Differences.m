system('adb shell screencap -p /sdcard/test.png');

% %  Pulling image to your working directory
system('adb pull /sdcard/test.png');

% % Starts the stopwatch timer
tic

% % Reading pulled image from working directory 
img = imread('test.png');

% % Displaying the image pulled
figure
imshow (img);

L = size(img, 1);
B = size(img, 2);

%% Cropping the two images having differences
upper_crop = imcrop (img, [1 0.1415*L B-1 2*323]);
lower_crop = imcrop (img, [1 0.545*L B-1 2*323]);
figure
imshow(upper_crop);

figure
imshow(lower_crop);

%%
% % Subtracting the two images
img_diff = lower_crop-upper_crop;

figure
imshow(img_diff)
abs_img_diff = abs(img_diff);
figure
imshow(abs_img_diff)
% % Extracting R G B components of the image
R=img_diff(:,:,1);
G=img_diff(:,:,2);
B=img_diff(:,:,3);

% % Converting the three-layered image to a binary image
bin_img = img_diff(:,:,1)>=15 & img_diff(:,:,2)>=15 & img_diff(:,:,3)>=15;
imshow (bin_img);

final_img = bin_img;

imshow(final_img);
% % In bin_img, the regions obtained are discrete. To make it solid,
% the whole matrix is traversed. On finding a white pixel (1), the next 30
% pixels(rows and columns) are made white (1)
for r = 1:323;
    
    % % On finding a white pixel, the next 39 columns are skipped from the
    % iteration process
    k = 0;
    for c = 1:480;
        
    % % On finding a white pixel, the next 39 rows are skipped from the
    % iteration process
      l = 0;
      if bin_img(r,c) == 1 && k <= c
          if c + 17 <= 480
            final_img(r,c : c + 17) = 1;
          else
            final_img(r,c : 480) = 1;
          end
          k = c + 18;
      end
      if bin_img(r,c) == 1 && l <= r
          if r + 17 <= 323
            final_img(r : r + 17,c) = 1;
          else
            final_img(r : 323,c) = 1;
          end
          l = r + 18;
      end
    end
end


% %Now final_img contains solid regions representing the differences
figure

imshow(final_img);

% % Calculating the region properties of the solid regions in final_img
region_img = regionprops (final_img);

% % This returns the number of regions detected
num_region = size (region_img, 1);

% % Obtaining the centroid of each of the regions to be used for tapping 
for i = 1:num_region
    x = region_img(i).Centroid(1);
    
    % % 270 is added to match the coordinate of the cropped image with the
    % original image
    y = region_img(i).Centroid(2) + 143;
    
    % % Generating command to be given for tapping
    system(['adb shell input swipe ' num2str(x) ' ' num2str(y) ' ' num2str(x) ' ' num2str(y) '']);
   
    % % Introducing a time delay of 2 seconds between each tap
    pause(2);
end

% % Removing the scrrenshot saved in sdcard to save space 
system('adb shell rm /sdcard/screen.png');

%%First move based on calculation of centroid of target  and hit and trial
system('adb shell input swipe  364 890 364 590 ');
pause(15);
for(j=1:20)
    
% % Capturing screenshot and saving it to sdcard of the android device
system('adb shell screencap -p /sdcard/screen.png');

% %  Pulling image to your working directory
system('adb pull /sdcard/screen.png');
img = imread('screen.png');
imshow (img);
%% Cropping white color targets
target=imcrop(img,[325,569,390-325,594-569]);
red=target(:,:,1);green=target(:,:,2);blue=target(:,:,3);
white_target=red>177 & green>177 & blue>177 ;

final_img=bwmorph(white_target,'dilate',1);
%% Calculation of centroid
stats=regionprops(final_img,'centroid');
centroids = cat(1, stats.Centroid);
num_of_obj=length(stats);
area_image=regionprops( final_img,'area');
area_matrix=ones(num_of_obj,1);
for i=1:num_of_obj
area_matrix(i,1)=area_image(i).Area;
end
total_area=sum(area_matrix,2);
cen_tre=(area_matrix*centroids)/total_area;
%% Adjusting centroid due to cropping
midpoint=centroids+[325,569];
x=midpoint(1,1)
y=midpoint(1,2);


if(num_of_obj<7 & x<355)
system('adb shell input swipe  364 890 342 890 ');
pause(2);

system('adb shell input swipe  342 890 342 590');
pause(15);
end
if(num_of_obj<7 & x>365)
system('adb shell input swipe  364 890 379 890 ');
pause(2);
system('adb shell input swipe 379 890 379 590 ');
pause(15);
end
if(x>=355 & x<=365)

system('adb shell input swipe  364 890 364 590 ');
pause(15);
end
end


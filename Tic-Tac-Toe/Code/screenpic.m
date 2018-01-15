function [a,j] = screenpic (a,i)

%% Takes the screenshot
system('adb shell screencap -p /sdcard/screen.png');

%% Pulls it to the working system
system('adb pull /sdcard/screen.png');

%% Reads it to a variable
im=imread('screen.png');

%% Store the pixel values of the red layer of the9 points in the 9 boxes ...
%% where we differentiate the appearance of red circle
 a(i,1)=im(867,46,1);
 a(i,2)=im(863,407,1);
 a(i,3)=im(871,771,1);
 a(i,4)=im(1223,46,1);
 a(i,5)=im(1227,411,1);
 a(i,6)=im(1223,771,1);
 a(i,7)=im(1587,42,1);
 a(i,8)=im(1591,407,1);
 a(i,9)=im(1591,767,1);
 
 %% Check in which box the circle appeared by comparing the red pixels of ...
 %% the 9 points of the present and the previous screenshots
for j=1:9
    if (a(i,j)~=a(i-1,j))
    	break;
    end
end
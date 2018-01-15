tempo=1;
while tempo < 50  
       
    system('adb shell screencap -p /sdcard/screenshot.png');
    system('adb pull /sdcard/screenshot.png'); 
  
    k=imread('screenshot.png');
    temp=0;
    [r,c,d]=size(k);
    if(k(1200,150,1)<180 || k(1200,150,2)<180 || k(1200,150,3)<180)
        temp=1;
    elseif (k(1200,400,1)<180 || k(1200,400,2)<180 || k(1200,400,3)<180)
        temp=2;
    elseif (k(1200,650,1)<180 || k(1200,650,2)<180 || k(1200,650,3)<180)
        temp=3;
    else
        temp=4;
    end
    %imshow(k);
    temp
    %pp=impixelinfo;
    if(temp==1)
        system('adb shell input touchscreen swipe 140 1236 140 1236 1');
    elseif(temp==2)
        system('adb shell input touchscreen swipe 400 1236 400 1236 1');
    elseif(temp==3)
        system('adb shell input touchscreen swipe 670 1236 670 1236 1');
    else
        system('adb shell input touchscreen swipe 950 1236 950 1236 1');
    end
    pause(0.01);
    tempo=tempo+1;
end
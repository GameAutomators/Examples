temp=1;
while temp < 50  
       
     system('adb shell screencap -p /sdcard/lol.png');
     system('adb pull /sdcard/lol.png'); 
    k=imread('lol.png');
    [r,c,h]=size(k);
    for i=1:2:r
        for j=167:2:c
            if (k(i,j,1)>150 & k(i,j,2)<30 & k(i,j,3)<30)
                break;
            end
        end
        if (k(i,j,1)>150 & k(i,j,2)<30 & k(i,j,3)<30)
                break;
        end
    end
    degree=atand((1383-i)/(j-195));
    degree
    time=(1005*degree)/90;
    time=floor(time);
    cnd=sprintf('adb shell input touchscreen swipe 500 500 500 500 %d', time);
  system(cnd);
  %system('adb shell rm');
  pause(4);
  temp=temp+1;
  
end
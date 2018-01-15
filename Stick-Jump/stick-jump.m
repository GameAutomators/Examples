temp=1;
time=300;
while temp < 4
     flag=1;  
     system('adb shell screencap -p /sdcard/lol.png');
     system('adb pull /sdcard/lol.png'); 
    k=imread('lol.png');
    [r,c,h]=size(k);
    for i=10:2:r
        for j=120:2:c
            if (k(i,j,1)>165 & k(i,j,2)<90 & k(i,j,3)<90)
                break;
            end
        end
        if (k(i,j,1)>165 & k(i,j,2)<90 & k(i,j,3)<90)
                break;
        end
    end
    i
    j
    for x=20:2:r
        for y=j+40:2:c
             if(flag==0)
             if (time<200)
                 y=y+100; flag=1;
             end
             end
             if (k(x,y,1)>175 & k(x,y,2)<90 & k(x,y,3)<90)
                break;
            end
        end
        if (k(x,y,1)>175 & k(x,y,2)<90 & k(x,y,3)<90)
                break;
        end
    end
    x
    y
            
    dist=sqrt((x-i)^2+(y-j)^2);
    dist
    time=(dist*1250*1.0)/940;
    time=floor(time);
    time
    cnd=sprintf('adb shell input touchscreen swipe 500 500 500 500 %d', time);
  system(cnd);
%   
  
  
  
  %system('adb shell rm');
  pause(2);
  temp=temp+1;
  
end
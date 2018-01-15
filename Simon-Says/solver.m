system('adb shell screencap -p /sdcard/screen.png');
system('adb pull /sdcard/screen.png');
img = imread('screen.png');
tap = [[180 900]; [300 900]; [412 900]; [536 900]; [650 900]; [187 1000]; [300 1000]; [420 1000]; [538 1000]];
A = [0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0];
for i = 1:9
    for j = 1:9       
        x1 = 22 + 76*i - 76;
        if mod(i,3) == 0
            x1 = x1+4;
        end
        if( i==7)
            x1 = x1+3;
        end
        x2 =65 +  j*76-76;
        x3 = 62;
        x4 = 62;
        if mod(j,3)==0
            x2= x2 + 6; 
        end
        if(j==7)
            x2 = x2+5;
            %display(x2);
        end
        cimg = imcrop(img, [x1 x2 x3 x4]);
        
        a = rgb2gray(cimg);
        results = ocr(a ,'TextLayout','Block');
        rs2 = ocr(a,'TextLayout','Word');
        
        if(isempty(results.Words))
            A(i,j)=0;
        else
            A(i,j) = str2double(results.Words);
        end
        if(8 == str2double(rs2.Words))
            A(i,j) = 8;
        end;
                
        %disp(results);
    end
   
end

%B = transpose(A);
%disp(B);
s='';
for i = 1:9
    for j = 1:9
        s = strcat(s,num2str(A(j,i)));
    end
end
cmd = 'sudoku.exe ';
[status,out] = system([cmd s]);
if(length(out) ~= 81)
    disp('error');
else
    disp('solved');
    disp(out);
    for i=1:length(out)
        i1 = idivide(int16(i), 9)+1;
        i2 = mod(i, 9);
        if i2 == 0
           i2 = 9;
           i1 = i1-1;
        end
        if A(i2, i1) == 0
            k = str2num(out(i));
            i2 = 76*(i2-1)+50;
            i1 = 76*(i1-1)+100;
            system(['adb shell input tap ' '' num2str(i2) ' ' num2str(i1)]);
            system(['adb shell input tap ' '' num2str(tap(k,1)) ' ' num2str(tap(k,2))]); 
        end
    end
end
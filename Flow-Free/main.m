SIZE = 6;
radius = [47 52; 38 42; 32 36; 27 32];
r1 = radius(SIZE-4,1);
r2 = radius(SIZE-4,2);
%disp([r1 r2]);
system('adb shell screencap -p /sdcard/flowfree.png');
system('adb pull /sdcard/flowfree.png');
im = imread('flowfree.png');
im = imcrop(im, [0 204 720 720]);
red = im(:,:,1);
green = im(:,:,2);
blue = im(:,:,3);
i1 = (red == 0 & blue == 255 & green == 0) | (red == 128 & blue == 128 & green == 0);

size = idivide(int16(720), SIZE, 'fix');
grid = zeros(SIZE);

[centres, radii] = imfindcircles(im, [r1 r2],'ObjectPolarity', 'bright', 'Sensitivity', 0.96);
[c1, rad1] = imfindcircles(i1, [r1 r2], 'Sensitivity', 0.96);

centres = cat(1,centres, c1);
radii = cat(1, radii, rad1);

colors = [255 0 0 1; 0 128 0 2; 0 0 255 3; 238 238 0 4; 255 127 0 5; 128 0 128 6; 0 255 255 7; 165 42 42 8; 255 0 255 9];

for i=1:idivide(numel(centres), int16(2), 'fix')
   x = idivide(int16(centres(i,1)), size, 'fix')+1;
   y = idivide(int16(centres(i,2)), size, 'fix')+1;
   % disp([centres(i,1) centres(i,2)]);
   % disp([x y]);
   grid(y,x) = colorindex(colors, im( int16(centres(i,2)), int16(centres(i,1)), :));
   %disp([int16(centres(i,2)) int16(centres(i,1))]);
end
str = num2str(SIZE);
for i=1:SIZE
    for j=1:SIZE
        str = strcat(str, num2str(grid(i,j)));
    end
end
disp(str);
% str format must be -> 1st char represent size of grid e.g, for 6x6 it is 6
% rest of 36 length long string is each cell value 
system(['flow.exe ' str]);

clear;
grid = '6,6,5,2';
index = 2;
system('adb shell screencap -p /sdcard/unblock.png');
system('adb pull /sdcard/unblock.png');

i = imread('unblock.png');
Im = imcrop(i, [26, 323, 670, 670]);
%ImBW = im2bw(Im);
ImBW = Im(:,:,2) < 10;

S = regionprops(ImBW,'BoundingBox','Area');
%disp(S.BoundingBox);
grid = mark(grid, S, 1);

ImBW = Im(:, :, 1) > 220;
ImBW = imfill(ImBW,'holes');
S = regionprops(ImBW,'BoundingBox','Area');

for in=1:numel(S)
    if S(in).Area > 5000
        grid = mark(grid, S(in), 0);
    end
end
[status,out] = system(['usolver.exe ' grid]);
disp(out);
count =0;
for ix=1:4:length(out)
    y1 = str2num(out(ix)) * 112 + 56+326;
    x1 = str2num(out(ix+1)) * 112 +56+26;
    y2 = str2num(out(ix+2)) *112 +56+326;
    x2 = str2num(out(ix+3)) *112 +56+26;
    system(['adb shell input swipe ' '' num2str(x1) ' ' num2str(y1) ' ' num2str(x2) ' ' num2str(y2) ' 100']);
end
system('adb shell input swipe 150 600 700 600 100');
system('adb shell input swipe 550 600 700 600 100');
system('adb shell input swipe 350 600 700 600 100');
%disp(count);

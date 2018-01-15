function [cropped] = retriveImage(a, b, board)
%retriveImage returns image at specified tile
%   [image] = retriveImage(a, b)
% a -> column index value of tile
% b -> row index value of tile
% cropped -> image on the tile

halfCropWidth = round(400/board.size(1));
index = b+(a-1)*(board.size(1)+1);

% Tap that specific tiles
system(['adb shell input tap ' num2str(board.centerX(index)) ' ' ...
                               num2str(board.centerY(index))]);
pause(0.1);
% Save image
system('adb shell screencap -p /sdcard/screen1.png');
% Pull image
system('adb pull /sdcard/screen1.png');

img = imread('screen1.png');
cropped = imcrop(img, [board.centerX(index)-halfCropWidth, ...
                       board.centerY(index)-halfCropWidth, ... 
                       halfCropWidth*2, halfCropWidth*2]);
imshow(cropped)

end


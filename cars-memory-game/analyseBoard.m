function [board] = analyseBoard(image, show)
%analyseBoard Finds the size of board and tiles positions
%   [board] = analyseBoard(image, show)
% image -> input image of the board
% show -> display analysis images
% board -> structure having properties of the board
% board.centerX -> X locations of tiles
% board.centerY -> Y locations of tiles
% board.size -> number of tiles in (m x n) format

if(nargin==1)
    show = 0;
end

%% Detecting the tile on the closed tile using thresholding

% RGB values of the tile
valLow = [228, 100, 90];
valCar = [238, 110, 98];
valHigh = [256, 125, 110];

% Thresholding
bi = image(:,:,1) > valLow(1) & image(:,:,1) < valHigh(1) & ...
     image(:,:,2) > valLow(2) & image(:,:,2) < valHigh(2) & ...
     image(:,:,3) > valLow(3) & image(:,:,3) < valHigh(3);
 
if(show == 1)
    figure, imshow(bi);
end

% Enhancing to make the whole car one blob
en = imfill(bi, 'holes');
en = bwmorph(en, 'erode', 15);
if(show == 1)
    figure, imshow(en);
end

% Finding the size of board
stats = regionprops(en, 'Centroid');
for i = 1:numel(stats)
    board.centerX(i) = stats(i).Centroid(1);
    board.centerY(i) = stats(i).Centroid(2);
end

if(numel(stats) == 20)
    board.size = [4, 5];
elseif(numel(stats) == 12)
    board.size = [3, 4];
elseif(numel(stats) == 6)
    board.size = [2, 3];
else
    board.size = [0, 0];
    disp('Error 1: Unable to analyse board.');
    disp(stats)
end

end


%% Code for solving the memory game for cars

% Clearing up
clear all
close all
clc

% Finding size of board and locations of tiles
system('adb shell screencap -p /sdcard/screen1.png');
system('adb pull /sdcard/screen1.png');
input = imread('screen1.png');
board = analyseBoard(input);

%% Retriving images of all tiles
complete = false;
count = 0;
tiles = cell(board.size(1), board.size(2));
for a = 1:board.size(1)
    for b = 1:board.size(2)
        tiles{a, b} = retriveImage(a, b, board);
    end
end

%% Display board
for j = 1:board.size(2)
    for i = 1:board.size(1)
        subplot(board.size(2), board.size(1), i+(j-1)*board.size(1))
        imshow(tiles{i,j})
    end
end

%% Extracting histograms of each image
board.tiles = board.size(1)*board.size(2);
histTiles = cell(board.tiles,1);
for a = 1:board.size(1)
    for b = 1:board.size(2)
        histTiles{b+(a-1)*(board.size(1)+1)} = imhist(tiles{a, b}(:,:,1));
    end
end

%% Finding similarity
differences = 100000*ones(board.tiles);
for i = 1:board.tiles
    for j = i+1:board.tiles
        differences(i,j) = sum(abs(histTiles{i}(20:240)-histTiles{j}(20:240)));
    end    
end

%% Tapping similar images
k = 1:20;
for i = 1:board.tiles
    if(sum(k==i)>=1)
        [val, pos] = min(differences(i,:));
        if(val < 5000)
            disp(['Tap: (' num2str(i) ', ' num2str(pos) ')']);
          system(['adb shell input tap ' num2str(board.centerX(i)) ' ' ...
                               num2str(board.centerY(i))]);
          
          pause(0.3);                 
          system(['adb shell input tap ' num2str(board.centerX(pos)) ' ' ...
                               num2str(board.centerY(pos))]);
          pause(0.3);  
        end
        k = k(k~=i & k~=pos);
    end
end
% algorithm for the android game move

while 1
    
    clear all %% Clear all variables
    close all %% Close all open figures
    clc %% Clear command window

   % takes the screen shot and converts it into a matrix
     
    system('adb shell screencap -p /sdcard/screen.png');
    system('adb pull /sdcard/screen.png');
    input = imread('screen.png');
    system('adb shell rm /screen.png');
    
    figure
    imshow(input);
    
   % length and breadth of the screenshot
    
    length = size(input,1);
    width = size(input,2);
    matrixSize = 3;

   % crops the 'no of moves required to get a perfect' part and converts
   % it into grayscale image
    
    line = imcrop(input,[width*0.6 length*0.7 width*0.39 length*0.05]);
    line = rgb2gray(line);
    
    figure
    imshow(line);
    
   % using optical character reader function the characters are extracted from
   % the pic and the no number of moves required is converted to an integer
   % from string 
    
    results = ocr(line);
    nMoves = results.Words(2);
    nMoves = str2num(nMoves{1});
    
   % crops the main game part and converts it into gray scale 

    roi = imcrop(input,[1 length*0.1255 width-1 length*0.5594]);
    roi = rgb2gray(roi);
    
    figure
    imshow(roi);
  
   % length and breadth of the scroped image
    roiX = size(roi,1);
    roiY = size(roi,2);

   % creates a matrix for the balls
   
    balls = zeros(matrixSize,matrixSize);
    
   % to find the position of the balls by checking the color index in each
   %  box of the main game 
    
    for i = 1:size(balls,1)
        for j = 1:size(balls,2)
            x = round(roiX/(2*size(balls,2)) + (i-1)*roiX/size(balls,1));
            y = round(roiY/(2*size(balls,2)) + (j-1)*roiY/size(balls,2));
          
     
            balls(i,j) = 1*(roi(x,y)==151 || roi(x,y)==212) + 2*(roi(x,y)==84) + ...
                3*(roi(x,y)==192) + 4*(roi(x,y)==230) + 5*(roi(x,y)==181);
        end
    end

   % creates a matrix for the background
   
    map = zeros(matrixSize,matrixSize);
   
    
   % to find the type of background by checking the color index in each
   % box of the main game
    
    for i = 1:size(map,1)
        for j = 1:size(map,2)
            x = round(roiX/(2*size(map,2)) + (i-1)*roiX/size(map,1));
            y = round(roiY*(0.1)/(2*size(map,2)) + (j-1)*roiY/size(map,2));
           
            map(i,j) = (roi(x,y)==25)*1 + (roi(x,y)==100||roi(x,y)==88)*6 ...
            + (roi(x,y)==55 || roi(x,y)==60)*5 + (roi(x,y)==109 || roi(x,y)==125)*4 ...
            + (roi(x,y)==128 || roi(x,y)==148)*3 + (roi(x,y)==103 || roi(x,y)==119)*2;
        end
    end
 
    % displays the matrix 
    
    disp(balls), disp(map);

    maxBalls = 7;

    possibilities = 1;
    solution = zeros(nMoves, 1);
     
    % the probability of the moves possible
    
    for i = 1:nMoves
        possibilities = possibilities * 4;
    end
    
    disp(nMoves), disp(solution), disp(possibilities);
    nBalls = 0;
    
    % finding the solution 
    
    for i = 1:possibilities
        tempSol = zeros(matrixSize, matrixSize);
        for r = 1:matrixSize
            for c = 1:matrixSize
                tempSol(r,c) = balls(r,c);
                if(balls(r,c) >= 1)
                    nBalls = nBalls + 1;
                end
            end
        end
        for j = 1:nMoves
            if(solution(j,1) == 0) % UP
                for row = 2:matrixSize
                    for col = 1:matrixSize
                        if((map(row - 1, col) >= 1) && tempSol(row, col) >= 1 && tempSol(row - 1,col) == 0)
                            tempSol(row - 1,col) = tempSol(row, col);
                            tempSol(row, col) = 0;
                        end
                    end
                end
            end
            if(solution(j,1) == 1) % DOWN
                for row = matrixSize-1:-1:1
                    for col = 1:matrixSize
                        if((map(row + 1, col) >= 1) && tempSol(row,col) >= 1 && tempSol(row + 1,col) == 0)
                            tempSol(row + 1,col) = tempSol(row, col);
                            tempSol(row, col) = 0;
                        end
                    end
                end
            end
            if(solution(j,1) == 2) % RIGHT
                for row = 1:matrixSize
                    for col = matrixSize-1:-1:1
                        if((map(row, col + 1) >= 1)&& tempSol(row,col) >= 1 && tempSol(row, col + 1) == 0)
                            tempSol(row, col + 1) = tempSol(row, col);
                            tempSol(row, col) = 0;
                        end
                    end
                end
            end
            if(solution(j,1) == 3) % LEFT
                for row = 1:matrixSize
                    for col = 2:matrixSize
                        if((map(row, col - 1) >= 1) && tempSol(row, col) >= 1 && tempSol(row, col - 1) == 0)
                            tempSol(row, col - 1) = tempSol(row, col);
                            tempSol(row, col) = 0;
                        end
                    end
                end
            end
        end

        nThrees = 0;

        for row = 1:matrixSize
            for col = 1:matrixSize
                if(tempSol(row, col) + map(row, col) == maxBalls)
                    nThrees = nThrees + 1;
                end
            end
        end
        if(nThrees == nBalls)
            break;
        end
        nBalls = 0;
        solution(nMoves, 1) = rem((solution(nMoves, 1) + 1), 4);
        for it = nMoves-1:-1:1
            if(solution(it + 1, 1) == 0)
                solution(it, 1) = rem((solution(it, 1) + 1), 4);
            end
            if(solution(it + 1, 1) > 0)
                break;
            end
        end
    end

    disp(solution);

    %% Part 3 - simulating touch
    for i = 1:nMoves
        c = width/2;
        s = solution(i);
        system(['adb shell input swipe ' num2str(c) ' ' ...
            num2str(c) ' ' num2str(c+200*((s==2)-(s==3))) ' '...
            num2str(c+200*((s==1)-(s==0))) ' 100']);
    end
    pause(0.5);
    system(['adb shell input swipe 687 883 687 883 10']);
    pause(0.5);
end



% solution
% 0 = up %
% 1 = down %
% 2 = right %
% 3 = left %


 

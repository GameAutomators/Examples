# Sudoku


### Game Description
This is a single player game. The player has to solve sudoku mazes (9x9 grid).

![Grid](/Images/grid.png)

The objective of sudoku is to enter a digit from 1 through 9 in each cell, in such a way that:

 Each horizontal row (shown in pink) contains each digit exactly once.

 Each vertical column (shown in yellow) contains each digit exactly once.

 Each subgrid or region (shown in green) contains each digit exactly once.


Playstore Link: [Sudoku](https://play.google.com/store/apps/details?id=le.lenovo.sudoku&hl=en)
![Playstore](/Images/playstore_sudoku.png) 

![Image](/Images/sudo.png)

#### Difficulty level
Moderate

#### Overview
First , using Image Processing all the numbers are recognized with their locations .  Using algorithm sudoku is solved and the numbers are maked in concerned box using adb tool.


#### Requirements
- Computer with MATLAB, ADB Tool, Python and required drivers set up.
- An Android Device with the ‘Sudoku’ game installed on it. (Turn on the Developer options for better visualization)
- USB data transfer cable.

#### Block Diagram

![BlockDiagram](/Images/BlockDiagram.png)

#### Tutorial
##### Step 1: Using ADB Tool to capture screenshot
The following command instantaneously takes the screenshot of the connected device and stores it in the SD card following the specified path.
  
```
system(' adb shell screencap -p /sdcard/screen.png ');
```

The following command pulls it from the SD card of the android device into the working system following the path specified

```
system(' adb pull /sdcard/screen.png ');
```
  
The pulled image is stored in the form of a matrix of pixel values by the MATLAB.
                
                
##### Step 2: Image processing

Once the screenshot is obtained, smallest unit box is been croped out for recognization of number on it , using "OCR" (Optical Character Recognition) 
```matlab
	a = rgb2gray(cimg);
    results = ocr(a ,'TextLayout','Block');
    rs2 = ocr(a,'TextLayout','Word');
     
    if(isempty(results.Words))
        A(i,j)=0;
    else
        A(i,j) = str2double(results.Words);
    end
    % bcoz ocr with block option is not detecting '8'
    if(8 == str2double(rs2.Words))
        A(i,j) = 8;
    end;
```

command, and recognized number is been stored in 9 x 9 matrix.

##### Step 3: Algorithm

```
  Find row, col of an unassigned cell
  If there is none, return true
  For digits from 1 to 9
    a) If there is no conflict for digit at row,col
        assign digit to row,col and recursively try fill in rest of grid
    b) If recursion successful, return true
    c) Else, remove digit and try another
  If all digits have been tried and nothing worked, return false
```

The algorithm checks all the possible ways using backtrack and tries to solve it under given rules. and solved matrix is returned.
The code is written in python. it takes command line string input of length 81 and return string output of same length. using following commands.

```
%  s is input string.
cmd = 'python sudoku.py ';
[status,out] = system([cmd s]);
```

##### Step 4: Using ADB Tool to simulate touch
The following command taps at the point on the screen with the co-ordinates mentioned as (x, y) and then tap  on that specific number which is to be put there from bottom of screen. This is used to simulate touch at the appropriate points where we want to place the number.

```
tapping on empty box for filling number 
system(' adb shell input tap x y ');

tapping on number which is to be filled in empty box
system(' adb shell input tap x y ');
``` 
###### Step 5: Test
Open game on your device and run matlab script.
```
>>> solver.m
``` 

This game is tested on 1280x720 Moto G3 and works fine. for other device, manipulated cordinated of cells and numbers

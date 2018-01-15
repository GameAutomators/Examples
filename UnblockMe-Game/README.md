## Unblockme

### Game Description

This is a single player game. The goal is to unblock the red block out of the board by sliding the other blocks out of the way, unblock it with the minimal moves.

**Playstore Link:** [Unblockme](https://play.google.com/store/apps/details?id=com.kiragames.unblockmefree)

![Playstore](/Images/playstore_unblockme.png) 
![Image](/Images/unblock.png)

**Difficulty level**: Moderate

You can see a demo video of the working of this game at the following link: https://youtu.be/_-aNdgeLc5w

<div class="row" style="text-align:center;">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/_-aNdgeLc5w" frameborder="0" allowfullscreen></iframe>
</div> 

### Overview

First, using image processing all the blocks alignment and position is detected using image processing in MATLAB. Using breadth first search algorithm, the game is solved and blocks are moved to free the red block. The swipes on the screen are simulated using adb tool.

### Requirements

- Computer with MATLAB, ADB Tool, C++ and required drivers set up.
- An Android Device with the ‘Unblock ME’ game installed on it. (Turn on the Developer options for better visualization)
- USB data transfer cable.

### Block Diagram

![BlockDiagram](/Images/BlockDiagram.png)

### Tutorial

Here's the step-wise tutorial to automate the game.

#### Step 1: Using ADB Tool to capture screenshot

The following command instantaneously takes the screenshot of the connected device and stores it in the SD card following the specified path.

```matlab
system(' adb shell screencap -p /sdcard/screen.png ');
```

The following command pulls it from the SD card of the android device into the working system following the path specified.

```MATLAB
system(' adb pull /sdcard/screen.png ');
```
  
The pulled image is stored in the form of a matrix of pixel values by the MATLAB.
                
#### Step 2: Image processing

After taking screenshot main part of game is cropped out. Since Target block is of almost red color. So for specially that block, red color thresholding is performed.

```MATLAB
ImBW = Im(:,:,2) < 10;
S = regionprops(ImBW,'BoundingBox','Area');
```

S.BoundingBox gives the x, y, width and height of target block. 

Now to detect other blocks position other color thresholding is applied.

```MATLAB
ImBW = Im(:, :, 1) > 220;
ImBW = imfill(ImBW,'holes');
S = regionprops(ImBW,'BoundingBox','Area');

for in=1:numel(S)
    if S(in).Area > 5000
        % take only those block whose Area is > 5000 since regionprops may detect small no. of rectangles. 
    end
end
```

#### Step 3: Algorithm

The algorithm uses a simple breadth first search to find a particular order of moves to free the red block.

```
	Enqueue the current board
	while Q not empty:
    	Dequeue a board and examine it
    	can block escape?
        	he can! Ok
    	he cant?
        	for each possible board that can arise out of this one
            	add board to END of Q
```

The code is written in C++. It takes command line string input and return string have order of moves. Using following commands in matlab we can run C++ program.

```MATLAB
%  s is input string.
cmd = 'unblock.exe ';
[status,out] = system([cmd s]);
```

#### Step 4: Using ADB Tool to simulate touch

The following command swipes from the point (x1,y1) on the screen to the point (x2, y2). 

```MATLAB
system(['adb shell input swipe ' '' num2str(x1) ' ' num2str(y1) ' ' num2str(x2) ' ' num2str(y2) ' 100']);
```

### Conclusions

This way, the game is automated. The code works for all levels in the game. You can run the code in a loop to solve all the 500 levels available in the game at once.
### Test
compile unblockme.cpp using g++ or c++ command 
```
g++ unblockme.cpp -o unblock.exe
```
The Game is tested on android device 1280x720 Moto G3. So for other device image processing code may change.


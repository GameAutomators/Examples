# Bowling 3D


### Game Description
Number of players in this game may vary from one to four. In case of multiplayer everybody will get alternate chance to throw a ball. In this game 10 targets are kept vertically maximum of which should fall down after being hit by the ball. 

Playstore Link: [Bowling 3D] (https://play.google.com/store/apps/details?id=com.magmamobile.game.Bowling3D&hl=en)

![Playstore](/Images/tttps.png) 
![Image](/Images/tttim.png)



#### Difficulty level
Moderate



#### Overview
We find the centroid of the target, and then align the ball along the centroid ,then we  swipe it  straight across the screen.

#### Requirements
- Computer with MATLAB, ADB Tool and required drivers set up.
- An Android Device with the ‘Bowling 3D’ game installed on it. (Turn on the Developer options for better visualization)
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
The white colored targets are cropped and its centroid is calculated and the ball is moved horizontally  using adb commands such that its centroid aligns with that of target and then it is swiped straight . 
##### Step 3: Using ADB Tool to simulate touch
The following command moves the ball horizontally
```
system('adb shell input swipe  x1 y1 x2 y1');
```
where (x1,y1) is the centroid of the ball and x2 is the x coordinate of center of the target.
Now when the ball is aligned, to move it straight towards the  target it is swiped using the following commands.

```
system('adb shell input swipe  x2 y1 x2 y2  ');
```      

y2 is the y coordinate of center of the target.


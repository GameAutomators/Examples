# Stick Hero Game Automated


### Game Description
This is a Sigle Player Game.

Playstore Link: [Stick Hero](https://play.google.com/store/apps/details?id=com.ketchapp.stickhero&hl=en)

![Playstore](/Images/stick_play.png) 
![Image](/Images/stick_hero.png)

#### Difficulty level
Easy

#### Overview

Stretch the stick in order to reach and walk on the platforms. Watch out! If the stick is not long enough, you will fall down!

#### Requirements
- Computer with OpenCV-Python, [Numpy](https://github.com/numpy/numpy), ADB Tool and required drivers set up.
- An Android Device with the Stick Hero game installed on it. (Turn on the Developer options for better visualization)
- USB data transfer cable.

#### Block Diagram

![BlockDiagram](/Images/BlockDiagram.png)

#### Tutorial
##### Step 1: Using ADB Tool to capture screenshot
The following command instantaneously takes the screenshot of the connected device and stores it in the SD card following the specified path.
  
```
	system(' adb shell screencap -p /sdcard/stick.png ');
```

The following command pulls it from the SD card of the android device into the working system following the path specified

```
system(' adb pull /sdcard/stick.png ');
  ```
  
The pulled image is stored in the form of a matrix of pixel values by the Opencv.
```
	img = cv2.imread('stick.png');
```
                
                
##### Step 2: Image processing

Once the screenshot is obtained, Position of Player and Target Pole centre is calculated using image processing.

##### Step 3: Algorithm

Distance between player and target pole center is calculated and touch is simulated according to linear equation.
```
dist = posPlayer - posTarget
touch_time = 1.430*dist;

```

##### Step 4: Using ADB Tool to simulate touch

The following command presses at the point on the screen with the co-ordinates mentioned as (x, y). This is used to simulate for touch_time
```
	system('adb shell input swipe 360 640 360 640 '+str(touch_time))
```
#### Testing

After connecting your phone to laptop with satisfied envrionment.
check phone is connected or not, with command

```bash
	adb devices
``` 
if device is connected and not authorized it will show in output otherwise it will show device-id and device.

###### Now start game and click play and run the script stick_solver.py

```bash
	python stick_solver.py
```

The Game was tested on 1280x720 android device ( Moto G3 ).
So for other device calculate area (in my case 100,800 to 700,820 pixel on device (x,y) format) for processing the
image and finding distance between player and target block centre.

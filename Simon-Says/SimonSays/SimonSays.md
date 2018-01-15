# Simon Says
Documenation for the game __Simon Says__, solved by __Team al_MASS__ for Hackathon 5.0

### Introduction
Simon Says is a classic memory game, wherein the user is required to press a set of 4 coloured blocks in a specified sequence, starting with a single element; which goes on increasing as time passes, thus making it difficult for the user to remember the sequence.

### Screenshot of the Game
![alt text](https://raw.githubusercontent.com/sreetamdas/al_MASS/master/SimonSays/Screenshot_SimonSays.jpg "Simon Says")

Playstore Link : https://play.google.com/store/apps/details?id=com.Category5Games.MemoryBlock

Difficulty Level : __Moderate__

### Overview
The Game is **_hacked_** by detecting the *sequence* using __LDRs__(Light Dependent Resistor) or __Photo Resistor__ and an [Arduino Board](https://www.arduino.cc/) and storing it dynamically, and then replicating it on the touchscreen using __ADB__(Android Debug Bridge) in the same sequence.
Since the sequence in which the color blocks light up is stored in an array, the *best score* of the Game is beyond Human capacity, and only bound by the size of the Array.

### Requirements
4 __LDRs__, Connecting Wires, Resistors, BreadBoard, Computer with __MATLAB__, __ADB__ Tool, __Arduino__ Software and required drivers set up. An Android Device with the ‘MemoryBlock: Simon Says’ game installed on it.  
Turn on the Developer options and allow USB Debugging in order to use ADB Tools. Keep a USB data transfer cable handy. 

## Block Diagram

![alt text](https://raw.githubusercontent.com/sreetamdas/al_MASS/master/SimonSays/BlockDiagram.jpg "Block Diagram")

## Tutorial

### Step 1: Detecting the Sequence
The sequence is deetected with the help of the Arduino, by first setting a threshold for all the four LDRS. These are then mounted on top of the Touchscreen correspoding to the color: `Blue`, `Green`, `Yellow` and `Red`.  
The sequence *(change in intensity of the color of the blocks)* gets detected by the LDRs, which is then transmitted to the Arduino. 

### Step 2: Transmission and Interpretation

The Arduino is programmed to transmit an Array to the computer `Serial Monitor` output after it detects a long pause after switch-like changes in the color blocks for a period of time.  
The computer takes in the input from the Arduino using MATLAB's Serial Monitor. This input is then processed using `functions` which are user-defined in MATLAB.

### Step 3: Simulating Touch using ADB Tools
Once the input is processed, the `coordinates` of where the touch needs to be simluated are known.  
The touch is simulated using `adb` with the following commands in MATLAB:  

    system(['adb shell input swipe ' xy ' 375 625 100']);
    
where `xy` defines the coordinates of the individual color block element in the sequence, such as for our setup: 

    Blue    : 200 450
    Green   : 550 450
    Yellow  : 550 800
    Red     : 200 800
    
In the example, the `375 625` corresponds to the center between the four color blocks, and `100` is the duration of the swipe in `milliseconds`.
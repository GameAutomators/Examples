# Sudoku

Documentation for the Problem Statement by Team al_MASS during Hackathon 5.0
<br><br>
<b>Introduction:-</b>
This is basically one of the most played games in the world. In today’s session, we will be demonstrating how to hack the game “Sudoku Free” which is easily available on Google Playstore. The game is pretty simple and requires nothing much except following the normal rules of Sudoku- a digit once entered shouldn’t be repeated in its corresponding row and column.<br><br>
Playstore Link :  https://play.google.com/store/apps/details?id=le.lenovo.sudoku&hl=en<br><br>
Difficulty Level: Hard<r>



<b>Overview:</b>
The system’s perfect move is identified by using Image processing, the further move is calculated by the algorithm and is marked in the concerned box using ADB Tool. This continues as the algorithm tries to win the game in the best way possible. This game functions completely independently, i.e. it is not depend on any of the user’s input. The simulation will take place automatically and the game will be solved no matter what the level may be.
NOTE: The world’s most difficult Sudoku has also been solved using this automated circuit. 
#TRIEDnTESTED
<br><br><br><br>
<b>Screenshot</b> of the Game:<br>
![alt tag](https://raw.githubusercontent.com/sreetamdas/al_MASS/master/doc1.png)
<br><br><br><br>
<b>Requirements:</b>
Computer with MATLAB, ADB Tool and required drivers set up. An Android Device with the ‘Sudoku Free’ game installed on it. (Turn on the Developer options for better visualization) Keep a USB data transfer cable handy.
<br><br><br><br>
<b>Block Diagram</b>
![alt tag](https://raw.githubusercontent.com/sreetamdas/al_MASS/master/doc.png)
<br><br><br><br>
<b>Tutorial</b><br><br>
<b>Step 1: Using ADB Tool to capture screenshot</b>
The following command instantaneously takes the screenshot of the connected device and stores it in the SD card following the specified path.<br>
`system(' adb shell screencap -p /sdcard/screen.png ');`<br><br><br>
The following command pulls it from the SD card of the android device into the working system following the path specified.<br>
`system(' adb pull /sdcard/screen.png ');`<br><br><br>
The pulled image is stored in the form of a matrix of pixel values by the MATLAB.
<br><br><br>
<b>Step 2: Image processing and ADB Tool.</b>
Once the screenshot is obtained, the algo of the code is programmed in such a way that it automatically generates the missing numbers in the Sudoku and auto fills the other matrices.

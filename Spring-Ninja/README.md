# Spring Ninja Game Automated

Jump, Jump, Jump ...

### Game Description
This is a simple platform game, Ninja wants to cross deadly river, he can jump from one pole to other by pressing screen for some milliseconds to gain velocity and it follows Projectile Motion.

Playstore Link: [Spring Ninja](https://play.google.com/store/apps/details?id=com.ketchapp.springninja&hl=en)

![Image](/Images/spring1.png)
![Image](/Images/spring2.png)

#### Difficulty level
Medium

#### Overview

Compress (press the screen) the spring so that Ninja can jump to next Pole.

#### Requirements
- Computer with OpenCV-Python, Scikit-Learn, ADB Tool and required drivers set up.
- An Android Device with the Spring Ninja game installed on it. (Turn on the Developer options for better visualization)
- USB data transfer cable.

#### Block Diagram

![BlockDiagram](/Images/BlockDiagram.png)

#### Tutorial
##### Step 1: Using ADB Tool to capture screenshot
The following command instantaneously takes the screenshot of the connected device and stores it in the SD card following the specified path.

```python
  from subprocess import call
  call(['adb', 'shell', 'screencap', '/sdcard/spring.png'])
```

The following command pulls it from the SD card of the android device into the working system following the path specified

```python
	from subprocess import call
	call(['adb', 'pull', '/sdcard/spring.png'])
```

The pulled image is stored in the form of a matrix of pixel values by the Opencv.
```python
	im = cv2.imread('spring.png')
```


#### Step 2: Image processing

Once the screenshot is obtained, Position of Player and Pole and Target Pole centre is calculated using color masking and Contours Finding Method.
```python
lower = np.array([64, 235, 189]) # BGR code for top color of Pole
upper = np.array([68, 239, 193])
# Mask top of pole and find contours
mask = cv2.inRange(im, lower, upper)
image,contours,h = cv2.findContours(mask.copy(),cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
points = []
for i,cnt in enumerate(contours):
    peri = cv2.arcLength(cnt, True)
    approx = cv2.approxPolyDP(cnt, 0.05 * peri, True)
    if len(approx) == 2:
        x = (approx[0][0][0] + approx[1][0][0])/2
        y = (approx[0][0][1] + approx[1][0][1])/2
        points.append((x,y))
```

#### Step 3: Algorithm

1. I generated some dataset manually and approximation. like if horizonatal and vertical distance between two pole is (x,y) then time would be by Projectile Path of trajectory.
```python
import math
def get_time(x,y,angle=60):
    t = 4.9/(x*math.tan(math.radians(angle)) - y)
    t = math.sqrt(t)
    t *= x/math.cos(math.radians(angle))
    return t*7 # constant multiplying factor
```

This data was not accurate for some case it worked and most of the case It didn't.

So I thought of using Machine Learning Neural Network (BackPropagation).

![BackPropagation](/Images/backpropagation.png)

Backpropagation is a common method of training artificial neural networks and used in conjunction with an optimization method such as gradient descent. The algorithm repeats a two phase cycle, propagation and weight update. When an input vector is presented to the network, it is propagated forward through the network, layer by layer, until it reaches the output layer. The output of the network is then compared to the desired output, using a loss function, and an error value is calculated for each of the neurons in the output layer. The error values are then propagated backwards, starting from the output, until each neuron has an associated error value which roughly represents its contribution to the original output.

I added a [dataset](/data.csv), we are going to train our **neural network** using this
dataset.
```python
	# train_X: contains horizontal and vertical distance between two poles
	# train_y: time in milliseconds to goto from one pole to other
	from sklearn.neural_network import MLPRegressor
    regr = MLPRegressor(solver='lbfgs', hidden_layer_sizes=50, max_iter=1000, random_state=1)
	regr.fit(train_X, train_y)
```

#### Step 4: Using ADB Tool to simulate touch

The following command presses at the point on the screen with the co-ordinates mentioned as (360, 640). This is used to simulate for touch_time
```python
	# x: horizontal distance
	# y: vertical distance
	time = int(regr.predict([[x,y]]))
    cmd = ['adb', 'shell', 'input', 'swipe', '360', '640', '360', '640']
    cmd.append(str(time))
    call(cmd)
```
### Testing

After connecting your phone to laptop with satisfied envrionment.
check phone is connected or not, with command

```bash
	adb devices
```
if device is connected and not authorized it will show in output otherwise it will show device-id and device.

##### Now start game and click play and run the solver script

```bash
	python spring.py
```

The Game was tested on 1280x720 android device (Moto G3), for other device, color and position may change

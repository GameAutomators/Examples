import cv2
import numpy as np

from os import system

'''
	Author: Rajmani Arya
	Date: 13 Feb, 2016
'''


def move(k):
	print k
	system("adb shell screencap -p /sdcard/stick.png")
	system("adb pull /sdcard/stick.png")

	img = cv2.imread('stick.png')
	img = img[800:820, 100:700]

	lower = np.array([25, 25, 240])
	upper = np.array([30, 30, 250])
	mask = cv2.inRange(img, lower, upper) # Thresholding Red Color Block which is at centre of target block
	'''
	calculation of starting position of player
	if color of image becomes other than black that means it is starting point
	'''
	i = 0
	while img[15][i][2] == 0:
		i += 1
	# print i

	image,contours,h = cv2.findContours(mask.copy(),cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
	length = 0
	''' Since only one target block is there in a move so after detecting that break the loop'''
	for cnt in contours:
	    peri = cv2.arcLength(cnt, True)
	    approx = cv2.approxPolyDP(cnt, 0.05 * peri, True)

	    if len(approx)==4:
	        cv2.drawContours(img, [approx], -1, (0, 255, 0), 4)
	        # print approx
	        # print cv2.contourArea(cnt)
	        length = approx[0][0][0]+approx[3][0][0] 
	        # getting average of start of end length of small red block of target
	        length = int(round(length/2))
	        break

	# print length-i
	i = int(1.430*(length-i))  # Touch time calculation you can calibrate it
	# print i # 
	system("adb shell input swipe 360 640 360 640 "+str(i))
	# cv2.imshow('image', img)
	# cv2.waitKey(0)
	# cv2.destroyAllWindows()

from time import sleep
'''
 Checking for only 200 moves
'''
for k in range(0, 200):
	move(k)
	sleep(2.7) # After player moved to next block so sleep

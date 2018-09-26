# -*- coding: utf-8 -*-
"""
Created on Wed Sep 26 13:47:17 2018

@author: CV_LAB_Howard
"""

import cv2
import numpy as np

## Read
img = cv2.imread("xylophone_640_480.jpg")

## convert to hsv
hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

lower_green = np.array([90, 160, 90])
upper_green = np.array([110, 175, 115])

lower_brown = np.array([145, 90, 70])
upper_brown = np.array([155, 95, 85])


## mask of green (36,0,0) ~ (70, 255,255)
mask1 = cv2.inRange(hsv, lower_green, upper_green)

## mask o yellow (15,0,0) ~ (36, 255, 255)
mask2 = cv2.inRange(hsv, lower_brown, upper_brown)

## final mask and masked
mask = cv2.bitwise_or(mask1, mask2)
target = cv2.bitwise_and(img,img, mask=mask)

cv2.imwrite("target.png", target)
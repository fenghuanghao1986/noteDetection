# -*- coding: utf-8 -*-
"""
Created on Tue Aug 21 12:15:03 2018

@author: fengh
"""

import cv2
import numpy as np

cap = cv2.VideoCapture(0)
#cap = cv2.imread('ball5.jpg',0)

# set blue thresh
lower_blue=np.array([78,43,46])
upper_blue=np.array([110,255,255])

while(1):
    # get a frame and show
    ret, frame = cap.read()
    cv2.imshow('Capture', frame)

    # change to hsv model
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # get mask
    mask = cv2.inRange(hsv, lower_blue, upper_blue)
    cv2.imshow('Mask', mask)

    # detect blue
    res = cv2.bitwise_and(frame, frame, mask=mask)
    cv2.imshow('Result', res)
    
    # press q to quit capture
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 16 22:38:37 2019

@author: CV_LAB_Howard
"""

import motion
import argparse
from naoqi import ALProxy

def main(robotIP, PORT=9559):
    motionProxy = ALProxy("ALMotion", robotIP, PORT)

    # Example showing how to get the end of the right arm as a transform
    # represented in torso space. The result is a 4 by 4 matrix composed
    # of a 3*3 rotation matrix and a column vector of positions.
    name  = 'LArm'
    frame  = motion.FRAME_TORSO
    useSensorValues  = True
    result = motionProxy.getTransform(name, frame, useSensorValues)
    print(result)



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--ip", type=str, default="127.0.0.1",
                        help="Robot ip address")
    parser.add_argument("--port", type=int, default=9559,
                        help="Robot port number")

    args = parser.parse_args()
    main(args.ip, args.port)
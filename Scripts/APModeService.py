import RPi.GPIO as GPIO
import subprocess

#Pin Definitions
buttonPin = 17 #Pin 11 on pi

#Pin Setup
GPIO.setmode(GPIO.BCM)
GPIO.setup(buttonPin, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

while True:
    if GPIO.input(buttonPin):
        subprocess.call(['./Scripts/APMode Starting'])
        

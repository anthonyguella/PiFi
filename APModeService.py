import RPi.GPIO as GPIO
import subprocess

#Pin Definitions
buttonPin = 17 #Pin 11 on pi

#Variables
buttonPressed = False





def buttonPressed():
    subprocess.call(['./Scripts/EraseNetworks'])
    subprocess.call(['./Scripts/APMode start'])

def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(buttonPin, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

def main():
    setup()
    while True:
        if GPIO.input(buttonPin) and buttonPressed == False:
            buttonPressed = True
            buttonPressed()

main()

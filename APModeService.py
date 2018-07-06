import RPi.GPIO as GPIO
from flask import Flask, request
from threading import Thread
import subprocess

#Pin Definitions
buttonPin = 4 #Pin 7 on pi

#Variables
buttonPressed = False

app = Flask(__name__)

timer = threading.Timer(15.0, NetworkAdded)

# Hardware
def buttonPressed():
    print "Button Pressed"
    buttonPressed = True
    subprocess.call(['./Scripts/APMode start'])
    start_server()
    timer.start()

def setupHardware():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(buttonPin, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


# Server
@app.route("/")
def verify():
    return "pifi"

@app.route("/wifi/<ssid>", methods = ['POST'])
def postSSID(ssid):
    AddNetwork(ssid)
    return success

@app.route("/wifi/<ssid>/<password>", methods = ['POST'])
def postSSIDProtected(ssid, password):
    AddNetwork(ssid, password)
    return success

# Helper Functions
def AddNetwork(ssid, password):
    subprocess.call(['sudo',  './Scripts/AddNetwork', ssid, password])
    print "Network Added"
    NetworkAdded()

def NetworkAdded():
    isButtonPressed = False
    timer.cancel()
    stop_server

def start_server():
    app.run(host='0.0.0.0')
    print "Server Started"

def stop_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()
    print "Server Stopped"


# Main
if __name__ == '__main__':
    setupHardware()
    try:
        while True:
            if GPIO.input(buttonPin) and not buttonPressed:
                buttonPressed()
    except:
        stop_server()
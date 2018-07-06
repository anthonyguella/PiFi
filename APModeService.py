import RPi.GPIO as GPIO
from flask import Flask, request

#Pin Definitions
buttonPin = 17 #Pin 11 on pi

#Variables
buttonPressed = False

app = Flask(__name__)

# Hardware
def buttonPressed():
    buttonPressed = True
    subprocess.call(['./Scripts/EraseNetworks'])
    subprocess.call(['./Scripts/APMode start'])
    start_server()

def setup():
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
    subprocess.call(['./Scripts/AddNetwork', ssid, password])

def NetworkAdded():
    buttonPressed = False
    stop_server

def start_server():
    app.run(host='0.0.0.0')

def stop_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()


# Main
if __name__ == '__main__':
    setupHardware()
    setupWebserver()

    while True:
        if GPIO.input(buttonPin) and buttonPressed == False:
            buttonPressed()
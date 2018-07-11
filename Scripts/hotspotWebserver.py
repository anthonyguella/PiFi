from flask import Flask, request
import subprocess

app = Flask(__name__)

# Server
@app.route("/")
def verify():
    return "pifi"

@app.route("/wifi/<ssid>", methods = ['POST'])
def postSSID(ssid):
    AddNetwork(ssid)
    return "success"

@app.route("/wifi/<ssid>/<password>", methods = ['POST'])
def postSSIDProtected(ssid, password):
    AddNetwork(ssid, password)
    return "success"

# Helper Functions
def AddNetwork(ssid, password):
    subprocess.call(['sudo',  '/usr/bin/addNetwork.sh', "'" + ssid + "'", "'" + password + "'"])
    print "Network Added"
    NetworkAdded()

def NetworkAdded():
    stop_server
    subprocess.call(['sudo',  'reboot'])

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
    start_server()
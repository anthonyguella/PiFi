from flask import Flask, request, jsonify, json
import subprocess

app = Flask(__name__)

# Server
@app.route("/verify")
def verify():
    return "pifi"

@app.route("/getssids")
def getSSIDs():
    return parseSSID()

@app.route("/wifi/<ssid>", methods = ['POST'])
def postSSID(ssid):
    returnCode = AddNetwork(ssid)
    if returnCode == 0:
        return "success"
    else:
        return "failure"

@app.route("/wifi/<ssid>/<password>", methods = ['POST'])
def postSSIDProtected(ssid, password):
    returnCode = AddNetwork(ssid, password)
    if returnCode == 0:
        return "success"
    else:
        return "failure"

# Helper Functions
def AddNetwork(ssid, password):
    returnCode = subprocess.call(['sudo',  '/usr/bin/addNetwork.sh', ssid, password])
    NetworkAdded()
    return returnCode

def NetworkAdded():
    process = subprocess.Popen("sleep 3; sudo reboot", shell=True)

def start_server():
    app.run(host='0.0.0.0')
    print "Server Started"

def stop_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()
    print "Server Stopped"

def subprocess_cmd(command):
    process = subprocess.Popen(command,stdout=subprocess.PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    print proc_stdout

def parseSSID():
    returnCode = subprocess.call(["sudo iwlist wlan0 scan > /tmp/scanOutput"], shell=True)
    if returnCode != 0:
        return []
    else:
        inputFile = open("/tmp/scanOutput")
        networksDict = []
        ssid = ""
        protected = True

        for line in inputFile:
            line = line.strip()
            if "ESSID:" in line:
                ssid = line[7:-1]
                if ssid != "":
                    newEntry = {'ssid': ssid,
                                'protected': protected
                                }
                    dupFlag = False
                    for entry in networksDict:
                        if entry['ssid'] == ssid:
                            dupFlag = True
                    if not dupFlag:
                        networksDict.append(newEntry)
            if "Encryption key:" in line:
                if line[15:] == "on":
                    protected = True
                else:
                    protected = False
        return jsonify(networks=networksDict)


# Main
if __name__ == '__main__':
    start_server()
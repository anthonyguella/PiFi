import os
import subprocess

NET_DIR='/sys/class/net'

print; print 'reload daemon'
subprocess.call(['sudo','systemctl','daemon-reload'])

print 'stop dhcpcd'
subprocess.call(['sudo','systemctl','stop','dhcpcd.service'])

print

for net_dev in os.listdir(NET_DIR):

  print net_dev

  print 'flush old ip' 
  subprocess.call(['sudo','ip','addr','flush','dev',net_dev])

  print 'restart dhcpcd'
  subprocess.call(['sudo','systemctl','restart','dhcpcd.service'])
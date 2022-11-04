from datetime import datetime
from psutil import disk_usage, sensors_battery, boot_time
from psutil._common import bytes2human
from subprocess import check_output
from sys import stdout
from time import sleep, time
from netifaces import interfaces, ifaddresses, AF_INET
from os import uname, getloadavg
import alsaaudio

def write(data):
    stdout.write('%s\n' % data)
    stdout.flush()


# noinspection PyBroadException
def refresh():
    disk = bytes2human(disk_usage('/').free)
    disk_percent = bytes2human(disk_usage('/').percent)  # used

    interface = {}
    for ifaceName in interfaces():
        if ifaceName[0:2] == 'lo': continue
        addresses = [i['addr'] for i in ifaddresses(ifaceName).setdefault(AF_INET, [{'addr': 'No IP addr'}])]
        interface[ifaceName[0:7]] = ', '.join(addresses)
    try:
        ssid = check_output("iwgetid -r", shell=True).strip().decode("utf-8")
        for iface in interface.keys():
            try:
                freq = check_output("iwconfig wlp60s0 | grep Frequency | cut -d: -f3 | cut -d\" \" -f1-2", stderr=None, shell=True).strip().decode("utf-8")
                signal = check_output("iwconfig wlp60s0 | grep Signal | cut -d= -f3", stderr=None, shell=True).strip().decode("utf-8")
                ap_info = signal + '❙' + freq
            except:
                ap_info = "No data"
    except Exception:
        ssid = "None"
    try:
        ip_public = check_output("curl -s ifconfig.me", shell=True).strip().decode("utf-8")
    except:
        ip_public = "None"

    battery = int(sensors_battery().percent)
    status = "Charging" if sensors_battery().power_plugged else "Discharging"
    date = datetime.now().strftime('%a %F %H:%M')

    load = getloadavg()[0]
    uptime = int((time() - boot_time())/3600)
    kernel = uname().release[0:5]

    v = alsaaudio.Mixer()
    vol = v.getvolume()[0]

    m = alsaaudio.Mixer()
    mute = m.getmute()[0]

    if vol < 10 or mute == 1:
        vol_ico = '🔇' # mute
    elif vol > 80:
        vol_ico = '🔊' # volume max
    else:
        vol_ico = '🔉' # volume

    pkg = check_output("/usr/lib/update-notifier/apt-check 2>&1", shell=True).strip().decode("utf-8").split(';')

    if pkg[1] == 0:
        pkg_update = "%s update (%s security)" % (pkg[0], pkg[1])
    else:
        pkg_update = "%s updates" % (pkg[0])

    # Uptime; kernel version; status Battery (%); Volume; date
    interface_print = ' ❙ '.join(['{0}: {1}'.format(k, v) for k,v in interface.items()])
    format = "%s ❙ %sh ⬆ %s 🐧 %s 📈 %s (%s%% used) 📂 Public: %s ❙ 💻 %s (%s❙%s📶) %s%% %s 🔋 📅 %s %s"
    write(format % (pkg_update, uptime, kernel, load, disk, disk_percent[:-1], ip_public, interface_print, ssid, ap_info, battery, status, date, vol_ico))

while True:
    refresh()
    sleep(1)

# 💻 filaire
# 📶 Wiki
# 💡 luminosité
# ↑
# ⬆ uptime
# ❙
# 🐧kernel
# 🔋 charge
# 🔌 Secteur
# ⚡
# ⏳ time
# 📅 date
# 📂 disk
# 📈 load avg

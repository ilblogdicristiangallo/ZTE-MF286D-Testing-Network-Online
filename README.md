# ZTE-MF286D-Testing-Network-Online
The script is compatible with all 4G mobile SIM cards with OpenWrt installed, tested on ZTE MF286D.

The script automatically monitors and resets all SIMs with the WWAN interface (named this way because virtual interfaces on OpenWrt follow this naming convention), but actually the script stops the physical WAN interface to try to avoid Very Mobile and WindTre SIMs dropping to 3G, as happened in my case. It can always be used to try to keep the Very Mobile SIM in 4G instead of 3G. The script timings can be extended according to the SIM you have, just modify the sleep `sleep 10800 # 3 hours` in the written code.

**The script can be loaded using several methods:**

**Via LuCI Web Interface**: Go to System → Startup → rc.local and add the script path to execute at boot

**Via PuTTY/SSH in /etc/init.d/**: 
- Connect via PuTTY to your router
- Create the script file: `vi /etc/init.d/wwan-reset`
- Make it executable: `chmod +x /etc/init.d/wwan-reset`
- Enable at startup: `/etc/init.d/wwan-reset enable`

**Via PuTTY/SSH in root directory**:
- Connect via PuTTY to your router
- Create the script file in any directory: `vi /root/wwan-reset.sh`
- Make it executable: `chmod +x /root/wwan-reset.sh`
- Add to crontab or rc.local to run at boot

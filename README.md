The script works with all 4G SIM cards running OpenWrt and has been tested on the ZTE MF286D.

It automatically monitors the internet connection on all SIMs via the WWAN interface (this is the name OpenWrt uses for mobile network interfaces).

Basically, the script stops and restarts the physical WAN interface to prevent some SIMs — like Very Mobile and WindTre — from dropping from 4G to 3G, which happened in my case.

Remember:

Very Mobile and WindTre SIMs with the APN internet.it use NAT, and their IP address changes every 4 hours.

"Denat" SIMs with the APN myinternet.wind change their IP every 24 hours.

Important note: The connection will only drop to 3G if using the qmi package for managing the modem. With modemmanager, the connection never falls to 3G, as you can specifically choose to aggregate only the 4G network. Therefore, if you experience a drop to 3G, you are likely using the qmi package.

This script is designed to prevent the connection from falling back to 3G in some areas when the 4G network (using qmi or modemmanager on OpenWrt) disconnects due to an IP change — something I personally experienced.

You can use this script to try to keep your Very Mobile SIM connected on 4G instead of dropping to 3G.

How it works:
On modemmanager: The behavior of falling to 3G does not occur because you can define in the modemmanager configuration to only aggregate the 4G network. However, the rest of the script is still useful for both qmi and modemmanager, because the SIM still changes its IP every 4 hours or 24 hours depending on whether it is NAT or Denat by the operator.

Recommendation:
If you are using regular data SIMs (not Denat) with the APN internet.it (such as Very Mobile), this script forces an IP change by stopping the WAN interface. This allows the interface to change the IP correctly without needing other packages like watchcat or similar.

The time between each restart in the script is set by the sleep 10800 command, which equals 3 hours. You can also set it to 3 hours and 40 or 50 minutes — just modify the value in the code. The script is open and customizable for everyone.

What the script does (simple explanation):
Continuously checks if the internet connection is working by sending ping requests to a server.

If the connection fails, it restarts the WAN interface (turns the data connection off and on).

If restarting the WAN interface doesn’t restore the connection, it reboots the whole router.

Every 3 hours by default, it automatically resets the WAN interface to keep the connection stable and ideally on 4G.

You can change the reset interval by editing the sleep value inside the script.

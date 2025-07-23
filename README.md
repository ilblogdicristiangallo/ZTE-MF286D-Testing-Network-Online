# ZTE-MF286D-Testing-Network-Online
The script is compatible with all 4G mobile SIM cards with OpenWrt installed, tested on ZTE MF286D.

The script automatically monitors and resets all SIMs with the WWAN interface (named this way because virtual interfaces on OpenWrt follow this naming convention), but actually the script stops the physical WAN interface to try to avoid Very Mobile and WindTre SIMs dropping to 3G, as happened in my case. It can always be used to try to keep the Very Mobile SIM in 4G instead of 3G. The script timings can be extended according to the SIM you have, just modify the sleep `sleep 10800 # 3 hours` in the written code.

The script can be loaded from the rc.local settings in the Startup menu of Luci via OpenWrt or added via PuTTY in the `/etc/init.d/` folder where the system saves startup scripts.

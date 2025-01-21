# lanip
A simple utility for retrieving IP addresses on a local network.

## Installation
You can install ```lanip``` script (and ```wlanip```, a lazy shortcut to ```lanip -w```) simply running this command:
```bash
sudo ./install.sh
```
Once installed, you can launch ```lanip``` and follow the instructions on the screen. The first run will create the
config file, located in ```~/.config/lanip.conf``` and the instructions will guide you to properly edit this file to
tell lanip the network interface from which to collect the address.

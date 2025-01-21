#!/bin/bash

set -e

cp lanip.sh /usr/local/bin/lanip
cp wlanip   /usr/local/bin/wlanip

chmod 755 /usr/local/bin/lanip /usr/local/bin/wlanip

echo "lanip: installation completed."

exit 0

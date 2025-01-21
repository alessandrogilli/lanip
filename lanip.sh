#!/bin/bash

set -e

CONF=$HOME/.config/lanip.conf

if [[ ! -f $CONF ]]; then
    echo "No config file found. Creating an empty config file in $CONF"
    echo "Please run 'ip --br a' to check your network interfaces and properly edit the config file."
    echo "A valid config file could be:"
    echo ""
    echo "LAN=enp3s0f0"
    echo "WLAN=wlp1s0"
    echo ""
    echo "LAN=" > $CONF
    echo "WLAN=" >> $CONF
    exit 1
fi

source $CONF

if [[ ! $LAN || ! $WLAN ]]; then
    echo "Config file not set. You can find it here $CONF"
    echo "Please run 'ip --br a' to check your network interfaces and properly edit the config file."
    echo "A valid config file could be:"
    echo ""
    echo "LAN=enp3s0f0"
    echo "WLAN=wlp1s0"
    echo ""
    exit 2
fi

help() {
    echo "Usage: lanip [OPTIONS]"
    echo ""
    echo "A simple utility for retrieving IP addresses on a local network."
    echo ""
    echo "Options:"
    echo "  --help	-h	Show this help and exit."
    echo "  --lan 	-l	Show IP address of the configured network interface. [Default]"
    echo "  --wlan	-w	Show IP address of the configured wireless network interface."
    echo ""
}

get_ip() {
    ip --br a | grep $IFACE | awk -F'/' '{print $1}' | awk '{print $3}'
}


if [[ $# -gt 1 ]]; then
	echo "Too many arguments."
	help
	exit 3
fi

case "$1" in
	--help | -h)
        help
        ;;
    --lan | -l | "")
        IFACE=$LAN
        get_ip
        ;;
    --wlan | -w)
        IFACE=$WLAN
        get_ip
        ;;
    *)
        echo "\"$1\" not a valid option"
        help
        exit 4
esac

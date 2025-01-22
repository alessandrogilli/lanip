#!/bin/bash

set -e

CONF="$HOME/.config/lanip.conf"

if [[ ! -f $CONF ]]; then
    echo "No config file found. Creating an empty config file in $CONF"
    echo "Please run 'ip --br a' to check your network interfaces and properly edit the config file."
    echo "A valid config file could be:"
    echo ""
    echo "LAN=enp3s0f0"
    echo "WLAN=wlp1s0"
    echo ""
    echo "LAN=" >"$CONF"
    echo "WLAN=" >>"$CONF"
    exit 1
fi

source $CONF

help() {
    echo "Usage: lanip [OPTIONS] [INTERFACE_NAME]"
    echo ""
    echo "A simple utility for retrieving IP addresses on a local network."
    echo ""
    echo "Options:"
    echo "  --help	-h	Show this help and exit."
    echo "  --lan 	-l	Show IP address of the configured network interface. [Default]"
    echo "  --wlan	-w	Show IP address of the configured wireless network interface."
    echo "  <interface_name>	Show IP address of the provided interface."
    echo ""
}

get_ip() {
    if [[ ! $IFACE ]]; then
        echo "Config file does not define a $IFACE_NAME interface. You can find it here $CONF"
        echo "Please run 'ip --br a' to check your network interfaces and properly edit the config file."
        echo "A valid config file could be:"
        echo ""
        echo "LAN=enp3s0f0"
        echo "WLAN=wlp1s0"
        echo ""
        exit 2
    fi
    IP="$(ip --br a | grep "$IFACE" | awk -F'/' '{print $1}' | awk '{print $3}')"
    if [[ -z $IP ]]; then
        echo "No IP found for $IFACE_NAME interface \"$IFACE\"."
        exit 4
    else
        echo "$IP"
    fi
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
    IFACE="$LAN"
    IFACE_NAME="LAN"
    get_ip
    ;;
--wlan | -w)
    IFACE="$WLAN"
    IFACE_NAME="WLAN"
    get_ip
    ;;
*)
    IFACE="$1"
    IFACE_NAME="user-provided"
    get_ip
    ;;
esac

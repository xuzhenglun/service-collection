#!/usr/bin/env bash

set -exm

# setup dbus
mkdir -p /run/dbus
test -f /run/dbus/pid && rm /run/dbus/pid
dbus-daemon --config-file=/usr/share/dbus-1/system.conf

# setup tun device
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# start warp daemon
warp-svc --accept-tos &
sleep 3s # to wait warp start

# configurate warp
warp-cli --accept-tos status
warp-cli --accept-tos registration new
warp-cli --accept-tos mode warp+doh
warp-cli --accept-tos connect
warp-cli --accept-tos status
warp-cli --accept-tos stats

# test it
while true; do
  if curl https://www.cloudflare.com/cdn-cgi/trace/ | grep warp=on; then
	break
  fi
  sleep 1s
done

# bring warp deamon back to foreground
fg

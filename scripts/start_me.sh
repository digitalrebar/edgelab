#!/usr/bin/env bash

SSID=$1
PASSWORD=$2

if [[ "$SSID" == "" ]] ; then
    ERROR=1
    echo "Must provide SSID as first parameters"
fi
if [[ "$PASSWORD" == "" ]] ; then
    ERROR=1
    echo "Must provide PASSWORD as second parameters"
fi
if [[ $ERROR == 1 ]] ; then
    echo "Usage: $0 SSID PASSWORD"
    exit 1
fi

# Remove cloud-init if it shows up
rm -f /etc/netplan/50-*

# Make sure cloud-init won't start again.
touch /etc/cloud/cloud-init.disabled

# Add wifi netplan piece.
cat > /etc/netplan/20-netplan.yaml <<EOF
network:        
  version: 2    
  renderer: networkd
  wifis:        
    wlan0:      
      dhcp4: yes        
      dhcp6: no 
      access-points:
        "${SSID}":
          password: "${PASSWORD}"
EOF

echo "Applying networking configuration...."
netplan apply

COUNT=0
echo "Waiting for wifi connection to start...."
while ! ping -c 1 get.rebar.digital 2>/dev/null >/dev/null; do
  COUNT=$((COUNT+1))
  if (( $COUNT > 60 )) ; then
      echo "Failed to connect to internet...."
      exit 1
  fi
  sleep 3
done

if ! which jq ; then
  echo "Adding a jq processor..."
  ln -s /usr/local/bin/drpcli /usr/local/bin/jq
fi

echo "Getting and Installing latest DRP..."
curl -fsSL get.rebar.digital/tip | bash -s -- --start-runner --systemd --startup --bootstrap --drp-version=tip install

echo "Getting Edge-lab content"
drpcli catalog item install edge-lab --version=tip >/dev/null

echo "Setting workflow on DRP Endpoint to bootstrap system..."
drpcli machines list | jq -r '.[].Uuid' | while read mac
do
    drpcli machines workflow $mac edge-lab-bootstrap >/dev/null
done

IP=$(ip a | grep "inet " | grep global | grep dynamic | head -1 | awk -F/ '{ print $1 }' | awk '{ print $2 }')
echo "Ready to access...  connect to https://$IP:8092"
echo "Check the machine's status in the UX to see the results of bootstrapping."

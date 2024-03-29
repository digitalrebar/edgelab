#!/usr/bin/env bash
# Copyright RackN 2020
# License APLv2
# Version 1.3

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

# Local Base is much faster for setups where Wifi is not reliable
LOCALBASE="http://10.3.14.2:8091"
echo "Check for local install files before using Wifi"
if curl --output /dev/null --silent --head --fail "$LOCALBASE/files/bootstrap/install.sh"; then
  echo "Using Local Install Files from $LOCALBASE"
  curl -fsSL $LOCALBASE/files/bootstrap/dr-provision.zip -o dr-provision.zip
  curl -fsSL $LOCALBASE/files/bootstrap/install.sh | bash -s -- --start-runner --systemd --startup --bootstrap --drp-version=tip --zip-file=dr-provision.zip --ipaddr=10.3.14.1 install
  echo "Upload ISOs from $LOCALBASE"
  for iso in sledgehammer-9b5276ac5826520829aa73c149fe672fe2363656.arm64.tar sledgehammer-9b5276ac5826520829aa73c149fe672fe2363656.rpi4.tar sledgehammer-e21d2b7f079dfcbd2952dbc79d09a793cd8fe7da.amd64.tar; do
    drpcli isos upload $LOCALBASE/isos/$iso to $iso
  done
  echo "Upload Extras from $LOCALBASE"
  for content in edge-lab.yaml task-library.yaml; do
    if [[ "$(curl -fsSLk -o /dev/null -w %{http_code} $LOCALBASE/files/bootstrap/$content 2>/dev/null)" == "200" ]]; then
      echo "uploading $content"
      drpcli contents upload $LOCALBASE/files/bootstrap/$content
    else
      echo "did not find $content, skipping"
    fi
  done
  for file in k3s-arm64 helm-arm64 k3s-amd6 helm-amd64; do
    if [[ "$(curl -fsSLk -o /dev/null -w %{http_code} $LOCALBASE/files/$file/$file 2>/dev/null)" == "200" ]]; then
      echo "uploading $file"
      drpcli files upload $LOCALBASE/files/$file/$file to $file/$file
    else
      echo "did not find $file, skipping"
    fi
  done
else
  # download URL locations; overridable via ENV variables
  URL_BASE=${URL_BASE:-"https://rebar-catalog.s3-us-west-2.amazonaws.com"}
  URL_BASE_CONTENT=${URL_BASE_CONTENT:-"$URL_BASE/drp-community-content"}
  DRP_CATALOG=${DRP_CATALOG:-"$URL_BASE/rackn-catalog.json"}

  while ! curl -fsSL -o /dev/null $DRP_CATALOG ; do
    echo "Failed to get catalog file."
    sleep 4
  done

  echo "Downloading and Installing latest DRP..."
  curl -fsSL get.rebar.digital/tip | bash -s -- --start-runner --systemd --startup --bootstrap --drp-version=tip --ipaddr=10.3.14.1 install
fi

echo "Installed DRP Version $(drpcli info get | jq -r .version)"

drpcli catalog item install edge-lab --version=tip >/dev/null

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

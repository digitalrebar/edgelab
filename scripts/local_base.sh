#!/usr/bin/env bash
# Copyright RackN 2020
# License APLv2
# Version 1.0

# Caches files to local DRP to speed start_me process

# Local Base is much faster for setups where Wifi is not reliable
echo "Get latest isos"
drpcli bootenvs uploadiso sledgehammer

echo "Get latest install components"

curl -fsL repo.rackn.io --compressed -o rackn-catalog.json
SOURCE=$(cat rackn-catalog.json | jq -r '.sections.catalog_items["drp-tip"].Source')
echo "uploading dr-provision zip from $SOURCE"
drpcli files upload $SOURCE as bootstrap/dr-provision.zip
rm rackn-catalog.json

echo "uploading install.sh from get.rebar.digital/tip"
drpcli files upload https://get.rebar.digital/tip as bootstrap/install.sh

echo "Upload files into local DRP"
for f in k3s helm; do
  if [[ -f "$f" ]]; then
    echo "Found $f, uploading"
    drpcli files upload $f as "$f/$f"
  else
    drpcli files upload http://10.3.14.1:8091/files/$f/$f as "$f/$f" || true
    echo "No $f, trying to download from Edge Lab on 10.3.14.1"
  fi
done

echo "done"
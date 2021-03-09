#!/bin/bash

# ./VerthashMiner -u 3NRZzUYhoFyA9aL7edLA9D4SwcNfAwhhNf.$HOSTNAME -p x -o stratum+tcp://mining.hashalot.net:3950 --verthash-data verthash.dat --all-cl-devices
HOSTNAME=${HOSTNAME:-docker}
DAT_LOCAL_PATH=/data/verthash.dat

NEXUS_MD5_SUM=$(curl -s https://nexus-jamie.elastiscale.net/service/rest/v1/search?repository=mining-repo | jq -r '.items[] | select(.name=="verthashminer/verthash.dat") | .assets[0].checksum.md5')
NEXUS_DL_URL=$(curl -s https://nexus-jamie.elastiscale.net/service/rest/v1/search?repository=mining-repo | jq -r '.items[] | select(.name=="verthashminer/verthash.dat") | .assets[0].downloadUrl')

mkdir -p /data
[ "$(md5sum $DAT_LOCAL_PATH | awk '{print $1}')" == "$NEXUS_MD5_SUM" ] || curl -L -o $DAT_LOCAL_PATH $NEXUS_DL_URL

ARGS="-u $WALLET_ADDRESS.$HOSTNAME -p x -o $POOL --verthash-data $DAT_LOCAL_PATH --all-cl-devices"
[ -n "$EXTRA_OPTS" ] && ARGS="$ARGS $EXTRA_OPTS"

COMMAND="/home/miner/VerthashMiner $ARGS"

echo $COMMAND
exec $COMMAND


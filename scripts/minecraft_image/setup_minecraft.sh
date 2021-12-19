#!/bin/bash

docker container run \
    -e EULA=TRUE \
    --restart unless-stopped \
    -e TYPE=CURSEFORGE \
    -e CF_SERVER_MOD="PO3 - 3.4.4server.zip" \
    -e UID=1000 \
    -e GID=1000 \
    -v /data/server:/data \
    -d \
    itzg/minecraft-server \
    minecraft
    
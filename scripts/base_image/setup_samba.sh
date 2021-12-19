#!/bin/bash
export $(cat /secrets/.smbpass | xargs)

mkdir -p /data/server

docker container run \
    --name samba \
    --restart unless-stopped \
    -p 139:139 \
    -p 445:445 \
    -e USERID=1000 \
    -e GROUPID=1000 \
    -v /data/server:/data/server \
    -d \
    dperson/samba \
    -p \
    -u "george;$SAMBA_PASSWORD" \
    -s "data;/data/server;yes;no;no;george;george;george"